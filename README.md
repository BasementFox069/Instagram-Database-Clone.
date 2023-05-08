# Instagram-Database-Clone.
I recently had the opportunity to work with an Instagram database clone, where I used my SQL skills to query and manipulate the data. I was able to write complex SQL statements to retrieve specific information from the database, such as user profiles, posts, comments, and likes.


Instagram Database Clone

Created: April 14, 2023 9:55 PM
Overview:
This Document contains SQL queries for an Instagram clone database. Here are the six different queries:
1. Pick the 5 people who have been on Instagram the longest.
2. Find the most popular days when users are creating profiles.
3. Select users who have never posted a photo on Instagram.
4. Which user has the most likes on a single photo?
5. Find the five most popular hashtags on Instagram.
6. Identify the bots who like all the photos in the database.

PS:Note that the SQL queries use a sample database and table names different from Instagram's actual database. However, the queries can give you an idea of how you can use SQL to analyze Instagram data.

Query 1: 
--  Pick the 5 people who have been on Instagram the longest.
    
    SELECT * FROM users ORDER BY created_at LIMIT 5;
    
    '80','Darby_Herzog','2016-05-06 00:14:21'
    '67','Emilio_Bernier52','2016-05-06 13:04:30'
    '63','Elenor88','2016-05-08 01:30:41'
    '95','Nicole71','2016-05-09 17:30:22'
    '38','Jordyn.Jacobson2','2016-05-14 07:56:26'


+----+------------------+---------------------+
| id | username         | created_at          |
+----+------------------+---------------------+
| 80 | Darby_Herzog     | 2016-05-06 00:14:21 |
| 67 | Emilio_Bernier52 | 2016-05-06 13:04:30 |
| 63 | Elenor88         | 2016-05-08 01:30:41 |
| 95 | Nicole71         | 2016-05-09 17:30:22 |
| 38 | Jordyn.Jacobson2 | 2016-05-14 07:56:26 |
+----+------------------+---------------------+
5 rows in set (0.01 sec)

   -> This query selects the first five rows from the users table, ordered by the created_at column. This gives us the five users who have been on Instagram the longest.


Query 2: 
--  Find the most popular days when users are creating profiles.

    SELECT DAYNAME(created_at) AS day, COUNT(*) AS counts
    FROM users
    GROUP BY day
    ORDER BY counts DESC;
    
+-----------+--------+
| day       | counts |
+-----------+--------+
| Thursday  |     16 |
| Sunday    |     16 |
| Friday    |     15 |
| Tuesday   |     14 |
| Monday    |     14 |
| Wednesday |     13 |
| Saturday  |     12 |
+-----------+--------+
7 rows in set (0.00 sec)

   -> This query groups the users table by the day of the week (DAYNAME(created_at)). It then counts the number of users who created their accounts on each day, and returns the results in descending order.


Query 3: 
--  Select users who have never posted a photo on Instagram.

    SELECT username
    FROM users
    LEFT JOIN photos ON users.id = photos.user_id
    WHERE image_url IS NULL;

+---------------------+
| username            |
+---------------------+
| Aniya_Hackett       |
| Bartholome.Bernhard |
| Bethany20           |
| Darby_Herzog        |
| David.Osinski47     |
| Duane60             |
| Esmeralda.Mraz57    |
| Esther.Zulauf61     |
| Franco_Keebler64    |
| Hulda.Macejkovic    |
| Jaclyn81            |
| Janelle.Nikolaus81  |
| Jessyca_West        |
| Julien_Schmidt      |
| Kasandra_Homenick   |
| Leslie67            |
| Linnea59            |
| Maxwell.Halvorson   |
| Mckenna17           |
| Mike.Auer39         |
| Morgan.Kassulke     |
| Nia_Haag            |
| Ollie_Ledner37      |
| Pearl7              |
| Rocio33             |
| Tierra.Trantow      |
+---------------------+
26 rows in set (0.01 sec)


   --> This query selects all the usernames from the users table that do not have corresponding rows in the photos table. This means that these users have not posted a photo on Instagram.


Query 4: 

--  Which user has the most likes on a single photo?

    SELECT username, photos.id, photos.image_url, COUNT(*) AS total
    FROM photos
    INNER JOIN likes ON likes.photo_id = photos.id
    INNER JOIN users ON photos.user_id = users.id
    GROUP BY photos.id
    ORDER BY total DESC
    LIMIT 1;
    
    
+---------------+-----+---------------------+-------+
| username      | id  | image_url           | total |
+---------------+-----+---------------------+-------+
| Zack_Kemmer93 | 145 | https://jarret.name |    48 |
+---------------+-----+---------------------+-------+


   --> This query joins the photos, likes, and users tables to find the photo with the most likes. It returns the username, id, and image_url of the photo, along with the total number of likes (COUNT(*) AS total). The results are ordered by the total number of likes in descending order, and limited to the first row.


Query 5: 

--  Find the five most popular hashtags on Instagram.

    SELECT tags.tag_name, COUNT(*) AS total
    FROM tags
    JOIN photo_tags ON photo_tags.tag_id = tags.id
    GROUP BY tags.tag_name
    ORDER BY total DESC
    LIMIT 5;
    
+----------+-------+
| tag_name | total |
+----------+-------+
| smile    |    59 |
| beach    |    42 |
| party    |    39 |
| fun      |    38 |
| concert  |    24 |
+----------+-------+


   --> This query groups the tags table by tag name, and then counts the number of times each tag appears in the photo_tags table. The results are ordered by the total number of tag occurrences in descending order, and limited to the top five.


Query 6: 

--  Identify the bots who like all the photos in the database.

    SELECT username, COUNT(*) AS total
    FROM users
    JOIN likes ON users.id = likes.user_id
    GROUP BY username
    HAVING total = (SELECT COUNT(*) FROM photos);

+--------------------+-------+
| username           | total |
+--------------------+-------+
| Aniya_Hackett      |   257 |
| Bethany20          |   257 |
| Duane60            |   257 |
| Jaclyn81           |   257 |
| Janelle.Nikolaus81 |   257 |
| Julien_Schmidt     |   257 |
| Leslie67           |   257 |
| Maxwell.Halvorson  |   257 |
| Mckenna17          |   257 |
| Mike.Auer39        |   257 |
| Nia_Haag           |   257 |
| Ollie_Ledner37     |   257 |
| Rocio33            |   257 |
+--------------------+-------+



   --> This query groups the users table by username, and then counts the number of likes each user has given in the likes table. The query filters the results to only include users who have liked every photo in the photos table, which is typically unusual for a human entity to do so.
