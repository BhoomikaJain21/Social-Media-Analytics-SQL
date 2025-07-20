ALTER TABLE Posts ADD COLUMN like_count INT DEFAULT 0;


-- Trigger: After Insert on Likes
DELIMITER $$

CREATE TRIGGER trg_after_like_insert
AFTER INSERT ON Likes
FOR EACH ROW
BEGIN
  UPDATE Posts SET like_count = like_count + 1 WHERE post_id = NEW.post_id;
END$$

DELIMITER ;


-- Trigger: After Delete on Likes
DELIMITER $$

CREATE TRIGGER trg_after_like_delete
AFTER DELETE ON Likes
FOR EACH ROW
BEGIN
  UPDATE Posts SET like_count = like_count - 1 WHERE post_id = OLD.post_id;
END$$

DELIMITER ;


-- Function to Calculate Total Engagement (Likes + Comments) for a Post
DELIMITER $$

CREATE FUNCTION fn_post_engagement(p_post_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
  DECLARE total_engagement INT DEFAULT 0;

  SELECT (COALESCE(likes_count, 0) + COALESCE(comments_count, 0)) INTO total_engagement
  FROM (
    SELECT
      (SELECT COUNT(*) FROM Likes WHERE post_id = p_post_id) AS likes_count,
      (SELECT COUNT(*) FROM Comments WHERE post_id = p_post_id) AS comments_count
  ) AS counts;

  RETURN total_engagement;
END$$

DELIMITER ;

-- Use function as:
SELECT fn_post_engagement(5) AS engagement_for_post_5;


-- Trigger to Automatically Update Comment Count in Posts Table
-- Add a comment_count column:
ALTER TABLE Posts ADD COLUMN comment_count INT DEFAULT 0;
Create triggers:
DELIMITER $$

CREATE TRIGGER trg_after_comment_insert
AFTER INSERT ON Comments
FOR EACH ROW
BEGIN
  UPDATE Posts SET comment_count = comment_count + 1 WHERE post_id = NEW.post_id;
END$$

CREATE TRIGGER trg_after_comment_delete
AFTER DELETE ON Comments
FOR EACH ROW
BEGIN
  UPDATE Posts SET comment_count = comment_count - 1 WHERE post_id = OLD.post_id;
END$$

DELIMITER ;
