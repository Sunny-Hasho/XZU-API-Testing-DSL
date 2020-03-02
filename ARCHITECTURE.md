# XZU Architecture Diagram

## High-Level Architecture

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   .test File    │───▶│   XZU Compiler  │───▶│  JUnit 5 Test   │
│                 │    │                 │    │                 │
│ • config block  │    │ • Scanner       │    │ • @Test methods │
│ • variables     │    │ • Parser        │    │ • HTTP requests │
│ • test blocks   │    │ • Code Gen      │    │ • Assertions    │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

## Detailed Compiler Pipeline

```
Input: my-test.test
    │
    ▼
┌─────────────────────────────────────────────────────────────┐
│                    XZU Compiler                             │
├─────────────────────────────────────────────────────────────┤
│ 1. Scanner (JFlex)                                          │
│    • Tokenizes text                                         │
│    • Recognizes keywords: test, GET, POST, expect           │
│    • Handles strings and identifiers                        │
│    │                                                        │
│    ▼                                                        │
│ 2. Parser (CUP)                                             │
│    • Builds Abstract Syntax Tree                            │
│    • Validates grammar rules                                │
│    • Creates ProgramNode with tests                         │
│    │                                                        │
│    ▼                                                        │
│ 3. Code Generator                                           │
│    • Traverses AST                                          │
│    • Generates JUnit 5 test class                           │
│    • Handles variable substitution                          │
└─────────────────────────────────────────────────────────────┘
    │
    ▼
Output: GeneratedTests.java
```

## Key Components

### 1. Scanner (lexer.flex)
- **Purpose**: Convert text to tokens
- **Tool**: JFlex
- **Output**: Token stream

### 2. Parser (parser.cup)
- **Purpose**: Build Abstract Syntax Tree
- **Tool**: CUP
- **Output**: ProgramNode (AST root)

### 3. AST Nodes
- **ProgramNode**: Root node
- **TestNode**: Individual test blocks
- **RequestNode**: HTTP requests
- **AssertionNode**: Test assertions

### 4. Code Generator
- **Purpose**: Convert AST to Java code
- **Output**: JUnit 5 test class
- **Features**: Variable substitution, HTTP client code

## Data Flow

```
.test file → Tokens → AST → Java Code → JUnit Tests
```

## Example Transformation

**Input (.test file):**
```testlang
test LoginTest {
  POST "/api/login" {
    body = "{ \"user\": \"admin\" }";
  }
  expect status = 200;
}
```

**Output (Java):**
```java
@Test
void test_LoginTest() throws Exception {
  HttpRequest.Builder b = HttpRequest.newBuilder(URI.create("BASE + \"/api/login\""))
    .POST(HttpRequest.BodyPublishers.ofString("{ \"user\": \"admin\" }"));
  HttpResponse<String> resp = client.send(b.build(), ...);
  assertEquals(200, resp.statusCode());
}
```
