package search;
use strict;
use warnings;
use DBI;
use Dotenv -load;  # Carrega variáveis do .env automaticamente

# Lê as variáveis de ambiente
my $dsn = sprintf(
    "dbi:Pg:dbname=%s;host=%s;port=%s",
    $ENV{PGDATABASE},
    $ENV{PGHOST},
    $ENV{PGPORT}
);
my $user     = $ENV{PGUSER};
my $password = $ENV{PGPASSWORD};

sub search_data {
    my ($query) = @_;
    return [] unless $query;

    my $dbh = DBI->connect($dsn, $user, $password, { RaiseError => 1, AutoCommit => 1 })
        or die "Não foi possível conectar ao banco: $DBI::errstr";

    my $sth = $dbh->prepare(
        "SELECT id, title, description FROM articles WHERE title ILIKE ? OR description ILIKE ?"
    );
    my $like = '%' . $query . '%';
    $sth->execute($like, $like);

    my @results;
    while (my $row = $sth->fetchrow_hashref) {
        push @results, $row;
    }

    $sth->finish;
    $dbh->disconnect;

    return \@results;
}

1;