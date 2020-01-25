library gson_parsable;

import 'terminal_web.dart' if (dart.library.io) 'terminal_vm.dart' as io;

import 'package:colorize/colorize.dart';
import 'package:gson/prog.dart';

/// A parsable object for the GsonDecoder to use
class GsonParsable extends ErrorGenerator {
  String _parsable;
  int _position = 0;
  bool _ended = false;

  String get parsable => _parsable;
  int get position => _position;
  bool get ended => _ended;

  GsonParsable(this._parsable, {int position = 0}) {
    this._position = position;
  }

  /// Get actual and go one forward
  String next() {
    skip();
    return parsable.substring(position - 1, position);
  }

  /// Skip one
  void skip() {
    if (ended) {
      throw error("Input ended");
    }
    this._position += 1;
    _checkEnded();
  }

  /// Go Steps back
  void goBack(int number) {
    this._position -= number;
    if (_position < 0) {
      _position = 0;
    }
    _checkEnded();
  }

  /// Get actual
  String actual() {
    return parsable.substring(position, position + 1);
  }

  /// peek forward
  String peek(int number) {
    return has(number)
        ? parsable.substring(position + number, position + number + 1)
        : throw error("Not enough space to peek $number");
  }

  /// test if has next symbol
  bool hasNext() {
    return has(1);
  }

  /// test if has amount of symbols left
  bool has(int space) {
    return parsable.length > position + space;
  }

  /// generate a error at the position of the parsable
  Exception error(String message, {int from = 0, int to = 0}) {
    return Exception(
        message + " at " + toString(from: from, to: to, err: true));
  }

  /// reformat error
  Exception reformatError(Exception e, [StackTrace stack]) {
    return Exception(e.toString().substring(10) +
        "at " +
        toString() +
        (stack != null ? stack.toString() : ""));
  }

  /// String representation of parsable (marks actual position)
  @override
  String toString({int from = 0, int to = 0, bool err = false}) {
    if (parsable.length > io.terminalColumns) {
      int start = parsable.length > io.terminalColumns
          ? (position - (io.terminalColumns / 2) + 3).round()
          : 0;
      int end = parsable.length > io.terminalColumns
          ? (position + (io.terminalColumns / 2) - 4).round()
          : parsable.length - 1;

      if (start < 0) {
        end += start * -1;
        start = 0;
      }
      if (end >= parsable.length) {
        start -= end - parsable.length + 1;
        end = parsable.length - 1;
      }

      String startletters = "(+$start)", startletters_;
      String endletters = "(+${parsable.length - end + 7})", endletters_;
      end -= endletters.length + startletters.length;

      do {
        endletters_ = endletters;
        startletters = "(+$end)";
        if (endletters.length - endletters_.length > 0) {
          end -= endletters.length - endletters_.length;
        }
      } while (endletters_.length != endletters.length);

      do {
        startletters_ = startletters;
        startletters = "(+$start)";
        if (startletters.length - startletters_.length > 0) {
          end -= startletters.length - startletters_.length;
        }
      } while (startletters_.length != startletters.length);

      if (start < 0) {
        end += start * -1;
        start = 0;
      }

      int pos = this.position - start + startletters.length + 3;
      String code = "$startletters..." +
          parsable.substring(start, end) +
          "...$endletters\n";

      String beforeSelect = code.substring(0, pos - from);
      Colorize selected =
          new Colorize(code.substring(pos - from, pos + to + 1));
      String afterSelect = code.substring(pos + to + 1);

      Colorize bottom = new Colorize(_repeatString(" ", pos - from) +
          _repeatString("^", 1 + from + to) +
          "\n");
      if (err) {
        bottom.red();
        selected.bgRed();
      }

      return "position ${position + 1}/${parsable.length} (\"${actual()}\")\n\nHere:\n" +
          beforeSelect +
          selected.toString() +
          afterSelect +
          bottom.toString();
    }

    String beforeSelect = parsable.substring(0, position - from);
    Colorize selected =
        new Colorize(parsable.substring(position - from, position + to + 1));
    String afterSelect = parsable.substring(position + to + 1);

    Colorize bottom = new Colorize(_repeatString(" ", position - from) +
        _repeatString("^", 1 + from + to) +
        "\n");
    if (err) {
      bottom.red();
      selected.bgRed();
    }

    return "position ${position + 1}/${parsable.length} (\"${actual()}\")\n\nHere:\n" +
        beforeSelect +
        selected.toString() +
        afterSelect +
        "\n" +
        bottom.toString();
  }

  String _repeatString(String s, int number) {
    String ret = "";
    for (int i = 0; i < number; i++) {
      ret += s;
    }
    return ret;
  }

  void _checkEnded() {
    this._ended = this.position >= this.parsable.length - 1;
  }
}
