package ast;

/**
 * Represents an assertion statement
 * Types: STATUS, HEADER_EQUALS, HEADER_CONTAINS, BODY_CONTAINS
 */
public class AssertionNode extends ASTNode {
    public enum AssertionType {
        STATUS,           // expect status = 200
        STATUS_RANGE,     // expect status in 200..299
        HEADER_EQUALS,    // expect header "K" = "V"
        HEADER_CONTAINS,  // expect header "K" contains "V"
        BODY_CONTAINS     // expect body contains "text"
    }
    
    private AssertionType type;
    private String headerKey;  // For header assertions
    private String expectedValue; // String or Integer as string
    private int minStatus, maxStatus; // For range assertions
    
    // For status assertions
    public AssertionNode(AssertionType type, int statusCode) {
        this.type = type;
        this.expectedValue = String.valueOf(statusCode);
    }
    
    // For header assertions
    public AssertionNode(AssertionType type, String headerKey, String expectedValue) {
        this.type = type;
        this.headerKey = headerKey;
        this.expectedValue = expectedValue;
    }
    
    // For body contains
    public AssertionNode(AssertionType type, String expectedValue) {
        this.type = type;
        this.expectedValue = expectedValue;
    }
    
    // For status range assertions
    public AssertionNode(AssertionType type, int minStatus, int maxStatus) {
        this.type = type;
        this.minStatus = minStatus;
        this.maxStatus = maxStatus;
    }
    
    public AssertionType getType() {
        return type;
    }
    
    public String getHeaderKey() {
        return headerKey;
    }
    
    public String getExpectedValue() {
        return expectedValue;
    }
    
    public int getExpectedStatusCode() {
        return Integer.parseInt(expectedValue);
    }
    
    public int getMinStatus() {
        return minStatus;
    }
    
    public int getMaxStatus() {
        return maxStatus;
    }
    
    @Override
    public String toString() {
        switch (type) {
            case STATUS:
                return String.format("AssertStatus(%s)", expectedValue);
            case STATUS_RANGE:
                return String.format("AssertStatusRange(%d..%d)", minStatus, maxStatus);
            case HEADER_EQUALS:
                return String.format("AssertHeaderEquals(%s = %s)", headerKey, expectedValue);
            case HEADER_CONTAINS:
                return String.format("AssertHeaderContains(%s contains %s)", headerKey, expectedValue);
            case BODY_CONTAINS:
                return String.format("AssertBodyContains(%s)", expectedValue);
            default:
                return "Assertion(unknown)";
        }
    }
}