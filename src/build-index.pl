#!/usr/bin/env perl

use strict;
use warnings;

my @files = grep { !/^index\.adoc$/ }
    glob '*\.adoc';

my @notes;

for my $file (@files) {
    open(my $fh, '<', $file) or die $!;

    my $filename;
    my $title;
    my @tags;

    $filename = $file;
    $filename =~ s/\.adoc/.html/;

    while (<$fh>) {
        chomp;
        if (not $title and /^= (.*)/) {
            $title = $1;
        } elsif (/:keywords:\s*(.*)/) {
            @tags = split /\s*,\s*/, $1;
        }

        last if $title and @tags;
    }
    close $fh;

    push @notes, [$filename, $title, \@tags];
}

my @items;
for my $note (sort { $a->[1] cmp $b->[1] } @notes) {
    push @items, sprintf("* link:%s[%s] (%s)", $note->[0], $note->[1], join(", ", @{$note->[2]}));
}

print "= Index\n";
print "\n";

print "== Notes\n";
print "\n";
for my $note (@notes) {
    printf("* link:%s[%s]\n", $note->[0], $note->[1]);
    for my $tag (@{$note->[2]}) {
        printf("** %s\n", $tag);
    }
}
print "\n";

my %tags;
for my $note (@notes) {
    for my $tag (@{$note->[2]}) {
        $tags{$tag} = undef;
    }
}

print "== Tags\n";
print "\n";
for my $tag (sort keys %tags) {
    printf("* %s\n", $tag);
}
