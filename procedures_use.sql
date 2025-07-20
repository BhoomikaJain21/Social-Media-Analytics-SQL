-- 1. Delete a Post and its Likes/Comments
DELIMITER $$

CREATE PROCEDURE sp_delete_post(
    IN p_post_id INT
)
BEGIN
    DELETE FROM Likes WHERE post_id = p_post_id;
    DELETE FROM Comments WHERE post_id = p_post_id;
    DELETE FROM Posts WHERE post_id = p_post_id;
END$$


-- 2. Get Top N Posts by Engagement
CREATE PROCEDURE sp_top_posts(
    IN p_limit INT
)
BEGIN
    SELECT 
        p.post_id,
        p.content,
        p.like_count,
        p.comment_count,
        (p.like_count + p.comment_count) AS total_engagement
    FROM Posts p
    ORDER BY total_engagement DESC
    LIMIT p_limit;
END$$


-- 3. Refresh Like and Comment Counts for a Post
CREATE PROCEDURE sp_refresh_post_counts(
    IN p_post_id INT
)
BEGIN
    UPDATE Posts p
    SET
        p.like_count = (SELECT COUNT(*) FROM Likes WHERE post_id = p_post_id),
        p.comment_count = (SELECT COUNT(*) FROM Comments WHERE post_id = p_post_id)
    WHERE p.post_id = p_post_id;
END$$


-- 4. Get User Activity Summary
CREATE PROCEDURE sp_user_activity(
    IN p_user_id INT
)
BEGIN
    SELECT 
        u.user_id,
        u.username,
        (SELECT COUNT(*) FROM Posts WHERE user_id = p_user_id) AS total_posts,
        (SELECT COUNT(*) FROM Likes WHERE user_id = p_user_id) AS total_likes_given,
        (SELECT COUNT(*) FROM Comments WHERE user_id = p_user_id) AS total_comments_made
    FROM Users u
    WHERE u.user_id = p_user_id;
END$$


-- 5. Update User Email
CREATE PROCEDURE sp_upsert_user_email(
    IN p_user_id INT,
    IN p_email VARCHAR(255)
)
BEGIN
    UPDATE Users
    SET email = p_email
    WHERE user_id = p_user_id;
END$$

DELIMITER ;


-- ==============================================


-- 1. Delete post with post_id = 10
CALL sp_delete_post(10);


-- 2. Get top 5 posts by engagement
CALL sp_top_posts(5);


-- 3. Refresh like and comment counts for post_id = 15
CALL sp_refresh_post_counts(15);
SELECT post_id, like_count, comment_count FROM Posts WHERE post_id = 15;


-- 4. Get activity summary for user_id = 20
CALL sp_user_activity(20);


-- 5. Update email for user_id = 25
CALL sp_upsert_user_email(25, 'newemail25@example.com');
SELECT user_id, username, email FROM Users WHERE user_id = 25;
