-- Top 10 Users by Number of Posts
CREATE OR REPLACE VIEW view_top_users_by_posts AS
SELECT u.user_id, u.username, COUNT(p.post_id) AS total_posts
FROM Users u
LEFT JOIN Posts p ON u.user_id = p.user_id
GROUP BY u.user_id, u.username
ORDER BY total_posts DESC
LIMIT 10;

SELECT * FROM view_top_users_by_posts;


-- Top 10 Most Liked Posts
CREATE OR REPLACE VIEW view_top_liked_posts AS
SELECT p.post_id, p.content, COUNT(l.like_id) AS total_likes
FROM Posts p
LEFT JOIN Likes l ON p.post_id = l.post_id
GROUP BY p.post_id, p.content
ORDER BY total_likes DESC
LIMIT 10;

SELECT * FROM view_top_liked_posts;


-- Average Likes per Post per User
CREATE OR REPLACE VIEW view_avg_likes_per_user AS
SELECT u.user_id, u.username, 
       AVG(likes_count) AS avg_likes_per_post
FROM Users u
LEFT JOIN (
    SELECT p.user_id, p.post_id, COUNT(l.like_id) AS likes_count
    FROM Posts p
    LEFT JOIN Likes l ON p.post_id = l.post_id
    GROUP BY p.post_id
) post_likes ON u.user_id = post_likes.user_id
GROUP BY u.user_id, u.username
ORDER BY avg_likes_per_post DESC;

SELECT * FROM view_avg_likes_per_user;


-- Posts with No Likes
CREATE OR REPLACE VIEW view_posts_no_likes AS
SELECT p.post_id, p.content
FROM Posts p
LEFT JOIN Likes l ON p.post_id = l.post_id
WHERE l.like_id IS NULL;

SELECT * FROM view_posts_no_likes;


-- Top 10 Most Commented Posts
CREATE OR REPLACE VIEW view_top_commented_posts AS
SELECT p.post_id, p.content, COUNT(c.comment_id) AS total_comments
FROM Posts p
LEFT JOIN Comments c ON p.post_id = c.post_id
GROUP BY p.post_id, p.content
ORDER BY total_comments DESC
LIMIT 10;

SELECT * FROM view_top_commented_posts;


-- Users with Most Likes Given (Top 10)
CREATE OR REPLACE VIEW view_top_users_likes_given AS
SELECT u.user_id, u.username, COUNT(l.like_id) AS likes_given
FROM Users u
LEFT JOIN Likes l ON u.user_id = l.user_id
GROUP BY u.user_id, u.username
ORDER BY likes_given DESC
LIMIT 10;

SELECT * FROM view_top_users_likes_given;


-- Posts Without Any Comments or Likes
CREATE OR REPLACE VIEW view_posts_no_engagement AS
SELECT p.post_id, p.content
FROM Posts p
LEFT JOIN Comments c ON p.post_id = c.post_id
LEFT JOIN Likes l ON p.post_id = l.post_id
WHERE c.comment_id IS NULL AND l.like_id IS NULL;

SELECT * FROM view_posts_no_engagement;
