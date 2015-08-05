#!/usr/bin/perl
use strict;
package Station;
use Http;
use Search;

sub findTrips
{
    my %params = @_;
    my $from    = $params{from};
    my $to      = $params{to};
    my $token   = $params{token};
    my $passenger_id  = $params{passenger_id};
    my $departure_date= $params{departure_date};


    my $stationIdFrom = Station::findStationId(
        stationName => $from,
    );
    not $stationIdFrom and return $stationIdFrom;

    my $stationIdTo = Station::findStationId(
        stationName => $to,
    );
    not $stationIdTo and return $stationIdTo;

    my $folders = Search::trips(
        token           => $token,
        stationIdFrom   => $stationIdFrom,
        stationIdTo     => $stationIdTo,
        passenger_id    => $passenger_id,
        departure_date  => $departure_date,
    );
    return $folders;
}

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
