#!/usr/bin/perl
use strict;
package Search;
use Http;

# Package used for search-related subs

sub trips
{
    my %params = @_;
    my $stationIdFrom = $params{stationIdFrom};
    my $stationIdTo   = $params{stationIdTo};
    my $token         = $params{token};
    my $passenger_id  = $params{passenger_id};
    my $departure_date= $params{departure_date};

    my $post_data = {
        search  => {
            "departure_date"        => $departure_date,
            "return_date"           => undef,
            # The passengers ids are passed twice, need to be clarified
            "passengers"            => [$passenger_id],
            "passenger_ids"         => [$passenger_id],
            "cards"                 => [],
            "cuis"                  => {},
            # FIXME : The systems should not be hard-coded, but instead provided through an API
            "systems"               => ["sncf","db","idbus","idtgv","ouigo","trenitalia","ntv","timetable"],
            "exchangeable_part"     => undef,
            "departure_station_id"  => $stationIdFrom,
            "arrival_station_id"    => $stationIdTo,
            "exchangeable_pnr_id"   => undef,
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
sub prettyDate
{
    my %params = @_;
    my $date = $params{date};
    if($date =~ /^([^T]+)T([^+]+)+/)
    {
        return "$1 $2";
    }
    return $date;
}

sub tripsPrettyPrint
{
    my %params = @_;
    my $trips = $params{trips};

    ref $trips->{trips} ne 'ARRAY' and print STDERR "No trips found\n";
    ref $trips->{trips} ne 'ARRAY' and return;

    #       2015-08-06T20:00:00+02:00  2015-08-06T20:00:00+02:00   99 €
    foreach my $trip (@{ $trips->{trips} })
    {
        printf("%-30s  %-30s %s\n",
            getElementDetail(id => $trip->{departure_station_id}, field => 'name', elements => $trips->{stations}),
            getElementDetail(id => $trip->{arrival_station_id},   field => 'name', elements => $trips->{stations}),
            getElementDetail(id => $trip->{folder_id},            field => 'system', elements => $trips->{folders}),
        );
        printf("%-30s  %-30s %8.2d €\n",
            prettyDate(date => $trip->{departure_date}),
            prettyDate(date => $trip->{arrival_date}),
            $trip->{cents} / 100
        );
        printf("\n");
    }
}

1;
