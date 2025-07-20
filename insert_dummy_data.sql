-- insert in Users
DELIMITER //

CREATE PROCEDURE InsertUsers()
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= 1000 DO
        INSERT INTO Users (username, email)
        VALUES (
            CONCAT('user', i),
            CONCAT('user', i, '@example.com')
        );
        SET i = i + 1;
    END WHILE;
END //

DELIMITER ;

CALL InsertUsers();
DROP PROCEDURE InsertUsers;


-- insert in Posts
DELIMITER //

CREATE PROCEDURE InsertPosts()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE max_user INT;
    SELECT MAX(user_id) INTO max_user FROM Users;

    WHILE i <= max_user * 2 DO
        INSERT INTO Posts (user_id, content)
        VALUES (
            FLOOR(1 + RAND() * max_user), 
            CONCAT('This is a sample post content number ', i)
        );
        SET i = i + 1;
    END WHILE;
END //

DELIMITER ;

CALL InsertPosts();
DROP PROCEDURE InsertPosts;


-- insert in Likes
DELIMITER //

CREATE PROCEDURE InsertLikes()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE max_user INT;
    DECLARE max_post INT;
    SELECT MAX(user_id) INTO max_user FROM Users;
    SELECT MAX(post_id) INTO max_post FROM Posts;

    WHILE i <= 3000 DO
        INSERT INTO Likes (post_id, user_id)
        VALUES (
            FLOOR(1 + RAND() * max_post),
            FLOOR(1 + RAND() * max_user)
        );
        SET i = i + 1;
    END WHILE;
END //

DELIMITER ;

CALL InsertLikes();
DROP PROCEDURE InsertLikes;


-- insert in Comments
DELIMITER //

CREATE PROCEDURE InsertComments()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE max_user INT;
    DECLARE max_post INT;
    SELECT MAX(user_id) INTO max_user FROM Users;
    SELECT MAX(post_id) INTO max_post FROM Posts;

    WHILE i <= 1500 DO
        INSERT INTO Comments (post_id, user_id, comment_text)
        VALUES (
            FLOOR(1 + RAND() * max_post),
            FLOOR(1 + RAND() * max_user),
            CONCAT('This is a sample comment number ', i)
        );
        SET i = i + 1;
    END WHILE;
END //

DELIMITER ;

CALL InsertComments();
DROP PROCEDURE InsertComments;
