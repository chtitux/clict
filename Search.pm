#!/usr/bin/perl
use strict;
package Search;
use Http;

sub folders
{
    my %params = @_;
    my $stationIdFrom = $params{stationIdFrom};
    my $stationIdTo   = $params{stationIdTo};
    my $token         = $params{token};

    my $post_data = {
        search  => {
            "departure_date"        => "2015-08-06T20:00:00UTC",
            "return_date"           => undef,
            "passengers"            => ["8444892"],
            "cards"                 => [],
            "cuis"                  => {},
            "systems"               => ["sncf","db","idbus","idtgv","ouigo","trenitalia","ntv","timetable"],
            "exchangeable_part"     => undef,
            "departure_station_id"  => $stationIdFrom,
            "arrival_station_id"    => $stationIdTo,
            "exchangeable_pnr_id"   => undef,
            "passenger_ids"         =>["8444892"],
            "card_ids"              =>[],
        },
    };

    my $jsonObject = Http::request(
        url         => 'search',
        method      => 'POST',
        token       => $token,
        ajax_header => 1,
        post_data   => $post_data,
    );
    not $jsonObject and return $jsonObject;

    return $jsonObject;
}

sub getElementDetail
{
    my %params = @_;
    my $elements = $params{elements};
    my $field    = $params{field};
    my $id       = $params{id};

    foreach my $element (@{ $elements })
    {
        if($id eq $element->{id})
        {
            return $element->{$field};
        }
    }
}

sub foldersPrettyPrint
{
    my %params = @_;
    my $trips = $params{trips};

    ref $trips->{trips} ne 'ARRAY' and print STDERR "No trips found\n";
    ref $trips->{trips} ne 'ARRAY' and return;

    #       2015-08-06T20:00:00+02:00  2015-08-06T20:00:00+02:00   99 €
    foreach my $trip (@{ $trips->{trips} })
    {
        printf("%-30s  %-30s %s%s\n",
            getElementDetail(id => $trip->{departure_station_id}, field => 'name', elements => $trips->{stations}),
            getElementDetail(id => $trip->{arrival_station_id},   field => 'name', elements => $trips->{stations}),
            getElementDetail(id => $trip->{folder_id},            field => 'system', elements => $trips->{folders}),
        );
        printf("%30s  %30s %5.2d €\n", $trip->{departure_date}, $trip->{arrival_date}, $trip->{cents} / 100);
        printf("\n");
    }
}

1;
