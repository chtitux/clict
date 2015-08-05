#!/usr/bin/perl
use strict;
use Getopt::Long;
use Station;
use User;
use Data::Dumper;

my $LOGIN_FILE = '.credentials';

my ($from, $to,);
my ($email, $password, $token);

# Read credentials from file if the file exists
if(-f $LOGIN_FILE and open CREDS, '<', $LOGIN_FILE)
{
    my $credentials = <CREDS>;
    chomp($credentials);
    ($email, $password) = split(':', $credentials);
}

# Read arguments from command line
GetOptions(
    "from=s"     => \$from,
    "to=s"       => \$to,
    "email=s"    => \$email,
    "password=s" => \$password,
    "token=s"    => \$token,
);

if(not ($from and $to))
{
    printHelpAndExit();
}

# If the token is not filled from command line arguments, get a new one from CT
if(not $token)
{
    if(not ($email and $password))
    {
        print STDERR "Email or password not set. Please use --email and --password, or write a .credentials file with \$email:\$password\n";
        exit 1;
    }
    my $credentials = User::getCredentials(
        email   => $email,
        password=> $password,
    );
    $token = $credentials->{meta}->{token};
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
