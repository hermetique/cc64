
sub_test() {
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

  assert(noconst(0) - 0, 0, "noconst 0 - 0");
  assert(noconst(1) - 0, 1, "noconst 1 - 0");
  assert(noconst(0) - 2, -2, "noconst 0 - 2");
  assert(noconst(-2) - 3, -5, "noconst -2 - 3");
  assert(noconst(2) - 3, -1, "noconst 2 - 3");
  assert(noconst(123) - 34, 89, "noconst 123 - 34");
  assert(noconst(-16385) - 16383, -32768, "noconst -16385 - 16383");
  assert(noconst(-32767) - -16383, -16384, "noconst -32767 - -16383");
  assert(noconst(-32767) - 1, -32768, "noconst -32767 - 1");
  assert(noconst(-32768) - 1, 32767, "noconst -32768 - 1");
  assert(noconst(-32768) - -1, -32767, "noconst -32768 - -1");

  evaluateAsserts();
}
