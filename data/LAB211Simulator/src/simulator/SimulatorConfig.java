package simulator;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.time.Duration;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Objects;
import java.util.Properties;
import java.util.concurrent.ThreadLocalRandom;

public class SimulatorConfig {
    public enum ScenarioMode { LOGIN_ONLY, PLACE_ORDER }

    public final String baseUrl;
    public final ScenarioMode mode;
    public final int concurrency;
    public final int totalTasks;
    public final List<Integer> variantIds;
    public final int minQuantity;
    public final int maxQuantity;
    public final String receiverPhone;
    public final String shippingAddress;
    public final List<String> paymentMethods;
    public final Duration connectTimeout;
    public final Duration requestTimeout;
    public final Path usersFile;
    public final Path reportFile;

    private SimulatorConfig(String baseUrl,
                           ScenarioMode mode,
                           int concurrency,
                           int totalTasks,
                           List<Integer> variantIds,
                           int minQuantity,
                           int maxQuantity,
                           String receiverPhone,
                           String shippingAddress,
                           List<String> paymentMethods,
                           Duration connectTimeout,
                           Duration requestTimeout,
                           Path usersFile,
                           Path reportFile) {
        this.baseUrl = stripTrailingSlash(baseUrl);
        this.mode = mode;
        this.concurrency = concurrency;
        this.totalTasks = totalTasks;
        this.variantIds = List.copyOf(variantIds);
        this.minQuantity = minQuantity;
        this.maxQuantity = maxQuantity;
        this.receiverPhone = receiverPhone;
        this.shippingAddress = shippingAddress;
        this.paymentMethods = List.copyOf(paymentMethods);
        this.connectTimeout = connectTimeout;
        this.requestTimeout = requestTimeout;
        this.usersFile = usersFile;
        this.reportFile = reportFile;
    }

    public static SimulatorConfig load(Path path) throws IOException {
        Properties p = new Properties();
        try (InputStream in = Files.newInputStream(path)) {
            p.load(in);
        }

        String baseUrl = required(p, "baseUrl");
        ScenarioMode mode = ScenarioMode.valueOf(p.getProperty("mode", "PLACE_ORDER").trim().toUpperCase());
        int concurrency = parsePositiveInt(p.getProperty("concurrency", "10"), "concurrency");
        int totalTasks = parsePositiveInt(p.getProperty("totalTasks", "50"), "totalTasks");
        int minQuantity = parsePositiveInt(p.getProperty("minQuantity", "1"), "minQuantity");
        int maxQuantity = parsePositiveInt(p.getProperty("maxQuantity", "1"), "maxQuantity");
        if (maxQuantity < minQuantity) {
            throw new IllegalArgumentException("maxQuantity must be >= minQuantity");
        }

        List<Integer> variantIds = parseIntList(required(p, "variantIds"));
        List<String> paymentMethods = parseStringList(p.getProperty("paymentMethods", "COD"));
        if (paymentMethods.isEmpty()) {
            paymentMethods = List.of("COD");
        }

        Duration connectTimeout = Duration.ofSeconds(parsePositiveInt(p.getProperty("connectTimeoutSeconds", "15"), "connectTimeoutSeconds"));
        Duration requestTimeout = Duration.ofSeconds(parsePositiveInt(p.getProperty("requestTimeoutSeconds", "30"), "requestTimeoutSeconds"));

        Path usersFile = path.getParent().resolve(required(p, "usersFile")).normalize();
        Path reportFile = path.getParent().resolve(p.getProperty("reportFile", "simulator-report.csv")).normalize();

        return new SimulatorConfig(
                baseUrl,
                mode,
                concurrency,
                totalTasks,
                variantIds,
                minQuantity,
                maxQuantity,
                p.getProperty("receiverPhone", "0901234567"),
                p.getProperty("shippingAddress", "FPT University"),
                paymentMethods,
                connectTimeout,
                requestTimeout,
                usersFile,
                reportFile
        );
    }

    public int randomVariantId() {
        return variantIds.get(ThreadLocalRandom.current().nextInt(variantIds.size()));
    }

    public int randomQuantity() {
        if (minQuantity == maxQuantity) return minQuantity;
        return ThreadLocalRandom.current().nextInt(minQuantity, maxQuantity + 1);
    }

    public String randomPaymentMethod() {
        return paymentMethods.get(ThreadLocalRandom.current().nextInt(paymentMethods.size()));
    }

    private static String stripTrailingSlash(String value) {
        String v = Objects.requireNonNull(value).trim();
        while (v.endsWith("/")) {
            v = v.substring(0, v.length() - 1);
        }
        return v;
    }

    private static String required(Properties p, String key) {
        String value = p.getProperty(key);
        if (value == null || value.trim().isEmpty()) {
            throw new IllegalArgumentException("Missing required config key: " + key);
        }
        return value.trim();
    }

    private static int parsePositiveInt(String raw, String name) {
        int value = Integer.parseInt(raw.trim());
        if (value <= 0) {
            throw new IllegalArgumentException(name + " must be > 0");
        }
        return value;
    }

    private static List<Integer> parseIntList(String raw) {
        List<Integer> out = new ArrayList<>();
        for (String part : raw.split(",")) {
            String t = part.trim();
            if (!t.isEmpty()) out.add(Integer.parseInt(t));
        }
        if (out.isEmpty()) {
            throw new IllegalArgumentException("variantIds must not be empty");
        }
        return out;
    }

    private static List<String> parseStringList(String raw) {
        return Arrays.stream(raw.split(","))
                .map(String::trim)
                .filter(s -> !s.isEmpty())
                .toList();
    }
}
