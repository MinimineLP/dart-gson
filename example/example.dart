import 'package:gson/gson.dart';

main(List<String> args) {
  // Basic encode example
  print(gson.encode({
    "a": "a",
    "b": ["hello", "world"],
    "c": 1,
    "d": false,
    "e": Byte(26)
  })); // >> {a:"a",b:["hello","world"],c:1,d:0b,e:26b}

  // As dart has no different variable types for numbers (there are just `num`, `int` and `double`), the api gives you types.
  // So if you want a double for example in the output you have to insert

  print(gson.encode(new Double(1.0))); // >> 1.0d

  // Also the compiler gives these classes back to you, so you have to get the value property
  print(gson.decode("1.0d").value); // >> 1.0d

  // because booleans are displayed as bytes in gson, the boolean value is in the Byte type.
  print(gson.encode(true)); // >> 1b
  print(gson.decode("1b").value); // >> 1
  print(gson.decode("1b").boolValue); // >> true (and 0b will be false)

  // For beautier gson use
  print(gson.encode({
    "a": "a",
    "b": ["hello", "world"],
    "c": 1,
    "d": false,
    "e": Byte(26)
  }, beautify: true));
  // >> {
  // >>   a: "a",
  // >>   b: [
  // >>     "hello",
  // >>     "world"
  // >>   ],
  // >>   c: 1,
  // >>   d: 0b,
  // >>   e: 26b
  // >> }

  // using indent you can controll the amount of spaces to insert

  print(gson.encode({
    "a": "a",
    "b": ["hello", "world"],
    "c": 1,
    "d": false,
    "e": Byte(26)
  }, beautify: true, indent: 4));
  // >> {
  // >>     a: "a",
  // >>     b: [
  // >>       "hello",
  // >>       "world"
  // >>     ],
  // >>     c: 1,
  // >>     d: 0b,
  // >>     e: 26b
  // >> }
}
