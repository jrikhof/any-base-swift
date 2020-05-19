import XCTest
@testable import AnyBase

final class AnyBaseTests: XCTestCase {

    // MARK: - Standard numeric string tests
    
    func test_hex2bin() {
        let hex2bin = try! AnyBase("0123456789abcdef", "01")
        let result = try? hex2bin.convert("2d5e")
        XCTAssertEqual(result, "10110101011110")
    }
    
    func test_bin2hex() {
        let bin2hex = try! AnyBase("01", "0123456789abcdef")
        let result = try? bin2hex.convert("10110101011110")
        XCTAssertEqual(result, "2d5e")
    }
    
    func test_dec2hex() {
        let dec2hex = try! AnyBase("0123456789", "0123456789abcdef")
        let result = try? dec2hex.convert("11614")
        XCTAssertEqual(result, "2d5e")
    }
    
    func test_hex2dec() {
        let hex2dec = try! AnyBase("0123456789abcdef", "0123456789")
        let result = try? hex2dec.convert("2d5e")
        XCTAssertEqual(result, "11614")
    }
    
    func test_oct2dec() {
        let oct2dec = try! AnyBase("01234567", "0123456789")
        let result = try? oct2dec.convert("26536")
        XCTAssertEqual(result, "11614")
    }
    
    func test_dec2otc() {
        let dec2otc = try! AnyBase("0123456789", "01234567")
        let result = try? dec2otc.convert("11614")
        XCTAssertEqual(result, "26536")
    }
    
    func test_shorter() {
        let shorter = try! AnyBase("0123456789", "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_-.,")
        let unshorter = try! AnyBase("0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_-.,", "0123456789")
        let short = try! shorter.convert("123456789123456789")
        let result = try! unshorter.convert(short)
        XCTAssertEqual(result, "123456789123456789")
    }
    
    // MARK: - UTF-8 codepoint compatibility tests
    
    func test_dec2moji() {
        let dec2moji = try! AnyBase(
            "0123456789",
            "😀😃😄😁😆😅😂🤣☺😊😇🙂🙃😉😌😍😘😗😙😚😋😜😝😛🤑🤗🤓😎😏😒😞😔😟😕🙁☹😣😖😫😩😤😠😡😶😐😑😯😦😧😮😲😵😳😱😨😰😢😥😴🤤😭😓😪🙄")
        let result = try! dec2moji.convert("11614")
        XCTAssertEqual(result, "😄😱😞")
    }
    
    func test_hex2moji() {
        let hex2moji = try! AnyBase(
            "0123456789abcdef",
            "😀😃😄😁😆😅😂🤣☺😊😇🙂🙃😉😌😍😘😗😙😚😋😜😝😛🤑🤗🤓😎😏😒😞😔😟😕🙁☹😣😖😫😩😤😠😡😶😐😑😯😦😧😮😲😵😳😱😨😰😢😥😴🤤😭😓😪🙄")
        let result = try! hex2moji.convert("2d5e")
        XCTAssertEqual(result, "😄😱😞")
    }
    
    func test_throws_non_alphabetic_digits() {
        let bin2hex = try! AnyBase("01", "0123456789abcdef")
        XCTAssertThrowsError(try bin2hex.convert("01thisshouldntwork")) { error in
            XCTAssertEqual(error as? AnyBase.Error, AnyBase.Error.ContainsNonAlphabeticDigits)
        }
    }
    
    func test_throws_bad_alphabet_error_on_source() {
        XCTAssertThrowsError(try AnyBase("", "01")) { error in
            XCTAssertEqual(error as? AnyBase.Error, AnyBase.Error.BadAlphabet)
        }
    }
    
    func test_throws_bad_alphabet_error_on_destination() {
        XCTAssertThrowsError(try AnyBase("01", "")) { error in
            XCTAssertEqual(error as? AnyBase.Error, AnyBase.Error.BadAlphabet)
        }
    }
    
    static var allTests = [
        ("test_hex2bin", test_hex2bin),
        ("test_bin2hex", test_bin2hex),
        ("test_dec2hex", test_dec2hex),
        ("test_hex2dec", test_hex2dec),
        ("test_oct2dec", test_oct2dec),
        ("test_dec2otc", test_dec2otc),
        ("test_shorter", test_shorter),
        ("test_dec2moji", test_dec2moji),
        ("test_hex2moji", test_hex2moji),
        ("test_throws_non_alphabetic_digits", test_throws_non_alphabetic_digits),
        ("test_throws_bad_alphabet_error_on_source", test_throws_bad_alphabet_error_on_source),
        ("test_throws_bad_alphabet_error_on_destination", test_throws_bad_alphabet_error_on_destination)
    ]
}
