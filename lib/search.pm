package search;
use strict;
use warnings;
use DBI;
use Dotenv -load; 


my $dsn = sprintf(
    "dbi:Pg:dbname=%s;host=%s;port=%s",
    $ENV{POSTGRES_DB},
    $ENV{POSTGRES_HOST},
    $ENV{POSTGRES_PORT}
);
my $user     = $ENV{POSTGRES_USER};
my $password = $ENV{POSTGRES_PASSWORD};

sub search_data {
    my ($query) = @_;
    return [] unless $query;

    my $dbh = DBI->connect($dsn, $user, $password, { RaiseError => 1, AutoCommit => 1 })
        or die "DB Connect error: $DBI::errstr";

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