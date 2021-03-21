class Assertions {
  static int errors = 0;
  static int num = 0;
  static bool doAssert(dynamic expected, dynamic actual) {
    num++;
    if (expected == actual) {
      return true;
    }
    errors++;
    print(
        "-----------------------\nAssertion $num failed:\nexpected: $expected\nactual:   $actual\n-----------------------\n");
    return false;
  }

  static void finish() {
    print("-------test done-------\n"
        "total assertions: $num\n"
        "succeded: ${num - errors}\n"
        "errors: $errors\nsuccess rate: ${((num - errors) / num * 10000).round() / 100}%\n"
        "-----------------------");
  }
}
