import org.junit.jupiter.api.*;
import static org.junit.jupiter.api.Assertions.*;
import java.net.http.*;
import java.net.*;
import java.time.Duration;
import java.nio.charset.StandardCharsets;
import java.util.*;

public class GeneratedTests {
    static String BASE = "http://localhost:8080";
    static Map<String, String> DEFAULT_HEADERS = new HashMap<>();
    static HttpClient client;

    @BeforeAll
    static void setup() {
        client = HttpClient.newBuilder()
            .connectTimeout(Duration.ofSeconds(5))
            .build();
        DEFAULT_HEADERS.put("Content-Type", "application/json");
    }

    @Test
    void test_CreateUserWithMultiline() throws Exception {
        HttpRequest.Builder b = HttpRequest.newBuilder(URI.create(BASE + "/api/users"))
            .timeout(Duration.ofSeconds(10))
            .POST(HttpRequest.BodyPublishers.ofString("\r\n    {\r\n      \"id\": 42,\r\n      \"name\": \"John Doe\",\r\n      \"email\": \"john@example.com\",\r\n      \"role\": \"ADMIN\",\r\n      \"address\": {\r\n        \"street\": \"123 Main St\",\r\n        \"city\": \"New York\",\r\n        \"zip\": \"10001\"\r\n      },\r\n      \"preferences\": {\r\n        \"notifications\": true,\r\n        \"theme\": \"dark\"\r\n      }\r\n    }\r\n    ", StandardCharsets.UTF_8));
        for (var e : DEFAULT_HEADERS.entrySet()) {
            b.header(e.getKey(), e.getValue());
        }
        HttpResponse<String> resp = client.send(b.build(), HttpResponse.BodyHandlers.ofString(StandardCharsets.UTF_8));

        assertEquals(200, resp.statusCode());
        assertTrue(resp.body().contains("\"id\":42"));
        assertTrue(resp.body().contains("\"name\":\"John Doe\""));
    }

    @Test
    void test_CreateUserRegular() throws Exception {
        HttpRequest.Builder b = HttpRequest.newBuilder(URI.create(BASE + "/api/users"))
            .timeout(Duration.ofSeconds(10))
            .POST(HttpRequest.BodyPublishers.ofString("{ \"name\": \"Jane Doe\", \"email\": \"jane@example.com\" }", StandardCharsets.UTF_8));
        for (var e : DEFAULT_HEADERS.entrySet()) {
            b.header(e.getKey(), e.getValue());
        }
        HttpResponse<String> resp = client.send(b.build(), HttpResponse.BodyHandlers.ofString(StandardCharsets.UTF_8));

        assertEquals(200, resp.statusCode());
        assertTrue(resp.body().contains("\"name\":\"Jane Doe\""));
    }

    @Test
    void test_LoginWithMultiline() throws Exception {
        HttpRequest.Builder b = HttpRequest.newBuilder(URI.create(BASE + "/api/login"))
            .timeout(Duration.ofSeconds(10))
            .POST(HttpRequest.BodyPublishers.ofString("\r\n    {\r\n      \"username\": \"admin\",\r\n      \"password\": \"1234\"\r\n    }\r\n    ", StandardCharsets.UTF_8));
        for (var e : DEFAULT_HEADERS.entrySet()) {
            b.header(e.getKey(), e.getValue());
        }
        HttpResponse<String> resp = client.send(b.build(), HttpResponse.BodyHandlers.ofString(StandardCharsets.UTF_8));

        assertEquals(200, resp.statusCode());
        assertTrue(resp.headers().firstValue("Content-Type").orElse("").contains("json"));
        assertTrue(resp.body().contains("\"token\":"));
    }

    @Test
    void test_GetUserById() throws Exception {
        HttpRequest.Builder b = HttpRequest.newBuilder(URI.create(BASE + "/api/users/42"))
            .timeout(Duration.ofSeconds(10))
            .GET();
        for (var e : DEFAULT_HEADERS.entrySet()) {
            b.header(e.getKey(), e.getValue());
        }
        HttpResponse<String> resp = client.send(b.build(), HttpResponse.BodyHandlers.ofString(StandardCharsets.UTF_8));

        assertTrue(resp.statusCode() >= 200 && resp.statusCode() <= 299);
        assertTrue(resp.body().contains("\"id\":42"));
        assertTrue(resp.body().contains("\"username\":"));
    }

    @Test
    void test_UpdateUser() throws Exception {
        HttpRequest.Builder b = HttpRequest.newBuilder(URI.create(BASE + "/api/users/42"))
            .timeout(Duration.ofSeconds(10))
            .PUT(HttpRequest.BodyPublishers.ofString("\r\n    {\r\n      \"role\": \"ADMIN\",\r\n      \"updated\": true\r\n    }\r\n    ", StandardCharsets.UTF_8));
        for (var e : DEFAULT_HEADERS.entrySet()) {
            b.header(e.getKey(), e.getValue());
        }
        HttpResponse<String> resp = client.send(b.build(), HttpResponse.BodyHandlers.ofString(StandardCharsets.UTF_8));

        assertEquals(200, resp.statusCode());
        assertTrue(resp.headers().firstValue("Content-Type").orElse("").contains("json"));
        assertTrue(resp.body().contains("\"updated\":true"));
    }

    @Test
    void test_DeleteUser() throws Exception {
        HttpRequest.Builder b = HttpRequest.newBuilder(URI.create(BASE + "/api/users/999"))
            .timeout(Duration.ofSeconds(10))
            .DELETE();
        for (var e : DEFAULT_HEADERS.entrySet()) {
            b.header(e.getKey(), e.getValue());
        }
        HttpResponse<String> resp = client.send(b.build(), HttpResponse.BodyHandlers.ofString(StandardCharsets.UTF_8));

        assertEquals(200, resp.statusCode());
        assertTrue(resp.body().contains("\"deleted\":"));
    }

}
