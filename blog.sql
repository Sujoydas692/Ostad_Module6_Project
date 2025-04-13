CREATE DATABASE blog;

USE blog;

-- users table
CREATE TABLE users(
    id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- posts table
CREATE TABLE posts(
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    user_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- comments table
CREATE TABLE comments(
    id INT PRIMARY KEY AUTO_INCREMENT,
    comment TEXT NOT NULL,
    post_id INT NOT NULL,
    user_id INT NOT NULL,
    FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


-- insert data into users table
INSERT INTO users(email, password) VALUES('sujoy@gmail.com', 'sujoy');

-- insert data into posts table
INSERT INTO posts(title, content, user_id) VALUES('My Post', 'This is my first post.', 1);

-- insert data into comments table
INSERT INTO comments(comment, post_id, user_id) VALUES('This is my first comment.', 1, 1);


-- get all posts and comments with user information
SELECT user.id AS user_id, user.email AS user_email,
         post.id AS post_id, post.title AS post_title,
         comment.id AS comment_id, comment.comment AS post_comment
FROM users AS user
JOIN posts AS post ON user.id = post.user_id
JOIN comments AS comment ON post.id = comment.post_id
WHERE comment.user_id = user.id;