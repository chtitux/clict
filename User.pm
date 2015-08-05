#!/usr/bin/perl
use strict;
package User;
use Http;

sub getCredentials
{
    my %params = @_;
    my $email   = $params{email};
    my $password= $params{password};
    my $post_data = {
        "email"             => $email,
        "password"          => $password,
        "facebook_id"       =>undef,
        "facebook_token"    =>undef,
        "google_id"         =>undef,
        "google_code"       =>undef,
        "godparent_token"   =>undef,
        "source"            =>undef,
        "correlation_key"   =>undef,
        "user_id"           =>undef,
    };
    $password = undef;

    my $jsonObject = Http::request(
        url         => 'account/signin',
        method      => 'POST',
        ajax_header => 1,
        post_data   => $post_data,
    );
    not $jsonObject and return $jsonObject;

    return $jsonObject;
}

1;
