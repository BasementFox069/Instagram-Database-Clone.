show databases;
use ig_clone;
show tables;

-- Query 1:
-- Pick the 5 people who have been on Instagram the longest.
select * from users order by created_at limit 5;


-- Query 2:
--  Find the most popular days when users are creating profiles.

    SELECT DAYNAME(created_at) AS day, COUNT(*) AS counts
    FROM users
    GROUP BY day
    ORDER BY counts DESC;
    
-- Query 3:
--  Select users who have never posted a photo on Instagram.

    SELECT username
    FROM users
    LEFT JOIN photos ON users.id = photos.user_id
    WHERE image_url IS NULL;
    
-- Query 4:
--  Which user has the most likes on a single photo?

    SELECT username, photos.id, photos.image_url, COUNT(*) AS total
    FROM photos
    INNER JOIN likes ON likes.photo_id = photos.id
    INNER JOIN users ON photos.user_id = users.id
    GROUP BY photos.id
    ORDER BY total DESC
    LIMIT 1;
    
-- Query 5:
--  Find the five most popular hashtags on Instagram.

    SELECT tags.tag_name, COUNT(*) AS total
    FROM tags
    JOIN photo_tags ON photo_tags.tag_id = tags.id
    GROUP BY tags.tag_name
    ORDER BY total DESC
    LIMIT 5;
    
-- Query 6:
--  Identify the bots who like all the photos in the database.

    SELECT username, COUNT(*) AS total
    FROM users
    JOIN likes ON users.id = likes.user_id
    GROUP BY username
    HAVING total = (SELECT COUNT(*) FROM photos);
 
    
    