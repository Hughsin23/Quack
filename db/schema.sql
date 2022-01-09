CREATE DATABASE show_us_your_quack;

CREATE TABLE ducks (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200),
    image_url TEXT,
    location_spotted TEXT,
    user_id INTEGER,
    likes_count INTEGER,
    comments_count INTEGER
);

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email TEXT,
    password_digest TEXT
);

CREATE TABLE comments (
    id SERIAL PRIMARY KEY,
    content VARCHAR(255),
    user_id INTEGER,
    duck_id INTEGER
);

CREATE TABLE likes (
    id SERIAL PRIMARY KEY,
    user_id INTEGER, 
    duck_id INTEGER 
);



