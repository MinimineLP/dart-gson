import 'dart:io';

import 'package:gson/gson.dart';

main(List<String> args) {
  print(gson.encoder.encode({
    "hello": "hello",
    "hello2": "hello",
    "aa": {"hello": "hello", "hello2": "hello"},
    "bb": [{}]
  }, beautify: true));
  gson.decode(File("./.testing/test.json").readAsStringSync());
}
