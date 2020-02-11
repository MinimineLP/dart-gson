import 'package:gson/gson.dart';

main(List<String> args) {
  const String input = "{Test1:1b,testArray:[\"hello\",\"world\"]}";
  Map output = gson.decode(input);
  if (!(output["Test1"] is Byte) || !output["Test1"].boolValue)
    throw ("Boolean did not work");
  if (!(output["testArray"] is List) ||
      output["testArray"].length != 2 ||
      output["testArray"][1] != "world") throw ("String array did not work");
  print("test seems to have worked correctly");
}
