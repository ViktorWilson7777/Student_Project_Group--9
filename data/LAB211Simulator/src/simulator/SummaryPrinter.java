package simulator;

import java.util.EnumMap;
import java.util.List;
import java.util.Map;

public final class SummaryPrinter {
    private SummaryPrinter() {}

    public static void print(List<ScenarioResult> results, long wallClockMs) {
        long success = results.stream().filter(ScenarioResult::success).count();
        long fail = results.size() - success;

        Map<Stage, Long> failByStage = new EnumMap<>(Stage.class);
        for (ScenarioResult r : results) {
            if (!r.success()) {
                failByStage.merge(r.stage(), 1L, Long::sum);
            }
        }

        System.out.println("\n========== SIMULATOR SUMMARY ==========");
        System.out.println("Total tasks      : " + results.size());
        System.out.println("Success          : " + success);
        System.out.println("Fail             : " + fail);
        System.out.println("Wall clock (ms)  : " + wallClockMs);
        System.out.printf("Average total ms : %.2f%n", avg(results, ScenarioResult::totalMs));
        System.out.printf("Average login ms : %.2f%n", avg(results, ScenarioResult::loginMs));
        System.out.printf("Average cart ms  : %.2f%n", avg(results, ScenarioResult::cartMs));
        System.out.printf("Average checkout : %.2f%n", avg(results, ScenarioResult::checkoutMs));

        if (!failByStage.isEmpty()) {
            System.out.println("\nFailures by stage:");
            failByStage.forEach((stage, count) -> System.out.println("- " + stage + ": " + count));
        }

        System.out.println("=======================================\n");
    }

    private static double avg(List<ScenarioResult> results, java.util.function.ToLongFunction<ScenarioResult> f) {
        return results.stream().mapToLong(f).average().orElse(0.0);
    }
}
