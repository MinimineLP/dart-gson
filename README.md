# dart-gson

Parses and encodes the json generated by GSON (Can parse minecraft's json)

This is just a simple parser and decoder.

View dart docs: [https://pub.dev/documentation/gson/latest/](https://pub.dev/documentation/gson/latest/)
View on pub: [https://pub.dev/packages/gson](https://pub.dev/packages/gson)

## Installation

Add this to your
`pubspec.yaml`
file

```yaml
dependencies:
  gson: ^0.1.1
```

And to import use

```dart
import 'package:gson/gson.dart';
```

## Usage

To decode you can use

```dart
gson.decode("{...}");
```

and to decode you can use

```dart
gson.encode({...});
```

As dart has no different variable types for numbers (there are just `num`, `int` and `double`), the api gives you types.
So if you want a double for example in the output you have to insert

```dart
gson.encode(new Double(1.0)); // >> 1.0d
```

Also the compiler gives these classes back to you, so you have to get the value property

```dart
gson.decode("1.0d").value; // >> 1.0
```

because booleans are displayed as bytes in gson, the boolean value is in the Byte type.

```dart
gson.encode(true) // >> 1b
gson.decode("1b").value // >> 1
gson.decode("1b").boolValue // >> true (and 0b will be false)
```

The program can't find the difference between the number 1 and true / the number 0 / false, because in the code it is the same.

## License

BSD 2-Clause License (See [LICENSE](LICENSE))

## Issues

Please post issues [here](https://github.com/MinimineLP/dart-gson/issues)
