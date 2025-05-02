use strict;
use warnings;
use Test::More tests => 2;
use Plack::Test;
use HTTP::Request::Common;
use FindBin;
use lib "$FindBin::Bin/../lib";


require "$FindBin::Bin/../bin/app.pl";

my $app = Dancer2->psgi_app;

test_psgi $app, sub {
    my $cb = shift;

   
    my $res = $cb->(GET "/search?q=privacy");
    ok($res->content =~ /Privacy First Search/, "Search for 'privacy' returns results");

 
    $res = $cb->(GET "/search?q=banana");
    ok($res->content !~ /Privacy First Search/, "Search for 'banana' returns no results");
};