import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(AnyBase_SwiftTests.allTests),
    ]
}
#endif
