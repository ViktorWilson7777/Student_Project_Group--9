package simulator;

import java.io.IOException;
import java.net.CookieManager;
import java.net.CookiePolicy;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;
import java.util.Locale;

public class ShopeeHttpSession {
    public record Response(int statusCode, URI uri, String body) {}

    private final HttpClient client;
    private final String baseUrl;
    private final Duration requestTimeout;

    public ShopeeHttpSession(String baseUrl, Duration connectTimeout, Duration requestTimeout) {
        CookieManager cookieManager = new CookieManager();
        cookieManager.setCookiePolicy(CookiePolicy.ACCEPT_ALL);
        this.client = HttpClient.newBuilder()
                .cookieHandler(cookieManager)
                .connectTimeout(connectTimeout)
                .followRedirects(HttpClient.Redirect.ALWAYS)
                .build();
        this.baseUrl = baseUrl;
        this.requestTimeout = requestTimeout;
    }

    public Response get(String pathAndQuery) throws IOException, InterruptedException {
        HttpRequest req = HttpRequest.newBuilder(resolve(pathAndQuery))
                .timeout(requestTimeout)
                .header("User-Agent", "LAB211-Simulator/1.0")
                .GET()
                .build();
        HttpResponse<String> res = client.send(req, HttpResponse.BodyHandlers.ofString());
        return new Response(res.statusCode(), res.uri(), res.body());
    }

    public Response postForm(String path, HttpForm form, boolean ajax) throws IOException, InterruptedException {
        HttpRequest.Builder builder = HttpRequest.newBuilder(resolve(path))
                .timeout(requestTimeout)
                .header("User-Agent", "LAB211-Simulator/1.0")
                .header("Content-Type", "application/x-www-form-urlencoded");
        if (ajax) {
            builder.header("X-Requested-With", "XMLHttpRequest");
        }
        HttpRequest req = builder
                .POST(HttpRequest.BodyPublishers.ofString(form.encode()))
                .build();
        HttpResponse<String> res = client.send(req, HttpResponse.BodyHandlers.ofString());
        return new Response(res.statusCode(), res.uri(), res.body());
    }

    private URI resolve(String path) {
        try {
            if (path.startsWith("http://") || path.startsWith("https://")) {
                return new URI(path);
            }
            String normalized = path.startsWith("/") ? path : "/" + path;
            return new URI(baseUrl + normalized);
        } catch (URISyntaxException e) {
            throw new IllegalArgumentException("Invalid URI: " + path, e);
        }
    }

    public static boolean bodyContains(String body, String needle) {
        return body != null && body.toLowerCase(Locale.ROOT).contains(needle.toLowerCase(Locale.ROOT));
    }
}
