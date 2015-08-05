#!/usr/bin/perl
use strict;
use Getopt::Long;
use Station;
use Data::Dumper;

my ($from, $to, $token);
GetOptions(
    "from=s" => \$from,
    "to=s"   => \$to,
    "token=s"=> \$token,
);

if(not ($from and $to))
{
    printHelpAndExit();
}

my $trips = Station::findFolders(
    from    => $from,
    to      => $to,
    token   => $token,
    pretty_print    => 1,
);
print Search::foldersPrettyPrint(
    trips   => $trips,
);

sub printHelpAndExit
{
    print <<EOF;
Usage : $0 --from=<City> --to=<City> --token=<CT token>
    <City> must be replaced with a real city with a station handled by Capitaine Train.
    <CT token> is the token provided by Capitaine Train.
    To get the token, log in on https://www.capitainetrain.com/search/ , open developper console (press F12) and type : console.log(ENV.AUTHORIZATION_TOKEN)

EOF
    exit 0;
}
