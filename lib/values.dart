library gson_values;

import 'package:gson/prog.dart';

abstract class GsonValue {
  /// returns a simple, json compatible representation of the content
  dynamic toSimple();
}

class CustomValue extends GsonValue {
  dynamic content;

  CustomValue(dynamic content) {
    this.content = content;
  }

  @override
  String toString() {
    return content.toString();
  }

  @override
  toSimple() {
    return toString();
  }
}

abstract class NumberValue extends GsonValue {
  ErrorGenerator _gen = new ErrorGenerator();
}

/// Datatype Byte
class Byte extends NumberValue {
  int _number;

  /// the byte value (number from -128 to 127)
  int get value => _number;

  /// The boolean value (if the byte is no boolean then null)
  bool get boolValue => _number == 0 ? false : _number == 1 ? true : null;

  /// is the Byte a boolean
  bool get isBool => _number == 0 || _number == 1;

  /// Used to insert a byte into nbt data
  Byte(int num, {ErrorGenerator error_generator}) {
    set(num);
    super._gen = error_generator;
  }

  /// Used to insert a boolean into nbt data
  Byte.Boolean(bool b, {ErrorGenerator error_generator}) {
    set(b);
    super._gen = error_generator;
  }

  /// Set byte to number or boolean
  void set(dynamic v) {
    if (v is bool) {
      v = v ? 1 : 0;
    } else if (!(v is int))
      throw this
          ._gen
          .error("You must give a boolean or a number to the set function");
    if (v > 127 || v < -128)
      throw this._gen.error("Byte must be between -128 and 127");
    this._number = v;
  }

  @override
  String toString() {
    return "${_number}b";
  }

  @override
  int toSimple() {
    return this.value;
  }
}

/// Datatype Short
class Short extends NumberValue {
  int _number;

  /// the short value (number from -32768 to 32767)
  int get value => _number;

  /// Used to insert a short into nbt data
  Short(int num, {ErrorGenerator error_generator}) {
    set(num);
    super._gen = error_generator;
  }

  /// the short value (number from -32768 to 32767)
  void set(int v) {
    if (v > 32767 || v < -32768)
      throw this._gen.error("Byte must be between -32768 and 32767");
    this._number = v;
  }

  @override
  String toString() {
    return "${_number}s";
  }

  @override
  int toSimple() {
    return this.value;
  }
}

/// Datatype Integer
class Integer extends NumberValue {
  int _number;

  /// the integer value (number from -2147483648 to 2147483647)
  int get value => _number;

  /// Used to integer a integer into nbt data
  Integer(int num, {ErrorGenerator error_generator}) {
    set(num);
    super._gen = error_generator;
  }

  /// the integer value (number from -2147483648 to 2147483647)
  void set(int v) {
    if (v > 2147483647 || v < -2147483648)
      throw this._gen.error("Byte must be between -2147483648 and 2147483647");
    this._number = v;
  }

  @override
  String toString() {
    return _number.toString();
  }

  @override
  int toSimple() {
    return this.value;
  }
}

/// Datatype Long
class Long extends NumberValue {
  int _number;

  /// the long value (number from -9223372036854775808 to 9223372036854775807)
  int get value => _number;

  /// Used to insert a long into nbt data
  Long(int num, {ErrorGenerator error_generator}) {
    set(num);
    super._gen = error_generator;
  }

  /// the long value (number from -9223372036854775808 to 9223372036854775807)
  void set(int v) {
    if (v > 9007199254740991 || v < -9007199254740991)
      throw this._gen.error(
          "Byte must be between -9223372036854775808 and 9223372036854775807");
    this._number = v;
  }

  @override
  String toString() {
    return "${_number}l";
  }

  @override
  int toSimple() {
    return this.value;
  }
}

/// Datatype Float
class Float extends NumberValue {
  double _number;

  /// the float value (number from -9223372036854775808 to 9223372036854775807)
  double get value => _number;

  /// Used to insert a float into nbt data
  Float(double num, {ErrorGenerator error_generator}) {
    set(num);
    super._gen = error_generator;
  }

  /// the float value (number from -9223372036854775808 to 9223372036854775807)
  void set(double v) {
    this._number = v;
  }

  @override
  String toString() {
    return "${_number}f";
  }

  @override
  double toSimple() {
    return this.value;
  }
}

/// Datatype Double
class Double extends NumberValue {
  double _number;

  /// the double value (number from -9223372036854775808 to 9223372036854775807)
  double get value => _number;

  /// Used to insert a float into nbt data
  Double(double num, {ErrorGenerator error_generator}) {
    set(num);
    super._gen = error_generator;
  }

  /// the double value (number from -9223372036854775808 to 9223372036854775807)
  void set(double v) {
    this._number = v;
  }

  @override
  String toString() {
    return "${_number}d";
  }

  @override
  double toSimple() {
    return this.value;
  }
}
