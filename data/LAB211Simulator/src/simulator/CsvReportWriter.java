package simulator;

import java.io.BufferedWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;

public final class CsvReportWriter {
    private CsvReportWriter() {}

    public static void write(Path path, List<ScenarioResult> results) throws IOException {
        try (BufferedWriter w = Files.newBufferedWriter(path)) {
            w.write("taskId,email,variantId,quantity,success,stage,message,loginMs,addToCartMs,cartMs,checkoutMs,orderPageMs,totalMs");
            w.newLine();
            for (ScenarioResult r : results) {
                w.write(csv(r.taskId()) + ","
                        + csv(r.email()) + ","
                        + csv(r.variantId()) + ","
                        + csv(r.quantity()) + ","
                        + csv(r.success()) + ","
                        + csv(r.stage()) + ","
                        + csv(r.message()) + ","
                        + csv(r.loginMs()) + ","
                        + csv(r.addToCartMs()) + ","
                        + csv(r.cartMs()) + ","
                        + csv(r.checkoutMs()) + ","
                        + csv(r.orderPageMs()) + ","
                        + csv(r.totalMs()));
                w.newLine();
            }
        }
    }

    private static String csv(Object value) {
        String s = String.valueOf(value == null ? "" : value);
        s = s.replace("\"", "\"\"");
        return '"' + s + '"';
    }
}
