package simulator;

import java.io.IOException;
import java.util.concurrent.Callable;

public class ScenarioRunner implements Callable<ScenarioResult> {
    private final int taskId;
    private final Credential credential;
    private final SimulatorConfig config;

    public ScenarioRunner(int taskId, Credential credential, SimulatorConfig config) {
        this.taskId = taskId;
        this.credential = credential;
        this.config = config;
    }

    @Override
    public ScenarioResult call() {
        long startedAt = System.currentTimeMillis();
        int variantId = config.randomVariantId();
        int quantity = config.randomQuantity();

        long loginMs = 0, addMs = 0, cartMs = 0, checkoutMs = 0, orderPageMs = 0;
        Stage stage = Stage.LOGIN;

        try {
            ShopeeHttpSession session = new ShopeeHttpSession(
                    config.baseUrl,
                    config.connectTimeout,
                    config.requestTimeout
            );

            long t = System.currentTimeMillis();
            var loginRes = session.postForm("/login", new HttpForm()
                    .add("username", credential.email())
                    .add("password", credential.password()), false);
            loginMs = System.currentTimeMillis() - t;

            boolean loginOk = loginRes.uri().toString().contains("/user-home")
                    || ShopeeHttpSession.bodyContains(loginRes.body(), "recommend products");
            if (!loginOk) {
                return fail(stage, variantId, quantity, loginMs, addMs, cartMs, checkoutMs, orderPageMs,
                        startedAt, "Login failed. Check users.csv or password.");
            }

            if (config.mode == SimulatorConfig.ScenarioMode.LOGIN_ONLY) {
                return success(variantId, quantity, loginMs, addMs, cartMs, checkoutMs, orderPageMs, startedAt,
                        "Login scenario completed");
            }

            stage = Stage.ADD_TO_CART;
            t = System.currentTimeMillis();
            var addRes = session.postForm("/add-to-cart", new HttpForm()
                    .add("variantId", String.valueOf(variantId))
                    .add("quantity", String.valueOf(quantity)), true);
            addMs = System.currentTimeMillis() - t;

            boolean addOk = ShopeeHttpSession.bodyContains(addRes.body(), "\"success\":true")
                    || ShopeeHttpSession.bodyContains(addRes.body(), "added to cart successfully")
                    || ShopeeHttpSession.bodyContains(addRes.body(), "đã thêm vào giỏ hàng");
            if (!addOk) {
                String body = safeSnippet(addRes.body());
                return fail(stage, variantId, quantity, loginMs, addMs, cartMs, checkoutMs, orderPageMs,
                        startedAt, "Add to cart failed: " + body);
            }

            stage = Stage.CART;
            t = System.currentTimeMillis();
            var cartRes = session.get("/cart");
            cartMs = System.currentTimeMillis() - t;
            boolean cartOk = cartRes.statusCode() == 200
                    && (ShopeeHttpSession.bodyContains(cartRes.body(), "shopping cart")
                    || ShopeeHttpSession.bodyContains(cartRes.body(), "checkout"));
            if (!cartOk) {
                return fail(stage, variantId, quantity, loginMs, addMs, cartMs, checkoutMs, orderPageMs,
                        startedAt, "Cart page failed");
            }

            stage = Stage.CHECKOUT;
            t = System.currentTimeMillis();
            var checkoutRes = session.postForm("/checkout", new HttpForm()
                    .add("receiverPhone", config.receiverPhone)
                    .add("shippingAddress", config.shippingAddress)
                    .add("paymentMethod", config.randomPaymentMethod()), false);
            checkoutMs = System.currentTimeMillis() - t;

            boolean checkoutOk = checkoutRes.uri().toString().contains("order-success.jsp")
                    || ShopeeHttpSession.bodyContains(checkoutRes.body(), "order placed successfully")
                    || ShopeeHttpSession.bodyContains(checkoutRes.body(), "order success");
            if (!checkoutOk) {
                return fail(stage, variantId, quantity, loginMs, addMs, cartMs, checkoutMs, orderPageMs,
                        startedAt, "Checkout failed: " + safeSnippet(checkoutRes.body()));
            }

            stage = Stage.ORDER_PAGE;
            t = System.currentTimeMillis();
            var orderRes = session.get("/order?status=ALL");
            orderPageMs = System.currentTimeMillis() - t;
            boolean orderOk = orderRes.statusCode() == 200
                    && (ShopeeHttpSession.bodyContains(orderRes.body(), "my orders")
                    || ShopeeHttpSession.bodyContains(orderRes.body(), "order total")
                    || ShopeeHttpSession.bodyContains(orderRes.body(), "to pay"));
            if (!orderOk) {
                return fail(stage, variantId, quantity, loginMs, addMs, cartMs, checkoutMs, orderPageMs,
                        startedAt, "Order page check failed");
            }

            return success(variantId, quantity, loginMs, addMs, cartMs, checkoutMs, orderPageMs,
                    startedAt, "Order scenario completed");

        } catch (IOException | InterruptedException e) {
            Thread.currentThread().interrupt();
            return fail(stage, variantId, quantity, loginMs, addMs, cartMs, checkoutMs, orderPageMs,
                    startedAt, e.getClass().getSimpleName() + ": " + e.getMessage());
        } catch (Exception e) {
            return fail(stage, variantId, quantity, loginMs, addMs, cartMs, checkoutMs, orderPageMs,
                    startedAt, e.getClass().getSimpleName() + ": " + e.getMessage());
        }
    }

    private ScenarioResult success(int variantId, int quantity, long loginMs, long addMs, long cartMs,
                                   long checkoutMs, long orderPageMs, long startedAt, String message) {
        return new ScenarioResult(taskId, credential.email(), variantId, quantity, true, Stage.COMPLETE,
                message, loginMs, addMs, cartMs, checkoutMs, orderPageMs,
                System.currentTimeMillis() - startedAt);
    }

    private ScenarioResult fail(Stage stage, int variantId, int quantity, long loginMs, long addMs, long cartMs,
                                long checkoutMs, long orderPageMs, long startedAt, String message) {
        return new ScenarioResult(taskId, credential.email(), variantId, quantity, false, stage,
                message, loginMs, addMs, cartMs, checkoutMs, orderPageMs,
                System.currentTimeMillis() - startedAt);
    }

    private static String safeSnippet(String body) {
        if (body == null) return "<empty body>";
        String compact = body.replaceAll("\\s+", " ").trim();
        return compact.length() <= 160 ? compact : compact.substring(0, 160) + "...";
    }
}
