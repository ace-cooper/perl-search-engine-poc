# Perl Search Engine POC

This project is a simple proof of concept (POC) for learning Perl, Docker, and basic web application development. It demonstrates how to build a minimal search engine using Perl's Dancer2 web framework and PostgreSQL as the database.

## Features
- Simple web API to search articles by title or description
- Uses Dancer2 for the web server
- PostgreSQL for data storage
- Dockerized setup for easy development and testing

## Getting Started

### Prerequisites
- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)

### Running the Project
1. Clone this repository:
   ```sh
   git clone <repo-url>
   cd perl-search-engine-poc
   ```
2. Copy the example environment file and adjust if needed:
   ```sh
   cp .env.template .env
   # Edit .env if you want to change database credentials
   ```
3. Start the application and database:
   ```sh
   docker-compose up --build
   ```
4. The web app will be available at [http://localhost:3000/search?q=your_query](http://localhost:3000/search?q=your_query)

### Example API Usage
- Search for articles:
  ```sh
  curl 'http://localhost:3000/search?q=privacy'
  ```

## Project Structure
- `bin/app.pl` - Main application entry point
- `lib/search.pm` - Search logic and database connection
- `data/seed.sql` - SQL script to initialize the database
- `docker-compose.yml` - Docker Compose setup
- `Dockerfile` - App container definition

## Notes
- This project is for learning purposes only and is not production-ready.
- Feel free to experiment and modify the code to explore Perl and Docker further.

## License
This project is released under the MIT License.