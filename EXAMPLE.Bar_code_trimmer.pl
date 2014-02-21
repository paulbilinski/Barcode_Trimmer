#!/usr/bin/perl
#Barcode Trimming by Paul Bilinski, UC Davis
#Will trim the a 5 letter barcode and the left behind T from illumina reads, to change length of barcode change the offset in the substr corresponding to $trimmed
use strict; use warnings;

my ($IN) = @ARGV;
open (INPUT, "<$IN");
open (OUTPUT,">$IN.fastq");

while (my $line = <INPUT>) {
        chomp $line;
        if ($line =~ m/^\@M00/){
                print OUTPUT "$line\n";
        } 
        elsif ($line =~ m/^\+/){
                print OUTPUT "$line\n";
        }
        elsif ($line) {
                print OUTPUT substr($line,6,159), "\n";
        }
}
close INPUT;
close OUTPUT;