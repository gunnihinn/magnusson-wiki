#!/usr/bin/env perl

use strict;
use warnings;

my @files = glob '*.adoc';

my %tags;

for my $file (@files) {
    open(my $fh, '<', $file) or die $!;

    while (<$fh>) {
        chomp;

        next unless /:keywords:\s*(.*)/;

        for my $tag (split /\s*,\s*/, $1) {
            $tags{$tag} = undef;
        }

        last;
    }

    close $fh;
}

for my $tag (sort keys %tags) {
    print "$tag\n";
}
