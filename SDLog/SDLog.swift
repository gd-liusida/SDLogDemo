import Foundation

public enum SDLogLevel: String {
    case debug = "DEBUG"
    case info = "INFO"
    case warning = "WARNING"
    case error = "ERROR"

    public var icon: String {
        switch self {
        case .debug:
            return "🐛"
        case .info:
            return "ℹ️"
        case .warning:
            return "⚠️"
        case .error:
            return "❌"
        }
    }
}

public final class SDLog: @unchecked Sendable {
    private static let shared = SDLog()

    private let logFileURL: URL
    private let queue = DispatchQueue(label: "com.sdlog.file.queue")

    public init(fileManager: FileManager = .default, fileName: String = "SDLog.log") {
        self.logFileURL = SDLog.makeLogFileURL(fileManager: fileManager, fileName: fileName)
    }

    public static func debug(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        shared.write(.debug, message, file: file, function: function, line: line)
    }

    public static func info(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        shared.write(.info, message, file: file, function: function, line: line)
    }

    public static func warning(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        shared.write(.warning, message, file: file, function: function, line: line)
    }

    public static func error(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        shared.write(.error, message, file: file, function: function, line: line)
    }

    public static func log(_ level: SDLogLevel, _ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        shared.write(level, message, file: file, function: function, line: line)
    }

    public static func currentLogFileURL() -> URL {
        shared.logFileURL
    }

    private func write(_ level: SDLogLevel, _ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        let fileName = URL(fileURLWithPath: file).lastPathComponent
        let timestamp = SDLog.makeTimestamp()
        let output = "[\(timestamp)] \(level.icon) [\(level.rawValue)] \(fileName):\(line) \(function) - \(message)"

        print(output)
        appendToFile(output)
    }

    private func appendToFile(_ text: String) {
        queue.async { [logFileURL] in
            let line = text + "\n"
            guard let data = line.data(using: .utf8) else {
                return
            }

            let fileManager = FileManager.default
            let directory = logFileURL.deletingLastPathComponent()
            if !fileManager.fileExists(atPath: directory.path) {
                try? fileManager.createDirectory(at: directory, withIntermediateDirectories: true)
            }

            if !fileManager.fileExists(atPath: logFileURL.path) {
                fileManager.createFile(atPath: logFileURL.path, contents: nil)
            }

            guard let handle = try? FileHandle(forWritingTo: logFileURL) else {
                return
            }

            defer {
                try? handle.close()
            }

            handle.seekToEndOfFile()
            handle.write(data)
        }
    }

    private static func makeTimestamp() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: Date())
    }

    private static func makeLogFileURL(fileManager: FileManager, fileName: String) -> URL {
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let baseURL = documentsURL ?? fileManager.temporaryDirectory
        return baseURL.appendingPathComponent(fileName)
    }
}
