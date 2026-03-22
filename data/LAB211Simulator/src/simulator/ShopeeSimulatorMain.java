package simulator;

import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.*;
import java.util.concurrent.atomic.AtomicInteger;

public class ShopeeSimulatorMain {

    public static void main(String[] args) throws Exception {
        Path configPath = args.length > 0 ? Path.of(args[0]) : Path.of("config.properties");
        SimulatorConfig config = SimulatorConfig.load(configPath);
        List<Credential> credentials = CredentialLoader.load(config.usersFile);

        System.out.println("Loaded config from : " + configPath.toAbsolutePath());
        System.out.println("Base URL           : " + config.baseUrl);
        System.out.println("Mode               : " + config.mode);
        System.out.println("Concurrency        : " + config.concurrency);
        System.out.println("Total tasks        : " + config.totalTasks);
        System.out.println("Users loaded       : " + credentials.size());
        System.out.println("Variant IDs        : " + config.variantIds);
        System.out.println();

        ExecutorService pool = Executors.newFixedThreadPool(config.concurrency);
        List<Future<ScenarioResult>> futures = new ArrayList<>();
        AtomicInteger cursor = new AtomicInteger(0);

        long startedAt = System.currentTimeMillis();

        for (int taskId = 1; taskId <= config.totalTasks; taskId++) {
            Credential cred = credentials.get(cursor.getAndIncrement() % credentials.size());
            futures.add(pool.submit(new ScenarioRunner(taskId, cred, config)));
        }

        pool.shutdown();
        pool.awaitTermination(1, TimeUnit.HOURS);

        List<ScenarioResult> results = new ArrayList<>();
        for (Future<ScenarioResult> future : futures) {
            try {
                ScenarioResult r = future.get();
                results.add(r);
                System.out.printf("[%03d] %-5s user=%s variant=%d qty=%d stage=%s msg=%s%n",
                        r.taskId(),
                        r.success() ? "OK" : "FAIL",
                        r.email(),
                        r.variantId(),
                        r.quantity(),
                        r.stage(),
                        r.message());
            } catch (ExecutionException e) {
                throw new RuntimeException("A simulator task crashed", e.getCause());
            }
        }

        long wallClock = System.currentTimeMillis() - startedAt;
        CsvReportWriter.write(config.reportFile, results);
        SummaryPrinter.print(results, wallClock);
        System.out.println("CSV report written to: " + config.reportFile.toAbsolutePath());
    }
}
