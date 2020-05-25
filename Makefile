all: $(addprefix build/,$(patsubst %.adoc,%.html,$(wildcard *.adoc)))

build/%.html: %.adoc
	perl src/check-links.pl $<
	asciidoctor --out-file $@ $<

.PHONY: clean
clean:
	rm -r build
