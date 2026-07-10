Pod::Spec.new do |s|
  s.name             = 'SDLog'
  s.version          = '0.1.0'
  s.summary          = 'A lightweight Swift logger that prints messages and writes them to a .log file.'
  s.description      = <<-DESC
SDLog is a lightweight Swift logger for iOS. It supports debug, info, warning, and error logs,
prints formatted messages to the console, and appends each log line to a .log file in the app
Documents directory.
  DESC

  s.homepage         = 'https://github.com/gd-liusida/SDLogDemo'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'gd-liusida' => 'gd-liusida@users.noreply.github.com' }
  s.source           = { :git => 'https://github.com/gd-liusida/SDLogDemo.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'
  s.swift_version = '6.0'
  s.source_files = 'SDLog/SDLog.swift'
end
