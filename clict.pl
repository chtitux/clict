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

print Dumper(Station::findFolders(
    from    => $from,
    to      => $to,
    token   => $token,
));


sub printHelpAndExit
{
    print <<EOF;
Usage : $0 --from=<City> --to=<City>
    <City> must be replaced with a real city with a station handled by Capitaine Train.
EOF
    exit 0;
}
