#!/usr/bin/perl
use strict;
package Station;
use Http;
use Search;

# Find the ID stations from the departure and the arrival, and
# search for the trips between them
# If one of the stations is not found, return false
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

# Find the station ID from the station name
# Beware, if you search "P", it will get the first result (that may be Paris or Pau, you do not know)
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
