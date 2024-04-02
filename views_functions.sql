--Views

GO
CREATE VIEW Podcast.User_Favourite_Podcasts AS
SELECT u.FirstName, u.LastName, p.PodcastName
FROM Podcast.Users as u
INNER JOIN Podcast.Favorite as f
ON u.UsersID = f.UsersID
INNER JOIN Podcast.Podcasts as p
ON f.PodcastID = p.PodcastID;
GO

SELECT * FROM Podcast.User_Favourite_Podcasts;


GO
CREATE VIEW Podcast.User_Download_Podcasts AS
SELECT u.FirstName, u.LastName, p.PodcastName
FROM Podcast.Users as u
INNER JOIN Podcast.Downloads as d
ON u.UsersID = d.Users_UsersID
INNER JOIN Podcast.Podcasts as p
ON d.Podcasts_PodcastID = p.PodcastID;
GO

SELECT * FROM Podcast.User_Download_Podcasts;



GO
CREATE VIEW Podcast.Speaker_Collection_Podcast AS
SELECT a.Speaker_Name, b.CollectionName, s.PodcastName
FROM Podcast.Speakers AS a
INNER JOIN Podcast.Speaker_Collection AS aa
ON a.SpeakerID = aa.Speaker_SpeakerID
INNER JOIN Podcast.Collection b 
ON aa.Collection_CollectionID = b.CollectionID
INNER JOIN Podcast.Podcasts_Collection sa
ON sa.CollectionID = b.CollectionID
INNER JOIN Podcast.Podcasts s
ON s.PodcastID = sa.PodcastID;
GO

SELECT * FROM Podcast.Speaker_Collection_Podcast;

--Functions

GO
CREATE FUNCTION Podcast.numFavoritesUser
(@userid int)
RETURNS int 
AS 
BEGIN
 DECLARE @counter int;
 SELECT @counter = COUNT(*) FROM 
  (SELECT * FROM Podcast.Favorite f 
   WHERE f.UsersID = @userid )t
     JOIN Podcast.Users u ON u.UsersID = @userid;
 RETURN @counter;
END;
GO 

SELECT u.UserName, Podcast.numFavoritesUser(2) AS Num_Favorites
FROM Podcast.Users u
WHERE u.UsersID = 2;

GO
CREATE FUNCTION Podcast.numDownloadsUser
(@userid int)
RETURNS int 
AS 
BEGIN
 DECLARE @counter int;
 SELECT @counter = COUNT(*) FROM 
  (SELECT * FROM Podcast.Downloads d
   WHERE d.Users_UsersID = @userid )t
     JOIN Podcast.Users u ON u.UsersID = @userid;
 RETURN @counter;
END
GO

SELECT u.UserName, Podcast.numDownloadsUser(10) AS Num_Downloads
FROM Podcast.Users u
WHERE u.UsersID = 10;