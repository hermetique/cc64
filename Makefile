
# cc64 sources and binaries
commonsrcs_ascii = $(wildcard src/common/*.fth)
commonsrcs_c64 = $(patsubst src/common/%, c64files/%, $(commonsrcs_ascii))
commonsrcs_c16 = $(patsubst src/common/%, c16files/%, $(commonsrcs_ascii))
commonsrcs_x16 = $(patsubst src/common/%, x16files/%, $(commonsrcs_ascii))
cc64srcs_ascii = $(wildcard src/cc64/*.fth)
cc64srcs_c64 = $(patsubst src/cc64/%, c64files/%, $(cc64srcs_ascii)) \
  $(commonsrcs_c64)
cc64srcs_c16 = $(patsubst src/cc64/%, c16files/%, $(cc64srcs_ascii)) \
  $(commonsrcs_c16)
cc64srcs_x16 = $(patsubst src/cc64/%, x16files/%, $(cc64srcs_ascii)) \
  $(commonsrcs_x16)
peddisrcs_ascii = $(wildcard src/peddi/*.fth)
peddisrcs_c64 = $(patsubst src/peddi/%, c64files/%, $(peddisrcs_ascii)) \
  $(commonsrcs_c64)
peddisrcs_c16 = $(patsubst src/peddi/%, c16files/%, $(peddisrcs_ascii)) \
  $(commonsrcs_c16)
cc64_binaries = cc64 cc64pe peddi
cc64_c64_t64_files = $(patsubst %, autostart-c64/%.T64, $(cc64_binaries))
cc64_c16_t64_files = $(patsubst %, autostart-c16/%.T64, $(cc64_binaries))

rt_files = rt-c64-0801.h rt-c64-0801.i rt-c64-0801.o \
  rt-c16-1001.h rt-c16-1001.i rt-c16-1001.o

sample_files = helloworld-c64.c helloworld-c16.c \
  kernal-io-c64.c kernal-io-c16.c sieve-c64.c

# c64files content
c64dir_content = $(cc64_binaries) $(rt_files) $(sample_files) c-charset
c64dir_files = $(patsubst %, c64files/% , $(c64dir_content))

# c16files content
c16dir_content = $(cc64_binaries) $(rt_files) $(sample_files) c-charset
c16dir_files = $(patsubst %, c16files/% , $(c16dir_content))

# x16files content
x16dir_content = $(cc64_binaries) $(rt_files) $(sample_files) c-charset
x16dir_files = $(patsubst %, x16files/% , $(x16dir_content))

# Forth binaries
forth_binaries = devenv-uF83
forth_t64_files = $(patsubst %, autostart-c64/%.T64, $(forth_binaries))


all: c64 c16 etc

release: c64files.zip c64files.d64 c16files.zip c16files.d64 doc.zip
	rm -rf release
	mkdir release
	cp -p $^ release/


.SECONDARY:

c64: cc64-c64 $(c64dir_files) c64files.zip c64files.d64

c16: cc64-c16 $(c16dir_files) c16files.zip c16files.d64

cc64-c64: $(cc64_c64_t64_files)

cc64-c16: $(cc64_c16_t64_files)

c64files.zip: $(c64dir_files)
	rm -f $@
	zip -r $@ $(c64dir_files)

c16files.zip: $(c16dir_files)
	rm -f $@
	zip -r $@ $(c16dir_files)

c64files.d64: $(c64dir_files)
	rm -f $@
	c1541 -format cc64-c64,cc d64 $@
	c1541 -attach $@ $(patsubst %, -write c64files/%, $(cc64_binaries))
	c1541 -attach $@ -write c64files/rt-c64-0801.h rt-c64-0801.h,s
	c1541 -attach $@ -write c64files/rt-c64-0801.i
	c1541 -attach $@ -write c64files/rt-c64-0801.o
	c1541 -attach $@ -write c64files/rt-c16-1001.h rt-c16-1001.h,s
	c1541 -attach $@ -write c64files/rt-c16-1001.i
	c1541 -attach $@ -write c64files/rt-c16-1001.o
	c1541 -attach $@ -write c64files/c-charset
	c1541 -attach $@ -write c64files/helloworld-c64.c helloworld-c64.c,s
	c1541 -attach $@ -write c64files/kernal-io-c64.c kernal-io-c64.c,s
	c1541 -attach $@ -write c64files/helloworld-c16.c helloworld-c16.c,s
	c1541 -attach $@ -write c64files/kernal-io-c16.c kernal-io-c16.c,s

c16files.d64: $(c16dir_files)
	rm -f $@
	c1541 -format cc64-c16,cc d64 $@
	c1541 -attach $@ $(patsubst %, -write c16files/%, $(cc64_binaries))
	c1541 -attach $@ -write c16files/rt-c64-0801.h rt-c64-0801.h,s
	c1541 -attach $@ -write c16files/rt-c64-0801.i
	c1541 -attach $@ -write c16files/rt-c64-0801.o
	c1541 -attach $@ -write c16files/rt-c16-1001.h rt-c16-1001.h,s
	c1541 -attach $@ -write c16files/rt-c16-1001.i
	c1541 -attach $@ -write c16files/rt-c16-1001.o
	c1541 -attach $@ -write c16files/c-charset
	c1541 -attach $@ -write c16files/helloworld-c64.c helloworld-c64.c,s
	c1541 -attach $@ -write c16files/kernal-io-c64.c kernal-io-c64.c,s
	c1541 -attach $@ -write c16files/helloworld-c16.c helloworld-c16.c,s
	c1541 -attach $@ -write c16files/kernal-io-c16.c kernal-io-c16.c,s

doc.zip: $(wildcard *.md)
	zip $@ $^

etc: $(forth_t64_files) emulator/c-char-rom-gen


clean:
	rm -f c64files/*.fth c16files/*.fth x16files/*.fth tmp/* doc.zip
	rm -rf release
	$(MAKE) -C tests clean
	$(MAKE) -C tests/peddi clean

veryclean: clean
	rm -f c64files/*
	rm -f c64files.d64 c64files.zip
	rm -f c16files/*
	rm -f c16files.d64 c16files.zip
	rm -f emulator/c-char-rom-gen
	rm -f autostart-c64/*.T64 autostart-c16/*.T64
	rm -f runtime/*


test: cc64-c64 fasttests

alltests:
	$(MAKE) -C tests alltests
	$(MAKE) -C tests/peddi tests

fasttests:
	$(MAKE) -C tests fasttests

slowtests:
	$(MAKE) -C tests slowtests


# cc64 build rules

%files/cc64: $(cc64srcs_c64) $(cc64srcs_c16) $(cc64srcs_x16) \
 build/build-cc64.sh emulator/run-in-vice.sh \
 autostart-%/vf-build-base.T64 %files/vf-build-base emulator/sdcard.img
	build/build-cc64.sh $*

%files/cc64pe: $(cc64srcs_c64) $(peddisrcs_c64) \
 build/build-cc64pe.sh emulator/run-in-vice.sh \
 autostart-%/vf-build-base.T64
	build/build-cc64pe.sh $*

%files/peddi: $(peddisrcs_c64) $(peddisrcs_c16) \
 build/build-peddi.sh emulator/run-in-vice.sh \
 autostart-%/vf-build-base.T64
	build/build-peddi.sh $*


# build base rule

c64files/vf-build-base: forth/v4th-c64
	cp $< $@

c16files/vf-build-base: forth/v4th-c16+
	cp $< $@

x16files/vf-build-base: forth/v4th-x16
	cp $< $@


# Runtime module rules

runtime/rt-c64-0801.o runtime/rt-c64-0801.h: \
    src/runtime/rt-c64-0801.a build/generate_pragma_cc64.awk
	test -d tmp || mkdir tmp
	acme -f cbm -l tmp/rt-c64-0801.sym -o runtime/rt-c64-0801.o \
	  src/runtime/rt-c64-0801.a
	awk -f build/generate_pragma_cc64.awk -F '$$' tmp/rt-c64-0801.sym \
	  > runtime/rt-c64-0801.h

runtime/rt-c16-1001.o runtime/rt-c16-1001.h: \
    src/runtime/rt-c16-1001.a build/generate_pragma_cc64.awk
	test -d tmp || mkdir tmp
	acme -f cbm -l tmp/rt-c16-1001.sym -o runtime/rt-c16-1001.o \
	  src/runtime/rt-c16-1001.a
	awk -f build/generate_pragma_cc64.awk -F '$$' tmp/rt-c16-1001.sym \
	  > runtime/rt-c16-1001.h

runtime/rt-c64-0801.i:
	awk 'BEGIN{ printf("\x00\x90");}' > $@
	# An empty binary file with (arbitrary) load address $9000
	# Might be worth encoding in an asm source for clarity.

runtime/rt-c16-1001.i:
	awk 'BEGIN{ printf("\x00\x90");}' > $@
	# An empty binary file with (arbitrary) load address $9000
	# Might be worth encoding in an asm source for clarity.

%files/rt-c64-0801.h: runtime/rt-c64-0801.h
	ascii2petscii $< $@
	touch -r $< $@

%files/rt-c64-0801.i: runtime/rt-c64-0801.i
	cp $< $@

%files/rt-c64-0801.o: runtime/rt-c64-0801.o
	cp $< $@

%files/rt-c16-1001.h: runtime/rt-c16-1001.h
	ascii2petscii $< $@
	touch -r $< $@

%files/rt-c16-1001.i: runtime/rt-c16-1001.i
	cp $< $@

%files/rt-c16-1001.o: runtime/rt-c16-1001.o
	cp $< $@


# Charset rules

c64files/c-charset: src/runtime/c-charset-c64.a
	test -d tmp || mkdir tmp
	acme -f cbm -l tmp/c-charset-c64.sym -o $@ $<

c16files/c-charset: src/runtime/c-charset-c16.a
	test -d tmp || mkdir tmp
	acme -f cbm -l tmp/c-charset-c16.sym -o $@ $<

emulator/c-char-rom-gen: src/runtime/c-char-rom-gen.a
	acme -f cbm -o $@ $<

emulator/c-chargen: emulator/c-char-rom-gen
	x64 -virtualdev +truedrive -drive8type 1541 -fs8 emulator \
	-keybuf 'load"c-char-rom-gen",8\nrun\n'


# Generic T64 tape image rules

autostart-c64/%.T64: c64files/%
	bin2t64 $< $@

autostart-c64/%.T64: forth/%
	bin2t64 $< $@

autostart-c16/%.T64: c16files/%
	bin2t64 $< $@

autostart-c16/%.T64: forth/%
	bin2t64 $< $@

autostart-x16/%.T64: x16files/%
	bin2t64 $< $@


# X16 emulator rules

emulator/sdcard.img: emulator/sdcard.sfdisk
	rm -f $@ $@.tmp
	dd if=/dev/zero of=$@.tmp count=64 bs=1M
	sfdisk -w always -W always $@.tmp < $<
	mformat -i $@.tmp -F
	mv $@.tmp $@


# Rules, mostly generic, to populate c64files/, c16files/

c64files/%.fth: src/*/%.fth
	ascii2petscii $< $@
	touch -r $< $@

c64files/%.c: src/*/%.c
	ascii2petscii $< $@
	touch -r $< $@

c16files/%.fth: src/*/%.fth
	ascii2petscii $< $@
	touch -r $< $@

c16files/%.c: src/*/%.c
	ascii2petscii $< $@
	touch -r $< $@

x16files/%.fth: src/*/%.fth
	ascii2petscii $< $@
	touch -r $< $@

x16files/%.c: src/*/%.c
	ascii2petscii $< $@
	touch -r $< $@
