library gson;

import 'package:gson/decoder.dart';
import 'package:gson/encoder.dart';

export 'decoder.dart';
export 'encoder.dart';
export 'parsable.dart';
export 'values.dart';

class GSON {
  /// The decoder
  GsonDecoder decoder = new GsonDecoder();

  /// The encoder
  GsonEncoder encoder = new GsonEncoder();

  /// The adapter to decode and encode gson
  GSON() {
    this.decoder = new GsonDecoder();
  }

  /// Encode gson
  /// ``` dart
  /// gson.encode({"hello": "world"}) // >> {hello: "world"}
  /// ```
  /// for beautier gson
  /// ``` dart
  /// gson.encode({"hello": "world"},beautify: true);
  /// // >> {
  /// // >>   hello: "world"
  /// // >> }
  /// ```
  /// You can also set the indent (the amount of spaces the gson is indented with)
  String encode(dynamic obj, {bool beautify = false, int indent = 2}) {
    return encoder.encode(obj, beautify: beautify, indent: indent);
  }

  /// Decode gson
  /// ``` dart
  /// gson.decode("{hello: "world"}") // >> {"hello": "world"}
  /// ```
  dynamic decode(String gson) {
    return decoder.decode(gson);
  }
}

GSON _gson = GSON();

/// use `gson.encode` to encode gson and `gson.decode` to decode gson
GSON get gson => _gson;

/// Encode gson
/// ``` dart
/// gsonEncode({"hello": "world"}) // >> {hello: "world"}
/// ```
String gsonEncode(dynamic obj) {
  return gson.encode(obj);
}

/// Decode gson
/// ``` dart
/// gsonDecode("{hello: "world"}") // >> Map {"hello": "world"}
/// ```
dynamic gsonDecode(String str) {
  return gson.decode(str);
}
