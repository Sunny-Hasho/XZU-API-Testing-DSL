# XZU Demo Video Script (3 Minutes)

## 🎬 **Scene 1: Introduction (30 seconds)**

### Script:
"Hi! I'm demonstrating XZU, a Domain-Specific Language compiler for HTTP API testing. It transforms declarative test specifications into executable JUnit 5 tests. Let me show you both bonus features: triple-quoted multiline strings and range status checks."

### Screen Action:
- Show project folder structure
- Open README.md to show project overview

---

## 🎬 **Scene 2: Write DSL with Bonus Features (90 seconds)**

### Script:
"I'll create a test file demonstrating the bonus features."

### Screen Action:

1. **Create test file** `bonus-demo.test`:
```testlang
config {
  base_url = "http://localhost:8080";
  header "Content-Type" = "application/json";
}

let userId = 42;

// Bonus Feature 1: Multiline strings
test LoginWithMultiline {
  POST "/api/login" {
    body = """
    {
      "username": "admin",
      "password": "1234"
    }
    """;
  }
  expect status = 200;
  expect header "Content-Type" contains "json";
  expect body contains "\"token\":";
}

// Bonus Feature 2: Range status check
test GetUserWithRange {
  GET "/api/users/$userId";
  expect status in 200..299;  // Any 2xx success
  expect body contains "\"id\":42";
  expect body contains "\"username\":";
}

// Test 3: Update with multiline
test UpdateUser {
  PUT "/api/users/$userId" {
    body = """
    {
      "role": "ADMIN",
      "updated": true
    }
    """;
  }
  expect status = 200;
  expect body contains "\"updated\":";
}
```

### Script (while typing):
"Notice the multiline strings using triple quotes - this makes complex JSON much more readable. And here's the range status check that accepts any 2xx success code rather than requiring an exact match."

---

## 🎬 **Scene 3: Run Parser (60 seconds)**

### Screen Action:
Run the compiler:

```cmd
scripts\3-compile-test.bat test\bonus-demo.test output\BonusTest.java
```

### Script:
"The compiler scans, parses, and generates JUnit 5 code from our DSL. Notice it successfully handles both bonus features."

### Screen Action:
Show the generated Java file:

```java
@Test
void test_LoginWithMultiline() throws Exception {
  HttpRequest.Builder b = HttpRequest.newBuilder(URI.create(BASE + "/api/login"))
    .timeout(Duration.ofSeconds(10))
    .POST(HttpRequest.BodyPublishers.ofString("{\n  \"username\": \"admin\",\n  \"password\": \"1234\"\n}", StandardCharsets.UTF_8));
  // ... assertions
}

@Test
void test_GetUserWithRange() throws Exception {
  // ... request setup
  assertTrue(resp.statusCode() >= 200 && resp.statusCode() <= 299);  // Range check!
  // ... assertions
}
```

### Script:
"As you can see, multiline strings are captured correctly, and the range status check generates the appropriate assertion code."

---

## 🎬 **Scene 4: Show Invalid DSL Error (30 seconds)**

### Script:
"Now let me show you the robust error handling."

### Screen Action:
Create an invalid test file `error-demo.test`:

```testlang
test InvalidTest {
  let 2invalid = "test";  // Error: identifier starts with number
}
```

### Screen Action:
Run compiler:

```cmd
scripts\3-compile-test.bat test\error-demo.test output\ErrorTest.java
```

### Screen Action:
Show error output:

```
==================================================
*** XZU SYNTAX ERROR ***
==================================================
Location: Line 2
Problem: Expected IDENTIFIER after 'let'
   -> Identifiers cannot start with a digit '2'
   -> Try: let var2invalid = ...
==================================================
```

### Script:
"The compiler provides clear, helpful error messages with suggested fixes."

---

## 🎬 **Scene 5: Compile and Run Tests (30 seconds)**

### Screen Action:
```cmd
scripts\4-run-tests.bat output\BonusTest.java
```

### Script:
"The generated JUnit tests compile and run successfully, demonstrating that our DSL produces working, executable test code."

### Screen Action:
Show test results (green if passing)

---

## 🎬 **Scene 6: Conclusion (10 seconds)**

### Script:
"XZU demonstrates professional compiler design with both bonus features implemented. It transforms declarative test specifications into production-ready JUnit 5 code. Thank you!"

---

## 📋 **Complete Script Timestamps**

| Time | Scene | Duration |
|------|-------|----------|
| 0:00-0:30 | Introduction | 30s |
| 0:30-2:00 | Write DSL with bonus features | 90s |
| 2:00-3:00 | Run Parser and show generated code | 60s |
| 3:00-3:30 | Show invalid DSL error handling | 30s |
| 3:30-4:00 | Compile & run tests | 30s |
| 4:00-4:10 | Conclusion | 10s |

**Total: 3:10 minutes** (can be trimmed to exactly 3:00)

---

## 🎯 **Tips for Recording**

1. **Practice** each command before recording
2. **Type slowly** so viewers can follow
3. **Zoom in** on terminal output for readability
4. **Highlight** key parts of generated code
5. **Show enthusiasm** - this is great work!
6. **Test in advance** to ensure no compilation errors

---

## 📝 **Quick Command Reference**

```cmd
# 1. Create test file
notepad test\bonus-demo.test

# 2. Compile
scripts\3-compile-test.bat test\bonus-demo.test output\BonusTest.java

# 3. Show generated code
notepad output\BonusTest.java

# 4. Error testing
scripts\7-test-errors.bat

# 5. Run tests
scripts\4-run-tests.bat output\BonusTest.java
```
