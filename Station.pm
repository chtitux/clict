#!/usr/bin/perl
use strict;
package Station;
use Http;

sub findStationId
{
    my %params = @_;
    my $stationName = $params{stationName};

    # No authentification needed for searching station ID
    my $jsonObject = Http::request(
        url => 'stations?context=search&q='.$stationName,
    );
    not $jsonObject and return $jsonObject;

    if(scalar(@{ $jsonObject->{stations} }) == 0)
    {
        print STDERR "No stations named $stationName\n";
        return 0;
    }

    my @stations = @{ $jsonObject->{stations} };
    return $stations[0]->{id};
}

1;
