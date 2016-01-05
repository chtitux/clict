#!/usr/bin/perl
use strict;
package Http;

use LWP::UserAgent;
use JSON::XS;

# Helper package to perform HTTPS request
# and decode the JSON received

my $ua = LWP::UserAgent->new( agent => "CliCT/0.42" );
my $API_URL = 'https://www.capitainetrain.com/api/v5/';

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
    # For a unknown reason, CT fails if x-requested-with is not set with XMLHttpRequest
    $ajax_header and $req->header('x-requested-with' => 'XMLHttpRequest');
    $token       and $req->header('authorization' => 'Token token="'.$token.'"');
    # We will always post JSON
    $post_data   and $req->header('content-type' => 'application/json; charset=UTF-8');
    $post_data   and $req->content(encode_json($post_data));

    # Execute the HTTP call
    my $res = $ua->request($req);

    # Use eval to prevent Perl dies if the JSON is not valid (50x or 40x errors page for example)
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
