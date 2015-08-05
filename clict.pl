#!/usr/bin/perl
use strict;

printHelpAndExit();

sub printHelpAndExit
{
    print <<EOF;
Usage : $0 --from=<City> --to=<City>
    <City> must be replaced with a real city with a station handled by Capitaine Train.
EOF
    exit 0;
}
