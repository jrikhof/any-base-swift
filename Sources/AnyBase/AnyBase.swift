class AnyBase {

    static let BIN = "01"
    static let OCT = "01234567"
    static let DEC = "0123456789"
    static let HEX = "0123456789abcdef"

    enum Error: Swift.Error {
        case BadAlphabet
        case ContainsNonAlphabeticDigits
    }

    let srcAlphabet: String
    let dstAlphabet: String

    init(_ srcAlphabet: String, _ dstAlphabet: String) throws {
        guard !srcAlphabet.isEmpty, !dstAlphabet.isEmpty else {
            throw Error.BadAlphabet
        }
        self.srcAlphabet = srcAlphabet
        self.dstAlphabet = dstAlphabet
    }

    func convert(_ value: String) throws -> String {
        guard srcAlphabet != dstAlphabet else {
            return value
        }

        if !isValid(value: value) {
            throw Error.ContainsNonAlphabeticDigits
        }

        var numberMap: [Int] = []
        var length = value.count
        for i in 0..<length {
            let v = value[value.index(value.startIndex, offsetBy: i)]
            if let number = srcAlphabet.firstIndex(of: v)?.utf16Offset(in: srcAlphabet) {
                numberMap.append(number)
            }
        }

        var divide: Int
        var newlen: Int

        let fromBase = srcAlphabet.count
        let toBase = dstAlphabet.count
        
        var result = ""

        repeat {
            divide = 0
            newlen = 0
            for i in 0..<length {
                divide = divide * fromBase + numberMap[i]
                if divide >= toBase {
                    numberMap[newlen] = divide / toBase
                    newlen += 1
                    divide = divide % toBase
                } else if newlen > 0 {
                    numberMap[newlen] = 0
                    newlen += 1
                }
            }
            length = newlen
            result = dstAlphabet[dstAlphabet.index(dstAlphabet.startIndex, offsetBy: divide)..<dstAlphabet.index(dstAlphabet.startIndex, offsetBy: divide + 1)] + result
        } while newlen != 0
        return result
    }

    private func isValid(value: String) -> Bool {
        for i in 0..<value.count {
            let char = value[value.index(value.startIndex, offsetBy: i)]
            if !srcAlphabet.contains(char) {
                return false
            }
        }
        return true
    }
}
