package simulator;

public record ScenarioResult(
        int taskId,
        String email,
        int variantId,
        int quantity,
        boolean success,
        Stage stage,
        String message,
        long loginMs,
        long addToCartMs,
        long cartMs,
        long checkoutMs,
        long orderPageMs,
        long totalMs
) {}
