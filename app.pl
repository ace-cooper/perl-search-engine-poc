#!/usr/bin/env perl
use strict;
use warnings;
use Dancer2;
use FindBin;
use lib "$FindBin::Bin/.";  # Adiciona diretório atual ao @INC
use search;                 # Importa módulo de busca

# Endpoint de busca
get '/search' => sub {
    my $query = query_parameters->get('q') // '';
    my $results = search::search_data($query);
    return to_json($results);
};

start;