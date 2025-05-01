use strict;
use warnings;
use Test::More tests => 2;
use Plack::Test;
use HTTP::Request::Common;
use Dancer2;

# Carrega a aplicação
require './app.pl';

my $app = Dancer2->psgi_app;

test_psgi $app, sub {
    my $cb = shift;

    # Teste de busca existente
    my $res = $cb->(GET "/search?q=privacy");
    ok($res->content =~ /Privacy First Search/, "Busca retorna resultado esperado");

    # Teste de busca inexistente
    $res = $cb->(GET "/search?q=banana");
    ok($res->content !~ /Privacy First Search/, "Busca vazia retorna vazio");
};