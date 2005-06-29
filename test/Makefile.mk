all: test test_sus

test: test.o main.o helper.o version.o
	$(LD) $(LDFLAGS) test.o main.o helper.o version.o $(LCOMMON) $(LIBS) -o test

test_sus: test_sus.o main.o helper.o version_sus.o
	$(LD) $(LDFLAGS) test_sus.o main.o helper.o version_sus.o $(LCOMMON) $(LIBS) -o test_sus

test.o: test.c
	$(CC) $(CFLAGS) $(CPPFLAGS) $(XO5FL) $(LARGEF) $(ICOMMON) -c test.c

test_sus.o: test.c
	$(CC) $(CFLAGS) $(CPPFLAGS) $(XO5FL) $(LARGEF) $(ICOMMON) -DSUS -c test.c -o test_sus.o

main.o: main.c
	$(CC) $(CFLAGS) $(CPPFLAGS) $(XO5FL) $(LARGEF) $(ICOMMON) -Dfunc='test' -c main.c

helper.o: helper.c
	$(CC) $(CFLAGS) $(CPPFLAGS) $(XO5FL) $(LARGEF) $(ICOMMON) -c helper.c

version.o: version.c
	$(CC) $(CFLAGS) $(CPPFLAGS) $(XO5FL) $(LARGEF) $(ICOMMON) -c version.c

version_sus.o: version.c
	$(CC) $(CFLAGS) $(CPPFLAGS) $(XO5FL) $(LARGEF) $(ICOMMON) -DSUS -c version.c -o version_sus.o

install: all
	$(UCBINST) -c test $(ROOT)$(SV3BIN)/test
	$(STRIP) $(ROOT)$(SV3BIN)/test
	$(UCBINST) -c test_sus $(ROOT)$(SUSBIN)/test
	$(STRIP) $(ROOT)$(SUSBIN)/test
	$(MANINST) -c -m 644 test.1 $(ROOT)$(MANDIR)/man1/test.1

clean:
	rm -f test test.o test_sus test_sus.o main.o helper.o version.o version_sus.o core log *~

main.o: main.c defs.h
helper.o: helper.c defs.h
test.o: test.c defs.h
test_sus.o: test.c defs.h