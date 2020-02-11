import 'package:gson/gson.dart';
import 'assert.dart';

main(List<String> args) {
  Map input;
  String expected;

  // Test case 1
  input = {
    "string1": "hello",
    "string2": "world",
    "sub": {"a": "x", "b": "y", "c": "z"},
    "array": [1, 2, 3],
    "objectArray": [
      {
        "one": 1,
        "two": 2,
      },
      {
        "three": 3,
        "four": 4,
      }
    ],
    "boolean": true,
    "boolean2": false,
    "short": Short(1),
    "integer": 0,
    "long": Long(1000),
    "float": Float(1.0),
    "double": 1.0,
    "byte": Byte(1)
  };
  expected =
      "{\n  string1: \"hello\",\n  string2: \"world\",\n  sub: {\n    a: \"x\",\n    b: \"y\",\n    c: \"z\"\n  },\n  array: [\n    1,\n    2,\n    3\n  ],\n  objectArray: [\n    {\n      one: 1,\n      two: 2\n    },\n    {\n      three: 3,\n      four: 4\n    }\n  ],\n  boolean: 1b,\n  boolean2: 0b,\n  short: 1s,\n  integer: 0,\n  long: 1000l,\n  float: 1.0f,\n  double: 1.0d,\n  byte: 1b\n}";
  Assertions.doAssert(expected, gson.encoder.encode(input, beautify: true));

  // test case 2
  expected =
      "{string1:\"hello\",string2:\"world\",sub:{a:\"x\",b:\"y\",c:\"z\"},array:[1,2,3],objectArray:[{one:1,two:2},{three:3,four:4}],boolean:1b,boolean2:0b,short:1s,integer:0,long:1000l,float:1.0f,double:1.0d,byte:1b}";
  Assertions.doAssert(expected, gson.encoder.encode(input, beautify: false));

  // Test case 3
  input = {
    "a": 1,
    "b": 2,
    "c": {"d": 4, "e": 5}
  };

  expected = "{\"a\":1,\"b\":2,\"c\":{\"d\":4,\"e\":5}}";
  Assertions.doAssert(expected,
      gson.encoder.encode(input, beautify: false, quoteMapKeys: true));

  // Test case 4
  expected =
      "{\n  \"a\": 1,\n  \"b\": 2,\n  \"c\": {\n    \"d\": 4,\n    \"e\": 5\n  }\n}";
  Assertions.doAssert(
      expected, gson.encoder.encode(input, beautify: true, quoteMapKeys: true));

  // Test case 5
  input = {
    "b1": true,
    "b2": false,
    "sub": {"b1": true, "b2": false},
    "list": [true, false, true, true]
  };

  expected =
      "{b1:true,b2:false,sub:{b1:true,b2:false},list:[true,false,true,true]}";
  Assertions.doAssert(expected,
      gson.encoder.encode(input, beautify: false, jsonBooleans: true));

  // Test case  6
  expected =
      "{\n  b1: true,\n  b2: false,\n  sub: {\n    b1: true,\n    b2: false\n  },\n  list: [\n    true,\n    false,\n    true,\n    true\n  ]\n}";
  Assertions.doAssert(
      expected, gson.encoder.encode(input, beautify: true, jsonBooleans: true));

  Assertions.finish();
}
