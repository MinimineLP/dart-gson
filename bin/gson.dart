import 'dart:io';
import 'dart:convert';

import 'package:gson/gson.dart';

main(List<String> args) {
  String src = new File(args[0]).readAsStringSync();
  dynamic decode = gson.decode(src);

  dynamic encoder;

  if (args.contains("--target")) {
    if (args.indexOf("--target") + 1 >= args.length) ;
    switch (args[args.indexOf("--target") + 1]) {
      case "gson":
        encoder = gson;
        break;
      case "json":
        encoder = json;
        break;
    }
  }

  if (args.contains("--dist") ||
      args.contains("--dest") ||
      args.contains("--d")) {}
}
