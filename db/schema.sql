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
    email TEXT UNIQUE, -- email isn't unique cos of this, i coded bad stuff
    password_digest TEXT NOT NULL --isn't actually not null or unique, dt was giving examples
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


CREATE TABLE tester_with_dt (
    id SERIAL PRIMARY KEY,
    user_id INTEGER, 
    duck_id INTEGER,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE -- this tells the db that user_id connects to the users table, at ID, and if you delete the user, delete their comments too
    FOREIGN KEY (duck_id) REFERENCES ducks(id) ON DELETE CASCADE 
);

CREATE TABLE test_users_post_project (
    id SERIAL PRIMARY KEY,
    email TEXT UNIQUE, 
    password_digest TEXT NOT NULL,
    is_admin BOOLEAN -- if you only need one roll, a boolean is fine, otherwise ROLES might be better
);
