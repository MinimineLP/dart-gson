library gson_encoder;

import 'dart:convert';

import 'package:gson/values.dart';

class GsonEncoder {
  /// Encodes gson
  GsonEncoder();

  /// Insert object to encode it as GSON
  String encode(dynamic obj,
      {bool beautify = false,
      int indent = 2,
      bool quoteMapKeys = false,
      jsonBooleans = false}) {
    if (beautify)
      return beautyEncode(obj,
              indent: indent,
              quoteMapKeys: quoteMapKeys,
              jsonBooleans: jsonBooleans)
          .join("\n");
    if (obj is bool) {
      return jsonBooleans ? (obj ? "true" : "false") : (obj ? "1b" : "0b");
    }
    if (obj is double) {
      return obj.toString() + "d";
    }
    if (obj is GsonValue) {
      return obj.toString();
    }
    if (obj is List) {
      List<String> cont = [];
      obj.forEach((e) {
        cont.add(encode(e,
            indent: indent,
            beautify: beautify,
            quoteMapKeys: quoteMapKeys,
            jsonBooleans: jsonBooleans));
      });
      return "[" + cont.join(",") + "]";
    }
    if (obj is Map) {
      List<String> cont = [];
      obj.forEach((k, v) {
        if (quoteMapKeys) {
          k = json.encode(k);
        }
        cont.add(
            "${k}:${encode(v, indent: indent, beautify: beautify, quoteMapKeys: quoteMapKeys, jsonBooleans: jsonBooleans)}");
      });
      return "{" + cont.join(",") + "}";
    }
    return json.encode(obj);
  }

  /// encode beautified gson
  List<String> beautyEncode(dynamic obj,
      {int indent = 2, bool quoteMapKeys = false, jsonBooleans = false}) {
    if (obj is bool) {
      return [jsonBooleans ? (obj ? "true" : "false") : (obj ? "1b" : "0b")];
    }
    if (obj is double) {
      return [obj.toString() + "d"];
    }
    if (obj is GsonValue) {
      return [obj.toString()];
    }
    if (obj is List) {
      if (obj.length == 0) return ["[]"];
      List<String> cont = ["["];
      for (int c = 0; c < obj.length; c++) {
        List<String> e = beautyEncode(obj[c],
            indent: indent,
            quoteMapKeys: quoteMapKeys,
            jsonBooleans: jsonBooleans);
        for (int i = 0; i < e.length; i++) {
          cont.add(_repeatString(" ", indent) +
              e[i] +
              (i == e.length - 1 && c < obj.length - 1 ? "," : ""));
        }
      }
      cont.add("]");
      return cont;
    }
    if (obj is Map) {
      if (obj.length == 0) return ["{}"];
      List<String> cont = ["{"];
      int c = 0;
      obj.forEach((k, v) {
        if (quoteMapKeys) {
          k = json.encode(k);
        }
        List<String> e = beautyEncode(v,
            indent: indent,
            quoteMapKeys: quoteMapKeys,
            jsonBooleans: jsonBooleans);
        for (int i = 0; i < e.length; i++) {
          cont.add(_repeatString(" ", indent) +
              (i == 0 ? k + ": " : "") +
              e[i] +
              (i == e.length - 1 && c < obj.length - 1 ? "," : ""));
        }
        c++;
      });
      cont.add("}");
      return cont;
    }
    return [json.encode(obj)];
  }

  String _repeatString(String s, int number) {
    String ret = "";
    for (int i = 0; i < number; i++) {
      ret += s;
    }
    return ret;
  }
}
