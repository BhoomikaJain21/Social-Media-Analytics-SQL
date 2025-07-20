-- Top 10 Users by Number of Posts
SELECT u.user_id, u.username, COUNT(p.post_id) AS total_posts
FROM Users u
LEFT JOIN Posts p ON u.user_id = p.user_id
GROUP BY u.user_id, u.username
ORDER BY total_posts DESC
LIMIT 10;


-- Top 10 Most Liked Posts
SELECT p.post_id, p.content, COUNT(l.like_id) AS total_likes
FROM Posts p
LEFT JOIN Likes l ON p.post_id = l.post_id
GROUP BY p.post_id, p.content
ORDER BY total_likes DESC
LIMIT 10;


-- Average Number of Likes per Post per User (limited to top 10)
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
ORDER BY avg_likes_per_post DESC
LIMIT 10;


-- Total Comments per User (limited to top 10)
SELECT u.user_id, u.username, COUNT(c.comment_id) AS total_comments
FROM Users u
LEFT JOIN Comments c ON u.user_id = c.user_id
GROUP BY u.user_id, u.username
ORDER BY total_comments DESC
LIMIT 10;


-- Posts with No Likes
SELECT p.post_id, p.content
FROM Posts p
LEFT JOIN Likes l ON p.post_id = l.post_id
WHERE l.like_id IS NULL;


-- Users Who Commented but Never Posted
SELECT u.user_id, u.username
FROM Users u
LEFT JOIN Posts p ON u.user_id = p.user_id
INNER JOIN Comments c ON u.user_id = c.user_id
WHERE p.post_id IS NULL
GROUP BY u.user_id, u.username;


-- Number of Comments per User per Post (Example for Post ID = 5)
SELECT u.user_id, u.username, COUNT(c.comment_id) AS comments_count
FROM Users u
INNER JOIN Comments c ON u.user_id = c.user_id
WHERE c.post_id = 5
GROUP BY u.user_id, u.username
ORDER BY comments_count DESC;


-- Top 5 Most Active Users (Based on Posts + Comments + Likes Given)
SELECT u.user_id, u.username,
       COALESCE(p.post_count,0) + COALESCE(c.comment_count,0) + COALESCE(l.likes_given,0) AS activity_score
FROM Users u
LEFT JOIN (
    SELECT user_id, COUNT(*) AS post_count FROM Posts GROUP BY user_id
) p ON u.user_id = p.user_id
LEFT JOIN (
    SELECT user_id, COUNT(*) AS comment_count FROM Comments GROUP BY user_id
) c ON u.user_id = c.user_id
LEFT JOIN (
    SELECT user_id, COUNT(*) AS likes_given FROM Likes GROUP BY user_id
) l ON u.user_id = l.user_id
ORDER BY activity_score DESC
LIMIT 5;
