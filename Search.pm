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
            "departure_date"   =>"2015-08-06T20:00:00UTC",
            "return_date"      =>undef,
            "passengers"       =>["8444892"],
            "cards"=>[],
            "cuis"=>{},
            "systems"=>["sncf","db","idbus","idtgv","ouigo","trenitalia","ntv","timetable"],
            "exchangeable_part"=>undef,
            "departure_station_id"=>"4718",
            "arrival_station_id"=>"4652",
            "exchangeable_pnr_id"=>undef,
            "passenger_ids"=>["8444892"],
            "card_ids"=>[],
        },
    };

    # Original JSON
    # {"search":
    #   {
    #    "departure_date"   :"2015-08-06T20:00:00UTC",
    #    "return_date"      :null,
    #    "passengers"       :["8444892"],
    #    "cards":[],
    #    "cuis":{},
    #    "systems":["sncf","db","idbus","idtgv","ouigo","trenitalia","ntv","timetable"],
    #    "exchangeable_part":null,
    #    "departure_station_id":"4718",
    #    "arrival_station_id":"4652",
    #    "exchangeable_pnr_id":null,
    #    "passenger_ids":["8444892"],
    #    "card_ids":[]
    #   }
    #  }
    my $jsonObject = Http::request(
        url         => 'search',
        method      => 'POST',
        token       => $token,
        ajax_header => 1,
        post_data   => $post_data,
    );
    return $jsonObject;
    # search'  -H 'authorization: Token token="bu_RFCaWgkJxgm86W4s3"'  -H 'x-requested-with: XMLHttpRequest'  -H 'content-type: application/json; charset=UTF-8'    --data-binary '{"search":{"departure_date":"2015-08-06T20:00:00UTC","return_date":null,"passengers":["8444892"],"cards":[],"cuis":{},"systems":["sncf","db","idbus","idtgv","ouigo","trenitalia","ntv","timetable"],"exchangeable_part":null,"departure_station_id":"4718","arrival_station_id":"4652","exchangeable_pnr_id":null,"passenger_ids":["8444892"],"card_ids":[]}}' --compressed

}

1;
