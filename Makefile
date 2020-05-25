all: $(addprefix build/,$(patsubst %.adoc,%.html,$(wildcard *.adoc)))

build/%.html: %.adoc
	asciidoctor --out-file $@ $<

.PHONY: clean
clean:
	rm -r build
