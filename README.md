# cc64

cc64 is a [small-C](C-lang-subset.md) compiler,
written in Forth ([here's why](Why-Forth.md)), targeting the 6502 CPU.
It's hosted on the Commodore C64, on the C16 with 64k RAM and the Plus4,
and on the new [Commander X16](https://www.commanderx16.com/), and runtime
targets are also available for all 3 platforms, on each host, allowing
cross-compilation.

See [Usage](Usage.md) for how to use cc64, including how to get
[curly braces in PETSCII](Usage.md#character-set).

[cc64 language restrictions](C-lang-subset.md) lists the subset of C that
cc64 supports.

[Code layout and library concept](Runtime-libs.md) explains, among others, how
to create a new target.

[Emulator and file formats](File-formats.md) describes the emulator setup I use for developing and testing.

### History

I wrote cc64 during my university years; the majority of the code was written 1989-1991. Motivated by buzzphp who's building a
[C library for cc64](https://sourceforge.net/projects/cc64/),
and also by Johan Kotlinski of
[DurexForth](https://github.com/jkotlinski/durexforth) and
[AcmeForth](https://github.com/jkotlinski/acmeforth),
I have finally open-sourced the project.
See [Versions](Versions.md) for more info.

I hope you'll find cc64 fun to use; I definitely had - and am having -
fun developing it.
