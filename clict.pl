#!/usr/bin/perl
use strict;

use Station;

print Station::findStationId(
    stationName => 'Lille',
);

printHelpAndExit();

sub printHelpAndExit
{
    print <<EOF;
Usage : $0 --from=<City> --to=<City>
    <City> must be replaced with a real city with a station handled by Capitaine Train.
EOF
    exit 0;
}
