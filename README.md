# clict
Command Line Interface for [Capitaine Train](https://www.capitainetrain.com/)

# Requirements
You need to install JSON::XS and LWP::Agent Perl modules.

# Usage
1. Create a `.credentials` file with the following content : `$login:$password`. For example : `test@example.net:h4ckM3`
2. Launch the ./clict.pl command with --from and --to arguments : `./clict.pl --from=Lille --to=Bordeaux`
3. Read the results in a great ASCII table

# Limitations
It only support login/password authentification. Facebook is not supported for the moment.

# Notice
This application is **NOT** affiliated with Capitaine Train.
It is just a demo application for playing with the Capitaine (unofficial) API.

It comes with no warranty, and may be deleted if Capitaine Train requires so.
