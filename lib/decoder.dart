library gson_decoder;

import 'dart:convert';

import 'package:gson/gson.dart';

/// The Gson Decoder class recreates the content from a gson string
class GsonDecoder {
  static RegExp _KEY_CHARACTERS = new RegExp(r"\w");
  static RegExp _IGNORED = new RegExp(r"[ \t\r\n]");
  static RegExp _PURE_STRING = new RegExp(r"[^\{\}\[\]\,]");

  /// gson decoder (if you want to use it use the instance from gson.decoder)
  GsonDecoder();

  /// Insert gson to decode
  dynamic decode(dynamic gson) {
    GsonParsable p = gson is GsonParsable
        ? gson
        : gson is String
            ? new GsonParsable(gson)
            : throw ("The gson is not a valid input to decode an Array from");

    if (p.actual() == "{") {
      return decodeMap(p);
    } else if (p.actual() == "[") {
      return decodeArray(p);
    } else if (p.actual() == "t" &&
        p.peek(1) == "r" &&
        p.peek(2) == "u" &&
        p.peek(3) == "e") {
      return true;
    } else if (p.actual() == "f" &&
        p.peek(1) == "a" &&
        p.peek(2) == "l" &&
        p.peek(3) == "s" &&
        p.peek(4) == "e") {
      return false;
    } else if (new RegExp(r"[0-9\.]").hasMatch(p.actual())) {
      return decodeNumber(p);
    } else if (p.actual() == "\"" ||
        p.actual() == "'" ||
        _PURE_STRING.hasMatch(p.actual())) {
      return decodeString(p);
    } else {
      throw p.error("Unexpected character " + p.actual());
    }
  }

  /// Decode an array
  List<dynamic> decodeArray(dynamic src) {
    GsonParsable p = src is GsonParsable
        ? src
        : src is String
            ? new GsonParsable(src)
            : throw ("The src is not a valid input to decode an Array from");
    List<dynamic> arr = [];
    bool foundComma = true;
    if (p.next() != "[") {
      throw p.error("Array has to start with a [");
    }
    while (p.actual() != "]") {
      if (!foundComma) {
        throw p.error("Expected \"]\" or \",\"");
      }
      foundComma = false;
      _skipIgnored(p);
      if (new RegExp(r'''[\\[\\{\\\"\\\'0-9]''').hasMatch(p.actual()) ||
          _PURE_STRING.hasMatch(p.actual())) {
        arr.add(decode(p));
      } else {
        throw p.error('Expected "[", "\\"","\\\'", "{" or a number');
      }
      _skipIgnored(p);
      if (p.actual() == ",") {
        foundComma = true;
        p.skip();
      }
      _skipIgnored(p);
    }
    if (!p.ended) {
      p.skip();
    }
    return arr;
  }

  /// Decode a map
  Map<String, dynamic> decodeMap(dynamic src) {
    GsonParsable p = src is GsonParsable
        ? src
        : src is String
            ? new GsonParsable(src)
            : throw ("The src is not a valid input to decode an Array from");
    Map<String, dynamic> map = {};
    bool foundComma = true;
    if (p.next() != "{") {
      throw ("Array has to start with a [");
    }
    while (p.actual() != "}") {
      if (!foundComma) {
        throw p.error("Expected \"}\" or \",\"");
      }
      foundComma = false;
      _skipIgnored(p);
      String key = "";
      if (p.actual() == "\"" || p.actual() == "'") {
        key = decodeString(src);
      } else {
        while (_KEY_CHARACTERS.hasMatch(p.actual())) {
          key += p.next();
        }
      }

      _skipIgnored(p);

      if (p.actual() != ":") {
        throw p.error('Expected ":"');
      }
      p.skip();

      _skipIgnored(p);

      if (new RegExp(r'''[\\[\\{\\\"\\\'0-9]''').hasMatch(p.actual()) ||
          _PURE_STRING.hasMatch(p.actual())) {
        map[key] = decode(p);
      } else {
        throw p.error('Expected "[", "\\"","\\\'", "{" or a number');
      }

      _skipIgnored(p);

      if (p.actual() == ",") {
        foundComma = true;
        p.skip();
      }
      _skipIgnored(p);
    }
    if (!p.ended) p.skip();
    return map;
  }

  /// Decode a String
  String decodeString(dynamic src) {
    GsonParsable p = src is GsonParsable
        ? src
        : src is String
            ? new GsonParsable(src)
            : throw ("The src is not a valid input to decode an Array from");

    String str = '"';

    if (p.actual() == "\"" || p.actual() == "\'") {
      String search = p.next();
      while (p.actual() != search) {
        if (p.actual() == "\\") {
          str += p.next();
        } else if (p.actual() == "\"") {
          str += "\\" + p.next();
          continue;
        }
        str += p.next();
      }
      if (!p.ended) {
        p.skip();
      }
    } else if (_PURE_STRING.hasMatch(p.actual())) {
      while (_PURE_STRING.hasMatch(p.actual())) {
        if (p.actual() == "\\") {
          str += p.next();
        }
        str += p.next();
      }
    } else {
      throw p.error(
          "String has to start with a \"\\\"\" or \"\\\'\" when it contains some characters");
    }

    return json.decode(str + '"');
  }

  /// Decode a number
  NumberValue decodeNumber(dynamic src) {
    GsonParsable p = src is GsonParsable
        ? src
        : src is String
            ? new GsonParsable(src)
            : throw ("The src is not a valid input to decode an Array from");
    if (!new RegExp(r"[0-9\.]").hasMatch(p.actual())) {
      throw p.error("Any number has to start with a number between 0 and 9");
    }
    String number = "";
    while (new RegExp(r"[0-9\.]").hasMatch(p.actual())) {
      number += p.next();
    }

    NumberValue ret;

    switch (p.actual()) {
      case "b":
        ret = new Byte(num.parse(number));
        if (!p.ended) {
          p.skip();
        }
        break;
      case "s":
        ret = new Short(num.parse(number));
        if (!p.ended) {
          p.skip();
        }
        break;
      case "l":
        ret = new Long(num.parse(number));
        if (!p.ended) {
          p.skip();
        }
        break;
      case "f":
        ret = new Float(num.parse(number));
        if (!p.ended) {
          p.skip();
        }
        break;
      case "d":
        ret = new Double(num.parse(number));
        if (!p.ended) {
          p.skip();
        }
        break;
      default:
        if (number.indexOf(".") != -1) {
          ret = new Double(double.parse(number));
        } else {
          ret = new Integer(num.parse(number));
        }
        break;
    }

    return ret;
  }

  void _skipIgnored(GsonParsable p) {
    while (_IGNORED.hasMatch(p.actual())) {
      p.skip();
    }
  }
}
