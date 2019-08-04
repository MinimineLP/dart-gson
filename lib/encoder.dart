library gson_encoder;

import 'dart:convert';

import 'package:gson/values.dart';


class GsonEncoder {

  /// Encodes gson
  GsonEncoder();

  /// Insert object to encode it as GSON
  String encode(dynamic obj) {
    if(obj is bool) { return obj ? "1b" : "0b"; }
    if(obj is double) { return obj.toString()+"d"; }
    if(obj is CustomValue) { return obj.toString(); }
    if(obj is List) {
      List<String> cont = [];
      obj.forEach((e) { cont.add(encode(e)); });
      return "["+cont.join(",")+"]";
    }
    if(obj is Map) {
      List<String> cont = [];
      obj.forEach((k,v) { cont.add("${k}:${encode(v)}"); });
      return "{" + cont.join(",") + "}";
    }
    return json.encode(obj);
  }
}