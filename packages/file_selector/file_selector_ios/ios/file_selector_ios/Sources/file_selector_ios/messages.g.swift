// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
// Autogenerated from Pigeon (v22.4.1), do not edit directly.
// See also: https://pub.dev/packages/pigeon

import Foundation

#if os(iOS)
  import Flutter
#elseif os(macOS)
  import FlutterMacOS
#else
  #error("Unsupported platform.")
#endif

/// Error class for passing custom error details to Dart side.
final class PigeonError: Error {
  let code: String
  let message: String?
  let details: Any?

  init(code: String, message: String?, details: Any?) {
    self.code = code
    self.message = message
    self.details = details
  }

  var localizedDescription: String {
    return
      "PigeonError(code: \(code), message: \(message ?? "<nil>"), details: \(details ?? "<nil>")"
  }
}

private func wrapResult(_ result: Any?) -> [Any?] {
  return [result]
}

private func wrapError(_ error: Any) -> [Any?] {
  if let pigeonError = error as? PigeonError {
    return [
      pigeonError.code,
      pigeonError.message,
      pigeonError.details,
    ]
  }
  if let flutterError = error as? FlutterError {
    return [
      flutterError.code,
      flutterError.message,
      flutterError.details,
    ]
  }
  return [
    "\(error)",
    "\(type(of: error))",
    "Stacktrace: \(Thread.callStackSymbols)",
  ]
}

private func isNullish(_ value: Any?) -> Bool {
  return value is NSNull || value == nil
}

private func nilOrValue<T>(_ value: Any?) -> T? {
  if value is NSNull { return nil }
  return value as! T?
}

/// Generated class from Pigeon that represents data sent in messages.
struct FileSelectorConfig {
  var utis: [String]
  var allowMultiSelection: Bool

  // swift-format-ignore: AlwaysUseLowerCamelCase
  static func fromList(_ pigeonVar_list: [Any?]) -> FileSelectorConfig? {
    let utis = pigeonVar_list[0] as! [String]
    let allowMultiSelection = pigeonVar_list[1] as! Bool

    return FileSelectorConfig(
      utis: utis,
      allowMultiSelection: allowMultiSelection
    )
  }
  func toList() -> [Any?] {
    return [
      utis,
      allowMultiSelection,
    ]
  }
}

private class messagesPigeonCodecReader: FlutterStandardReader {
  override func readValue(ofType type: UInt8) -> Any? {
    switch type {
    case 129:
      return FileSelectorConfig.fromList(self.readValue() as! [Any?])
    default:
      return super.readValue(ofType: type)
    }
  }
}

private class messagesPigeonCodecWriter: FlutterStandardWriter {
  override func writeValue(_ value: Any) {
    if let value = value as? FileSelectorConfig {
      super.writeByte(129)
      super.writeValue(value.toList())
    } else {
      super.writeValue(value)
    }
  }
}

private class messagesPigeonCodecReaderWriter: FlutterStandardReaderWriter {
  override func reader(with data: Data) -> FlutterStandardReader {
    return messagesPigeonCodecReader(data: data)
  }

  override func writer(with data: NSMutableData) -> FlutterStandardWriter {
    return messagesPigeonCodecWriter(data: data)
  }
}

class messagesPigeonCodec: FlutterStandardMessageCodec, @unchecked Sendable {
  static let shared = messagesPigeonCodec(readerWriter: messagesPigeonCodecReaderWriter())
}

/// Generated protocol from Pigeon that represents a handler of messages from Flutter.
protocol FileSelectorApi {
  func openFile(config: FileSelectorConfig, completion: @escaping (Result<[String], Error>) -> Void)
}

/// Generated setup class from Pigeon to handle messages through the `binaryMessenger`.
class FileSelectorApiSetup {
  static var codec: FlutterStandardMessageCodec { messagesPigeonCodec.shared }
  /// Sets up an instance of `FileSelectorApi` to handle messages through the `binaryMessenger`.
  static func setUp(
    binaryMessenger: FlutterBinaryMessenger, api: FileSelectorApi?,
    messageChannelSuffix: String = ""
  ) {
    let channelSuffix = messageChannelSuffix.count > 0 ? ".\(messageChannelSuffix)" : ""
    let openFileChannel = FlutterBasicMessageChannel(
      name: "dev.flutter.pigeon.file_selector_ios.FileSelectorApi.openFile\(channelSuffix)",
      binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      openFileChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let configArg = args[0] as! FileSelectorConfig
        api.openFile(config: configArg) { result in
          switch result {
          case .success(let res):
            reply(wrapResult(res))
          case .failure(let error):
            reply(wrapError(error))
          }
        }
      }
    } else {
      openFileChannel.setMessageHandler(nil)
    }
  }
}
