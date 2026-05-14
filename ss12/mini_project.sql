CREATE DATABASE social_network_db;
USE social_network_db;


CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE posts (
    post_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    content TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_posts_user
    FOREIGN KEY (user_id)
    REFERENCES users(user_id)
    ON DELETE CASCADE
);

CREATE TABLE comments (
    comment_id INT PRIMARY KEY AUTO_INCREMENT,
    post_id INT NOT NULL,
    user_id INT NOT NULL,
    content TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_comments_post
    FOREIGN KEY (post_id)
    REFERENCES posts(post_id)
    ON DELETE CASCADE,

    CONSTRAINT fk_comments_user
    FOREIGN KEY (user_id)
    REFERENCES users(user_id)
    ON DELETE CASCADE
);

CREATE TABLE friends (
    user_id INT NOT NULL,
    friend_id INT NOT NULL,
    status VARCHAR(20),

    PRIMARY KEY (user_id, friend_id),

    CONSTRAINT chk_friend_self
    CHECK (user_id != friend_id),

    CONSTRAINT chk_friend_status
    CHECK (status IN ('pending', 'accepted')),

    CONSTRAINT fk_friends_user
    FOREIGN KEY (user_id)
    REFERENCES users(user_id)
    ON DELETE CASCADE,

    CONSTRAINT fk_friends_friend
    FOREIGN KEY (friend_id)
    REFERENCES users(user_id)
    ON DELETE CASCADE
);

CREATE TABLE likes (
    user_id INT NOT NULL,
    post_id INT NOT NULL,

    PRIMARY KEY (user_id, post_id),

    CONSTRAINT fk_likes_user
    FOREIGN KEY (user_id)
    REFERENCES users(user_id)
    ON DELETE CASCADE,

    CONSTRAINT fk_likes_post
    FOREIGN KEY (post_id)
    REFERENCES posts(post_id)
    ON DELETE CASCADE
);



-- REQ-01
CREATE VIEW vw_userinfo AS
SELECT
    user_id,
    username,
    email,
    created_at
FROM users;

-- REQ-02
CREATE VIEW vw_poststatistics AS
SELECT
    p.post_id,
    p.content,
    u.username,
    COUNT(DISTINCT l.user_id) AS total_likes,
    COUNT(DISTINCT c.comment_id) AS total_comments
FROM posts p
LEFT JOIN users u
ON p.user_id = u.user_id
LEFT JOIN likes l
ON p.post_id = l.post_id
LEFT JOIN comments c
ON p.post_id = c.post_id
GROUP BY
    p.post_id,
    p.content,
    u.username;

-- REQ-03
DELIMITER //

CREATE PROCEDURE sp_register_user (
    IN p_username VARCHAR(50),
    IN p_password VARCHAR(255),
    IN p_email VARCHAR(100)
)
BEGIN
    DECLARE email_count INT;

    SELECT COUNT(*)
    INTO email_count
    FROM users
    WHERE email = p_email;

    IF email_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Email đã được sử dụng';
    ELSE
        INSERT INTO users(username, password, email)
        VALUES (p_username, p_password, p_email);
    END IF;
END //

DELIMITER ;

-- REQ-04
DELIMITER //

CREATE PROCEDURE sp_create_post (
    IN p_user_id INT,
    IN p_content TEXT,
    OUT p_post_id INT
)
BEGIN
    INSERT INTO posts(user_id, content)
    VALUES (p_user_id, p_content);

    SET p_post_id = LAST_INSERT_ID();
END //

DELIMITER ;

-- REQ-05
DELIMITER //

CREATE PROCEDURE sp_get_friends_paginated (
    IN p_user_id INT,
    IN p_limit INT,
    IN p_offset INT
)
BEGIN
    SELECT
        u.username,
        u.email
    FROM friends f
    INNER JOIN users u
    ON f.friend_id = u.user_id
    WHERE f.user_id = p_user_id
    AND f.status = 'accepted'
    LIMIT p_limit OFFSET p_offset;
END //

DELIMITER ;

-- REQ-06
CREATE INDEX idx_post_created_at
ON posts(created_at);