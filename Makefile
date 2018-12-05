.PHONY: all test-all lib clean

all: \
	exe/day01_1 exe/day01_2 \
	exe/day02_1 exe/day02_2 \
	exe/day03_1 exe/day03_2 \
	exe/day04_1 \
	exe/day05_1 exe/day05_2

exe:
	mkdir exe/

test-all: all
	./exe/day01_1 < ./txt/day01
	@echo "3         < Expected output"
	./exe/day01_2 < ./txt/day01
	@echo "2         < Expected output"
	./exe/day02_1 < ./txt/day02
	@echo "12        < Expected output"
	./exe/day02_1 < ./txt/day02.bis
	./exe/day02_2 < ./txt/day02
	./exe/day02_2 < ./txt/day02.bis
	@echo "fgij      < Expected output"
	./exe/day03_1 < ./txt/day03
	@echo "4         < Expected output"
	./exe/day03_2 < ./txt/day03
	@echo "3         < Expected output"
	./exe/day04_1 < ./txt/day04
	@echo "240       < Expected output"
	@echo "TODO day04_2"
	@echo "4455      < Expected output"
	./exe/day05_1 < ./txt/day05
	@echo "10        < Expected output"
	./exe/day05_2 < ./txt/day05
	@echo "4         < Expected output"

lib: Makefile.coq
	$(MAKE) -f Makefile.coq

Makefile.coq: _CoqProject
	coq_makefile -f _CoqProject -o $@

exe/%: exe sol/%.vo
	ocamlopt -I sol/ sol/$*.mli sol/$*.ml -o $@

sol/%.vo: lib sol/%.v
	coqc -Q . advent sol/$*.v

clean:
	$(RM) **/*.glob **/*.vo *.glob *.vo sol/day*.ml sol/day*.mli Makefile.coq Makefile.coq.conf
	$(RM) -r exe/
