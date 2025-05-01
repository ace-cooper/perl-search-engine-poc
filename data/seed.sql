CREATE TABLE IF NOT EXISTS articles (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    description TEXT NOT NULL
);

INSERT INTO articles (title, description) VALUES
('Privacy First Search', 'A search engine that respects your privacy.'),
('Open Source Tools', 'A collection of open source backend tools.'),
('Perl Web Frameworks', 'Learn about Dancer2 and Mojolicious.');