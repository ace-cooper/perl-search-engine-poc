FROM perl:5.38

RUN apt-get update && apt-get install -y \
    libpq-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Installing cpanminus for Perl module management
RUN cpan App::cpanminus


WORKDIR /usr/src/app
COPY . .

# Installing Perl dependencies
RUN cpanm --notest Dancer2 JSON DBI DBD::Pg Dotenv Plack::Test Test::More HTTP::Request::Common

# Exposing the port the app runs on
EXPOSE 3000

# Comando para rodar o app
CMD ["perl", "app.pl"]