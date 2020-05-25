#!/usr/bin/env perl

use strict;
use warnings;

my %names =
    map { $_ => undef }
    map { s/\.adoc//; $_ }
    glob '*.adoc';

for my $file (@ARGV) {
    my $l = 0;
    while (<>) {
        $l++;
        next unless /link:([^\[]*)\[/;

        my $name = $1;
        $name =~ s/\.html//;

        if (not exists $names{$name}) {
            die "$file: Target of link '$name' doesn't exist:\n$l: $_";
        }
    }
}

