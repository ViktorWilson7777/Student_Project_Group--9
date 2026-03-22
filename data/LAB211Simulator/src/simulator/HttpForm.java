package simulator;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.stream.Collectors;

public final class HttpForm {
    private final Map<String, String> fields = new LinkedHashMap<>();

    public HttpForm add(String key, String value) {
        fields.put(key, value == null ? "" : value);
        return this;
    }

    public String encode() {
        return fields.entrySet().stream()
                .map(e -> URLEncoder.encode(e.getKey(), StandardCharsets.UTF_8)
                        + "="
                        + URLEncoder.encode(e.getValue(), StandardCharsets.UTF_8))
                .collect(Collectors.joining("&"));
    }
}
