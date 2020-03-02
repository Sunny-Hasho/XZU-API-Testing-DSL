import org.junit.jupiter.api.*;
import static org.junit.jupiter.api.Assertions.*;
import java.net.http.*;
import java.net.*;
import java.time.Duration;
import java.nio.charset.StandardCharsets;
import java.util.*;

public class GeneratedTests {
    static String BASE = "";
    static Map<String, String> DEFAULT_HEADERS = new HashMap<>();
    static HttpClient client;

    @BeforeAll
    static void setup() {
        client = HttpClient.newBuilder()
            .connectTimeout(Duration.ofSeconds(5))
            .build();
    }

    @Test
    void test_Login() throws Exception {
        HttpRequest.Builder b = HttpRequest.newBuilder(URI.create(BASE + "/api/login"))
            .timeout(Duration.ofSeconds(10))
            .POST(HttpRequest.BodyPublishers.ofString("200", StandardCharsets.UTF_8));
        for (var e : DEFAULT_HEADERS.entrySet()) {
            b.header(e.getKey(), e.getValue());
        }
        HttpResponse<String> resp = client.send(b.build(), HttpResponse.BodyHandlers.ofString(StandardCharsets.UTF_8));

        assertEquals(200, resp.statusCode());
        assertTrue(resp.headers().firstValue("Content-Type").orElse("").contains("json"));
        assertTrue(resp.body().contains("\"token\":"));
    }

}
