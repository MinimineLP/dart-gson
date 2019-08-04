import 'package:gson/decoder.dart';
import 'package:gson/encoder.dart';

export 'decoder.dart';
export 'encoder.dart';
export 'parsable.dart';
export 'values.dart';

class GSON {

  GsonDecoder decoder = new GsonDecoder();
  GSONEncoder encoder = new GSONEncoder();

  GSON() {
    this.decoder = new GsonDecoder();
  }

  /**
   * Encode gson
   * ``` dart
   * gson.encode({"hello": "world"}) // >> {hello: "world"}
   * ```
   */
  String encode(dynamic obj) => encoder.encode(obj);


  /**
   * Decode gson
   * ``` dart
   * gson.decode("{hello: "world"}") // >> {"hello": "world"}
   * ```
   */
  dynamic decode(String gson) => decoder.decode(gson);
}


/**
 * use `gson.encode` to encode gson and `gson.decode` to decode gson
 */
GSON gson = GSON();

/**
 * Encode gson
 * ``` dart
 * gsonEncode({"hello": "world"}) // >> {hello: "world"}
 * ```
 */
String gsonEncode(dynamic obj) => gson.encode(obj);

/**
 * Decode gson
 * ``` dart
 * gsonDecode("{hello: "world"}") // >> Map {"hello": "world"}
 * ```
 */
dynamic gsonDecode(String str) => gson.decode(str);










