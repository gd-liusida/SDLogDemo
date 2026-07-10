# SDLog

SDLog 是一个轻量级 Swift 日志工具，适用于 iOS 项目。

## 功能

- 支持 `debug`、`info`、`warning`、`error` 四种日志级别。
- 自动格式化日志内容，包含时间、级别、文件名、行号和方法名。
- 同时输出到 Xcode 控制台。
- 自动追加保存到 App Documents 目录下的 `SDLog.log` 文件。
- 使用类方法调用，不需要手动创建实例。

## 安装

```ruby
pod 'SDLog'
```

如果本地暂时拉不到最新版本，可以先更新 CocoaPods 索引：

```bash
pod repo update
```

## 使用

```swift
import SDLog

SDLog.debug("调试信息")
SDLog.info("普通信息")
SDLog.warning("警告信息")
SDLog.error("错误信息")

let logFileURL = SDLog.currentLogFileURL()
```

## 日志格式

日志内容示例：

```text
[2026-07-10 11:30:00.000] [INFO] ViewController.swift:20 viewDidLoad() - 普通信息
```

## 日志文件

日志会保存到 App 沙盒 Documents 目录下：

```text
SDLog.log
```

可以通过以下方法获取日志文件路径：

```swift
let logFileURL = SDLog.currentLogFileURL()
```

## 开源协议

SDLog 基于 MIT 协议开源，详情请查看 `LICENSE`。
