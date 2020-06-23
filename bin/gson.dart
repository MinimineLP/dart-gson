import 'dart:io';
import 'dart:convert';

import 'package:gson/gson.dart';

void main(List<String> args) {
  var src = File(args[0]).readAsStringSync();
  var decode = gson.decode(src);

  var encoder;

  if (args.contains('--target')) {
    if (args.indexOf('--target') + 1 >= args.length) ;
    switch (args[args.indexOf('--target') + 1]) {
      case 'gson':
        encoder = gson;
        break;
      case 'json':
        encoder = json;
        break;
    }
  }

  if (args.contains('--dist') ||
      args.contains('--dest') ||
      args.contains('--d')) {}
}
