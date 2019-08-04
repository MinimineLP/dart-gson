import 'dart:convert';

import 'package:gson/parsable.dart';
import 'package:gson/values.dart';

class GsonDecoder {

  static RegExp KEY_CHARACTERS = new RegExp(r"\w");
  static RegExp IGNORED = new RegExp(r"[ \t\r\n]");
  static RegExp PURE_STRING = new RegExp(r"[^\{\}\[\]\,]");

  /// Insert gson to decode
  dynamic decode(dynamic gson) {
    
    GSONParsable p = gson is GSONParsable ? gson : gson is String ? new GSONParsable(gson) : throw ("The gson is not a valid input to decode an Array from");

    if(p.actual() == "{") return decodeMap(p);
    else if(p.actual() == "[") return decodeArray(p);
    else if(p.actual() == "\"" || p.actual() == "'" || PURE_STRING.hasMatch(p.actual())) return decodeString(p);
    else if(new RegExp(r"[0-9\.]").hasMatch(p.actual())) return decodeNumber(p);
    else throw p.error("Unexpected character "+p.actual());
  }

  /// Decode an array
  List<dynamic> decodeArray(dynamic src) {
    GSONParsable p = src is GSONParsable ? src : src is String ? new GSONParsable(src) : throw ("The src is not a valid input to decode an Array from");
    List<dynamic> arr = [];
    bool foundComma = true;
    if(p.next() != "[") throw p.error("Array has to start with a [");
    while(p.actual() != "]") {
      if(!foundComma) throw p.error("Expected \"]\" or \",\"");
      foundComma = false;
      _skipIgnored(p);
      if(new RegExp(r'''[\\[\\{\\\"\\\'0-9]''').hasMatch(p.actual()) || PURE_STRING.hasMatch(p.actual())) arr.add(decode(p));
      else throw p.error('Expected "[", "\\"","\\\'", "{" or a number');
      _skipIgnored(p);
      if(p.actual() == ",") {
        foundComma = true;
        p.skip();
      }
      _skipIgnored(p);
    }
    if(!p.ended)p.skip();
    return arr;
  }

  /// Decode a map
  Map<String,dynamic> decodeMap(dynamic src) {
    GSONParsable p = src is GSONParsable ? src : src is String ? new GSONParsable(src) : throw ("The src is not a valid input to decode an Array from");
    Map<String,dynamic> map = {};
    bool foundComma = true;
    if(p.next() != "{") throw("Array has to start with a [");
    while(p.actual() != "}") {
      if(!foundComma) throw p.error("Expected \"}\" or \",\"");
      foundComma = false;
      _skipIgnored(p);
      String key = "";
      if(p.actual() == "\"" || p.actual() == "'") key = decodeString(src);
      else while(KEY_CHARACTERS.hasMatch(p.actual())) key += p.next();
      
      _skipIgnored(p);

      if(p.actual() != ":") throw p.error('Expected ":"');
      p.skip();

      _skipIgnored(p);

      if(new RegExp(r'''[\\[\\{\\\"\\\'0-9]''').hasMatch(p.actual()) || PURE_STRING.hasMatch(p.actual())) map[key] = decode(p);
      else throw p.error('Expected "[", "\\"","\\\'", "{" or a number');

      _skipIgnored(p);

      if(p.actual() == ",") {
        foundComma = true;
        p.skip();
      }
      _skipIgnored(p);
    }
    if(!p.ended)p.skip();
    return map;
  }

  /// Decode a String
  String decodeString(dynamic src) {
    GSONParsable p = src is GSONParsable ? src : src is String ? new GSONParsable(src) : throw ("The src is not a valid input to decode an Array from");

    String str = '"';

    if(p.actual() == "\"" || p.actual() == "\'") {
      String search = p.next();
      while(p.actual() != search) {
        if(p.actual() == "\\") str += p.next();
        else if(p.actual() == "\"") { str += "\\" + p.next(); continue; }
        str += p.next();
      }
      p.skip();
    } 
    else if(PURE_STRING.hasMatch(p.actual())) {
      while(PURE_STRING.hasMatch(p.actual())) {
        if(p.actual() == "\\") str += p.next();
        str += p.next();
      }
    } 
    else throw p.error("String has to start with a \"\\\"\" or \"\\\'\" when it contains some characters");
    
    return json.decode(str + '"');
  }

  // Decode a number
  NumberValue decodeNumber(dynamic src) {
    GSONParsable p = src is GSONParsable ? src : src is String ? new GSONParsable(src) : throw ("The src is not a valid input to decode an Array from");
    if(!new RegExp(r"[0-9\.]").hasMatch(p.actual())) throw p.error("Any number has to start with a number between 0 and 9");
    String number = "";
    while(new RegExp(r"[0-9\.]").hasMatch(p.actual())) number += p.next();

    NumberValue ret;

    switch(p.actual()) {
      case "b": ret = new Byte  (num.parse(number)); p.skip(); break;
      case "s": ret = new Short (num.parse(number)); p.skip(); break;
      case "l": ret = new Long  (num.parse(number)); p.skip(); break;
      case "f": ret = new Float (num.parse(number)); p.skip(); break;
      case "d": ret = new Double(num.parse(number)); p.skip(); break;
      default:  ret = new Integer(num.parse(number)); break;
    }

    return ret;
  }

  void _skipIgnored(GSONParsable p) {
    while(IGNORED.hasMatch(p.actual())) p.skip();
  }
}