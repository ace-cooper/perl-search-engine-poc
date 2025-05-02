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

    # Use full-text search and trigram similarity, return similarity score instead of id
    my $sth = $dbh->prepare(
        q{
            SELECT GREATEST(similarity(title, ?), similarity(description, ?)) AS similarity_score, title, description
            FROM articles
            WHERE tsv @@ plainto_tsquery('english', ?)
               OR similarity(title, ?) > 0.3
               OR similarity(description, ?) > 0.3
            ORDER BY similarity_score DESC
            LIMIT 20
        }
    );
    $sth->execute($query, $query, $query, $query, $query);

    my @results;
    while (my $row = $sth->fetchrow_hashref) {
        push @results, $row;
    }

    $sth->finish;
    $dbh->disconnect;

    return \@results;
}

1;