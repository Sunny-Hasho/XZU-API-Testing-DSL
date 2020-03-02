# XZU Error Testing Documentation

This directory contains comprehensive test files that demonstrate the XZU compiler's error handling capabilities. Each test file contains realistic invalid syntax that should trigger specific parser errors.

## 🚨 **Error Test Cases**

### **1. Invalid Identifier (`error-1-identifier.test`)**
```testlang
// XZU - Complete Test Suite
// All tests in one file as per assignment spec

config {
  base_url = "http://localhost:8080";
  header "Content-Type" = "application/json";
  header "X-App" = "XZU";
}

// Variable declarations (assignment requirement)
let 2user = "admin";  // ❌ ERROR: Invalid identifier
let password = "1234";
let userId = 42;
let adminRole = "ADMIN";
```
**Actual Error:** `Expected IDENTIFIER after 'let'`
**Why:** Variable names cannot start with digits
**✅ Test Result:** PASSED - Correctly caught invalid identifier

### **2. Invalid Body Type (`error-2-body-string.test`)**
```testlang
test Login {
  POST "/api/login" {
    body = 200;  // ❌ ERROR: Body must be string
  }
  expect status = 200;
  expect header "Content-Type" contains "json";
  expect body contains "\"token\":";
}
```
**Actual Error:** `Expected STRING after 'body ='`
**Why:** Request body must be a string, not a number
**✅ Test Result:** PASSED - Correctly caught invalid body type

### **3. Invalid Status Type (`error-3-status-integer.test`)**
```testlang
test Login {
  POST "/api/login" {
    body = "{ \"username\": \"admin\", \"password\": \"1234\" }";
  }
  expect status = "200";  // ❌ ERROR: Status must be integer
  expect header "Content-Type" contains "json";
  expect body contains "\"token\":";
}
```
**Actual Error:** `Expected NUMBER for status`
**Why:** HTTP status codes must be integers, not strings
**✅ Test Result:** PASSED - Correctly caught invalid status type

### **4. Missing Semicolon (`error-4-missing-semicolon.test`)**
```testlang
test Login {
  POST "/api/login" {
    body = "{ \"username\": \"admin\", \"password\": \"1234\" }"  // ❌ ERROR: Missing semicolon
  }
  expect status = 200;
  expect header "Content-Type" contains "json";
  expect body contains "\"token\":";
}
```
**Actual Error:** `Unexpected end of file - missing '}' or ';'?`
**Why:** String literals in request bodies must end with semicolons
**✅ Test Result:** PASSED - Correctly caught missing semicolon

## 🧪 **Running Error Tests**

Use the error testing script to run all invalid test cases:

```cmd
scripts\7-test-errors.bat
```

This script will:
1. Compile each invalid test file
2. Show the expected error message
3. Display the actual parser error
4. Demonstrate that the compiler correctly catches syntax errors

## ✅ **Test Results Summary**

| **Test** | **Error Type** | **Status** | **Error Message** |
|----------|----------------|------------|-------------------|
| `error-1-identifier.test` | Invalid identifier | ✅ **PASSED** | `Expected IDENTIFIER after 'let'` |
| `error-2-body-string.test` | Invalid body type | ✅ **PASSED** | `Expected STRING after 'body ='` |
| `error-3-status-integer.test` | Invalid status type | ✅ **PASSED** | `Expected NUMBER for status` |
| `error-4-missing-semicolon.test` | Missing semicolon | ✅ **PASSED** | `Unexpected end of file - missing '}' or ';'?` |

## ✅ **Expected Behavior**

All test files should **fail to compile** and show appropriate error messages. This proves that the XZU compiler has robust error detection and provides clear feedback to users about syntax issues.

**🎯 All 4 tests PASSED successfully!** Your XZU compiler correctly detects all invalid syntax patterns.

## 📝 **Adding New Error Tests**

To add new error test cases:

1. Create a new `.test` file in this directory
2. Add the invalid syntax
3. Update `scripts\7-test-errors.bat` to include the new test
4. Document the expected error message in this README
