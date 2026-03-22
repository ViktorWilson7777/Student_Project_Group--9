package simulator;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;

public final class CredentialLoader {
    private CredentialLoader() {}

    public static List<Credential> load(Path path) throws IOException {
        List<Credential> out = new ArrayList<>();
        List<String> lines = Files.readAllLines(path);
        for (String line : lines) {
            String raw = line.trim();
            if (raw.isEmpty() || raw.startsWith("#")) continue;
            if (raw.toLowerCase().startsWith("email,")) continue;
            String[] parts = raw.split(",", 2);
            if (parts.length != 2) {
                throw new IllegalArgumentException("Invalid users.csv line: " + raw);
            }
            out.add(new Credential(parts[0].trim(), parts[1].trim()));
        }
        if (out.isEmpty()) {
            throw new IllegalArgumentException("No credentials found in " + path);
        }
        return out;
    }
}
