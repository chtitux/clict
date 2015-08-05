# clict
Command Line Interface for [Capitaine Train](https://www.capitainetrain.com/)

# Requirements
You need to install JSON::XS and LWP::Agent Perl modules.
On Debian, they can be found in `libwww-perl` and `libjson-xs-perl` packages.

# Usage
1. Create a `.credentials` file with the following content : `$login:$password`. For example : `test@example.net:h4ckM3`
2. Launch the `./clict.pl` command with `--from` and `--to` arguments :
    `./clict.pl --from=Lille --to=Bordeaux`
3. Read the results in a great ASCII table

```
    $ ./clict.pl --from=Arras --to=Dijon --departure_date=2015-10-15T10:24:00
    Arras                           Dijon Ville                    SNCF
    2015-10-15 09:25:00             2015-10-15 13:36:00                 168 €

    Arras                           Dijon Ville                    SNCF
    2015-10-15 09:25:00             2015-10-15 13:36:00                 102 €

    Arras                           Dijon Ville                    SNCF
    2015-10-15 09:25:00             2015-10-15 13:36:00                 120 €

    Arras                           Dijon Ville                    SNCF
    2015-10-15 09:25:00             2015-10-15 13:36:00                  72 €


```

If you need more options, launch `./clict.pl` without options :

````
    Usage : ./clict.pl --from=<City> --to=<City>
        Arguments :
        --from      : Required, City of the start of the trip
        --to        : Required, City of the end of the trip
        --departure_date : Date in 2015-12-31T10:24:00 format (ISO 8601). If not provided, ./clict.pl use "now"
        --token     : Capitaine Train token.
                      To get the token, log in on https://www.capitainetrain.com/search/ ,
                      open developper console (press F12) and type : console.log(ENV.AUTHORIZATION_TOKEN)
                      clict will automatically get a fresh token with your email and password if the token is not provided
        --email     : email for the login phase
        --password  : password for the login phase. If you do not want to pass your password in the command line,
                      create a .credentials file with $login:$password in it

    Example :
    ./clict.pl --from=Arras --to=Dijon --departure_date=2015-10-15T10:24:00

````

# Limitations
- It only supports login/password authentification. Facebook is not supported for the moment.
- The search is performed for the first passenger found in your account
- The booking is not supported yet

# Notice
This application is **NOT** affiliated with Capitaine Train.
It is just a demo application for playing with the Capitaine (unofficial) API.

It comes with no warranty, and may be deleted if Capitaine Train requires so.
