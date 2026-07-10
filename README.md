# SDLog

SDLog is a lightweight Swift logger for iOS.

## Features

- Prints formatted log messages to the console.
- Supports `debug`, `info`, `warning`, and `error` levels.
- Appends log output to `SDLog.log` in the app Documents directory.
- Provides class-method style APIs.

## Installation

```ruby
pod 'SDLog', :git => 'git@github.com:gd-liusida/SDLogDemo.git', :tag => '0.1.0'
```

## Usage

```swift
import SDLog

SDLog.debug("Debug message")
SDLog.info("Info message")
SDLog.warning("Warning message")
SDLog.error("Error message")

let logFileURL = SDLog.currentLogFileURL()
```

## License

SDLog is available under the MIT license. See `LICENSE` for details.
