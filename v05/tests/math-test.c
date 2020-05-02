
math_test() {
  assert(0 + 0, 0, "0 + 0");
  assert(1 + 0, 1, "1 + 0");
  assert(0 + 652, 652, "0 + 652");
  assert(2 + 3, 5, "2 + 3");
  assert(16384 + 16383, 32767, "16384 + 16383");
  assert(32767 + -16383, 16384, "32767 + -16383");
  assert(32767 + 1, -32768, "32767 + 1");
  assert(-32768 + 1, -32767, "-32768 + 1");
  assert(-32768 + -1, 32767, "-32768 + -1");

  assert(0 - 0, 0, "0 - 0");
  assert(1 - 0, 1, "1 - 0");
  assert(0 - 2, -2, "0 - 2");
  assert(-2 - 3, -5, "-2 - 3");
  assert(2 - 3, -1, "2 - 3");
  assert(123 - 34, 89, "123 - 34");
  assert(-16385 - 16383, -32768, "-16385 - 16383");
  assert(-32767 - -16383, -16384, "-32767 - -16383");
  assert(-32767 - 1, -32768, "-32767 - 1");
  assert(-32768 - 1, 32767, "-32768 - 1");
  assert(-32768 - -1, -32767, "-32768 - -1");

  assert(0 * 0, 0, "0 * 0");
  assert(1 * 0, 0, "1 * 0");
  assert(0 * 4905, 0, "0 * 4905");
  assert(1 * 1, 1, "1 * 1");
  assert(1 * 4905, 4905, "1 * 4905");
  assert(9 * 7, 63, "9 * 7");
  assert(-9 * 8, -72, "-9 * 8");
  assert(-7 * -8, 56, "-7 * -8");
  assert(3 * -5, -15, "3 * -5");
  assert(123 * 234, 28782, "123 * 234");
  assert(128 * 128, 16384, "128 * 128");
  assert(128 * 256, -32768, "128 * 256");
  assert(128 * -256, -32768, "128 * -256");
  assert(-128 * -256, -32768, "-128 * -256");
  assert(-128 * 256, -32768, "-128 * 256");

  assert(-32767 / 10, -3277, "-32768 / 10");
  assert((-32768) / 10, -3277, "(-32768) / 10");
  assert(-(32767 / 10), -3276, "-(32768 / 10)");
  evaluateAsserts();
}
