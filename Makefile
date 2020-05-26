all: $(addprefix build/,$(patsubst %.adoc,%.html,$(wildcard *.adoc))) build/index.html

build/%.html: %.adoc
	perl src/check-links.pl $<
	asciidoctor --out-file $@ $<

build/index.html: $(wildcard *.adoc) src/build-index.pl
	perl src/build-index.pl > tmp
	asciidoctor --out-file $@ tmp
	rm -f tmp

.PHONY: clean
clean:
	rm -r build
