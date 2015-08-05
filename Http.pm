#!/usr/bin/perl
use strict;
package Http;

use LWP::UserAgent;
use JSON::XS;

my $ua = LWP::UserAgent->new( agent => "CliCT/0.42" );
my $API_URL = 'https://www.capitainetrain.com/api/v4/';

sub request
{
    my %params = @_;

    my $url         = $params{url} or return undef;
    my $method      = ($params{method} or "GET");
    my $token       = $params{ token       };
    my $ajax_header = $params{ ajax_header };
    my $post_data   = $params{ post_data   };

    my $req = HTTP::Request->new(
        $method => $API_URL.$url,
    );
    $req->header('content-type' => 'application/json; charset=UTF-8');
    $ajax_header and $req->header('x-requested-with' => 'XMLHttpRequest');
    $token       and $req->header('authorization' => 'Token token="'.$token.'"');
    $post_data   and $req->content(encode_json($post_data));

    # Execute the HTTP call
    my $res = $ua->request($req);

    my $json = eval {
        decode_json $res->content();
    };
    if($@)
    {
        print STDERR "Error decoding JSON $@. JSON :\n".$res->content()."\n";
        return undef;
    }
    return $json;
}

1;
