# AnyBase-Swift

This is a Swift implementation of Kamil Harasimowicz's [any-base](https://github.com/HarasimowiczKamil/any-base0) npm package.

## Example ##

```swift
let dec2hex = try! AnyBase(AnyBase.DEC, AnyBase.HEX)
let shortId = try! AnyBase(AnyBase.DEC, "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_-+!@#$^")
let longId  = try! AnyBase("0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_-+!@#$^", AnyBase.DEC)

print(try! dec2hex.convert("123456")) // return: '1e240'
print(try! shortId.convert("1234567890")) // return: 'PtmIa'
print(try! longId.convert("PtmIa")) // return: '1234567890'
```
