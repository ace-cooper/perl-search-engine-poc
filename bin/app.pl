#!/usr/bin/env perl
use strict;
use warnings;
use Dancer2;
use FindBin;
use lib "$FindBin::Bin/../lib";
use search;                


get '/search' => sub {
    my $query = query_parameters->get('q') // '';
    my $results = search::search_data($query);
    
    response_header('Content-Type' => 'application/json');

    return to_json($results);
};

start;