# BAError

[![CI Status](https://img.shields.io/travis/benarvin/BAError.svg?style=flat)](https://travis-ci.org/benarvin/BAError)
[![Version](https://img.shields.io/cocoapods/v/BAError.svg?style=flat)](https://cocoapods.org/pods/BAError)
[![License](https://img.shields.io/cocoapods/l/BAError.svg?style=flat)](https://cocoapods.org/pods/BAError)
[![Platform](https://img.shields.io/cocoapods/p/BAError.svg?style=flat)](https://cocoapods.org/pods/BAError)

Helper category for NSError, mark details of NSError more effective.

BAError help you build NSError easily. And you can get more specific description by call `localizedDescription`, and readable details chain by call `localizedFailureReason`, `localizedRecoverySuggestion`.

For example:

```
NSError *error1 = [NSError bae_errorWith:@"TestDomain" code:1001 description:@"testDes_1" causes:nil];
NSError *error2 = [NSError bae_errorWith:@"TestDomain" code:1002 description:@"testDes_2" causes:error1, nil];
NSLog(@"%@", error2.localizedDescription);
NSLog(@"%@", error2.localizedFailureReason);
NSLog(@"%@", error2.localizedRecoverySuggestion);
```
You'll find jsonlized and continuous detail of NSError in console:

- Localized description:

```
[TestDomain-1002] testDes_2

```
- Localized failure reason & Localized recovery suggestion

```
{
  "Domain" : "TestDomain",
  "Description" : "testDes_2",
  "Causes" : [
    {
      "Domain" : "TestDomain",
      "Code" : 1001,
      "Description" : "testDes_1"
    }
  ],
  "Code" : 1002
}
```


## Installation

BAError is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'BAError'
```

## Author

benarvin, benarvin93@outlook.com

## License

BAError is available under the MIT license. See the LICENSE file for more info.
