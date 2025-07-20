-- Insert a new like for post_id = 1
INSERT INTO Likes (post_id, user_id, liked_at) VALUES (1, 2, NOW());


-- Insert a new comment for post_id = 1
INSERT INTO Comments (post_id, user_id, comment_text, commented_at) VALUES (1, 3, 'Great post!', NOW());


-- Check Posts table for updated counts (should reflect changes if triggers are active)
SELECT post_id, like_count, comment_count FROM Posts WHERE post_id = 1;


-- Delete the like inserted above
DELETE FROM Likes WHERE post_id = 1 AND user_id = 2 ORDER BY liked_at DESC LIMIT 1;


-- Delete the comment inserted above
DELETE FROM Comments WHERE post_id = 1 AND user_id = 3 AND comment_text = 'Great post!' ORDER BY commented_at DESC LIMIT 1;


-- Check Posts table counts again
SELECT post_id, like_count, comment_count FROM Posts WHERE post_id = 1;