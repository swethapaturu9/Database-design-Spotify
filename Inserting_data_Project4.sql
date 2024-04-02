/*users password column encryption*/

CREATE MASTER KEY ENCRYPTION BY 
PASSWORD = 'Project@789';

-- Create certificate to protect symmetric key
CREATE CERTIFICATE Project4_Certificate
WITH SUBJECT = 'Project4 Test Certificate',
EXPIRY_DATE = '2023-12-31';

-- Create symmetric key to encrypt data
CREATE SYMMETRIC KEY Project_SymmetricKey
WITH ALGORITHM = AES_256
ENCRYPTION BY CERTIFICATE Project4_Certificate;

-- Open symmetric key
OPEN SYMMETRIC KEY Project_SymmetricKey
DECRYPTION BY CERTIFICATE Project4_Certificate;


ALTER TABLE Podcast.Users 
ALTER COLUMN Password varchar(max);

-- Insert dummy data into Podcast.Users table
INSERT INTO Podcast.Users (UsersID, FirstName, LastName, Email, Username, Password, Usertype)
VALUES (1, 'Joe', 'Brown', 'joebrown@gmail.com', 'joebrown',EncryptByKey(Key_GUID(N'Project_SymmetricKey'), convert(varbinary, 'VVVVVV222')), 'normal'),
       (2, 'Jane', 'Smith', 'janesmith@gmail.com', 'janesmith', EncryptByKey(Key_GUID(N'Project_SymmetricKey'), convert(varbinary, 'PPP777')), 'normal'),
       (3, 'Mike', 'Spectre', 'mikespectre@gmail.com', 'mikespectre', EncryptByKey(Key_GUID(N'Project_SymmetricKey'), convert(varbinary, 'abc777')), 'normal'),
       (4, 'Sarah', 'Williams', 'sarahwilliams@gmail.com', 'sarahwilliams', EncryptByKey(Key_GUID(N'Project_SymmetricKey'), convert(varbinary, 'ahsd88')), 'normal'),
       (5, 'David', 'Lee', 'davidlee@gmail.com', 'davidlee', EncryptByKey(Key_GUID(N'Project_SymmetricKey'), convert(varbinary, 'mypasss')), 'premium'),
       (6, 'Emily', 'Wilson', 'emilywilson@gmail.com', 'emilywilson', EncryptByKey(Key_GUID(N'Project_SymmetricKey'), convert(varbinary, 'mypass!2')), 'premium'),
       (7, 'Vidit', 'Jain', 'viditjain@gmail.com', 'viditjain', EncryptByKey(Key_GUID(N'Project_SymmetricKey'), convert(varbinary, 'myp!2')), 'premium'),
       (8, 'Shravya', 'Gunda', 'shravyagunda@gmail.com', 'shravyagunda', EncryptByKey(Key_GUID(N'Project_SymmetricKey'), convert(varbinary, 'hello1')), 'normal'),
       (9, 'Pramod', 'BN', 'pramodbn@gmail.com', 'pramodbn', EncryptByKey(Key_GUID(N'Project_SymmetricKey'), convert(varbinary, 'hellosadd')), 'premium'),
       (10, 'Kruthika', 'Kolume', 'kruthikak@gmail.com', 'kruthikak', EncryptByKey(Key_GUID(N'Project_SymmetricKey'), convert(varbinary, 'lmnop')), 'normal'),
       (11, 'Swetha', 'Paturu', 'swethap@gmail.com', 'swethap', EncryptByKey(Key_GUID(N'Project_SymmetricKey'), convert(varbinary, 'lsdsfc123')), 'premium');



SELECT DecryptByKey(Password) 
FROM Podcast.Users;

SELECT CONVERT(VARCHAR, DecryptByKey(Password)) 
FROM Podcast.Users;


-- Insert dummy data into Podcast.Genre table
INSERT INTO Podcast.Genre (GenreID, GenreName)
VALUES
  (111, 'Comedy'),
  (112, 'Business'),
  (113, 'Science'),
  (114, 'True Crime'),
  (115, 'News'),
  (116, 'Education'),
  (117, 'Politics'),
  (118, 'Music'),
  (119, 'Sports'),
  (120, 'History'),
  (121, 'Design');

-- Insert dummy data into Podcast.Playlist table
INSERT INTO Podcast.Playlist (PlaylistID, Playlist_Name, No_Of_Podcasts, Users_UsersID)
VALUES (101, 'Happy Time', 3, 2),
       (102, 'Current Events', 2, 1),
       (103, 'All time favourites', 4, 3),
       (104, 'Workout', 1, 4),
       (105, 'La La', 2, 5),
       (106, 'Home', 1, 9),
       (107, 'Tech', 2, 7),
       (108, 'Laugh club', 2, 8),
       (109, 'My game', 2, 6),
       (110, 'Info', 2, 5);

-- Insert dummy data into Podcast.Collection table
INSERT INTO Podcast.Collection (CollectionID, CollectionName, ReleaseDate)
VALUES
  (1001, 'ESPN', '2022-01-01'),
  (1002, 'Mystery Game', '2022-02-05'),
  (1003, 'Who is that', '2022-03-10'),
  (1004, 'Lab Life', '2022-04-15'),
  (1005, 'Everyday', '2022-05-20'),
  (1006, 'Laughter is medicine', '2022-06-25'),
  (1007, 'TED Talk', '2022-07-30'),
  (1008, 'Musical Nights', '2022-08-01'),
  (1009, 'Stuff You Should Know', '2022-09-03'),
  (1010, 'Planet Money', '2022-10-08');

  -- Insert dummy data into Podcast.Rating table
INSERT INTO Podcast.Rating (Rating_ID, User_Rating)
VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5);

-- Insert dummy data into Podcast.Podcasts table
INSERT INTO Podcast.Podcasts (PodcastID, PodcastName, PodcastSpeakerName, PodcastRatingID, PodcastLength, Genre, Language)
VALUES (1, 'SmartLess', 'Jason Bateman', 1, '00:30:00', 'Comedy', 'English'),
       (2, 'Fake the Nation', 'Jason Bateman', 2, '01:15:00', 'Comedy', 'English'),
       (3, 'Song Exploder', 'Hrishikesh Hirway', 3, '00:45:00', 'Music', 'Hindi'),
       (4, 'The Lowe Post', 'Zach Lowe', 4, '00:20:00', 'Sports', 'English'),
       (5, 'Trending in Education', 'Elliot Felix', 5, '00:55:00', 'Education', 'English'),
       (6, 'Sticky Notes', 'Hrishikesh Hirway', 1, '00:40:00', 'Music', 'English'),
       (7, 'The Newsworthy', 'Erica Mandy', 2, '01:10:00', 'News', 'English'),
       (8, 'SBS News', 'Erica Mandy', 3, '00:50:00', 'News', 'English'),
       (9, 'The Right Time', 'Zach Lowe', 4, '00:25:00', 'Sports', 'English'),
       (10, 'The Knowledge Project', 'Elliot Felix', 5, '01:00:00', 'Education', 'English'),  
       (11, 'The Tim Ferriss Show', 'Tim Ferriss', 2, '00:40:00', 'Business', 'English'),
       (12, 'Prime Time', 'David Pakman', 2, '00:48:00', 'Politics', 'English'),
       (13, 'The David Pakman Show', 'David Pakman', 1, '00:20:00', 'Politics', 'English'),
       (14, 'My Favorite Murder', 'Karen Kilgariff', 4, '00:36:00', 'True Crime', 'English'),
       (15, 'The Jason Bateman Experience', 'Jason Bateman', 4, '00:26:00', 'Comedy', 'English'),
         (16, 'Serial', 'Karen Kilgariff', 5, '01:10:00', 'True Crime', 'English'),
       (17, 'Radiolab', 'Jad Abumrad', 4, '00:43:00', 'Science', 'Arabic'),
       (18, 'My Favorite Murder', 'Karen Kilgariff', 3, '00:55:00', 'True Crime', 'English'),
       (19, '99% Invisible', 'Elliot Felix', 4, '00:30:00', 'Design', 'English'),
       (20, 'The Daily', 'Erica Mandy', 5, '00:26:00', 'News', 'English'),
         (21, 'How I Built This', 'Tim Ferriss', 4, '00:50:00', 'Business', 'English'),
       (22, 'Revisionist History', 'Elliot Felix', 4, '00:45:00', 'History', 'English'),
       (23, 'TED Radio Hour', 'Guy Raz', 4, '01:0:00', 'Education', 'English'),
       (24, 'S-Town', 'Karen Kilgariff', 4, '01:40:00', 'True Crime', 'Spanish');


-- Insert dummy data into Podcast.Podcasts_Collection table
INSERT INTO Podcast.Podcasts_Collection (PodcastID, CollectionID)
VALUES (1, 1006),
       (2, 1006),
       (3, 1008),
       (4, 1001),
       (5, 1009),
       (6, 1008),
       (7, 1005),
       (8, 1005),
       (9, 1001),
       (10, 1009),  
       (11, 1010),
       (12, 1003),
       (13, 1003),
       (14, 1002),
       (15, 1006),
       (16, 1002),
       (17, 1004),
       (18, 1002),
       (19, 1009),
       (20, 1005),
       (21, 1010),
       (22, 1009),
       (23, 1007),
       (24, 1002);


-- Insert dummy data into Podcast.Collection_Genre table
INSERT INTO Podcast.Collection_Genre (Collection_CollectionID, Genre_GenreID)
VALUES  
  (1001, 119),
  (1002, 114),
  (1003, 117),
  (1004, 113),
  (1005, 115),
  (1006, 111),
  (1007, 116),
  (1008, 118),
  (1009, 116),
  (1009, 120),
  (1009, 121),
  (1010, 112);


-- Insert dummy data into Podcast.Podcasts_Playlist table
INSERT INTO Podcast.Podcasts_Playlist (Podcast_ID, Playlist_ID)
VALUES (1, 101),
       (1, 108),
       (2, 101),
       (2, 108),
       (3, 105),
       (4, 109),
       (5, 110),
       (6, 105),
       (7, 102),
       (8, 103),
       (9, 109),
       (10, 107),  
       (12, 103),
       (14, 103),
       (15, 101),
       (18, 103),
       (19, 106),
       (20, 102),
       (21, 107),
       (23, 104),
       (23, 110);

-- Insert dummy data into Podcast.Speakers table
INSERT INTO Podcast.Speakers (SpeakerID, Speaker_Name)
VALUES
    (1, 'Jason Bateman'),
    (2, 'Hrishikesh Hirway'),
    (3, 'Zach Lowe'),
    (4, 'Elliot Felix'),
    (5, 'Erica Mandy'),
    (6, 'Tim Ferriss'),
    (7, 'David Pakman'),
    (8, 'Karen Kilgariff'),
    (9, 'Jad Abumrad'),
    (10, 'Guy Raz');


-- Insert dummy data into Podcast.Speaker_Collection table
INSERT INTO Podcast.Speaker_Collection (Speaker_SpeakerID, Collection_CollectionID)
VALUES
    (1, 1006),
    (2, 1008),
    (3, 1001),
    (4, 1009),
    (5, 1005),
    (6, 1010),
    (7, 1003),
    (8, 1002),
    (9, 1004),
    (10, 1007);


-- Insert dummy data into Podcast.Speaker_Genre table
INSERT INTO Podcast.Speaker_Genre (Speaker_SpeakerID, Genre_GenreID)
VALUES
    (1, 111),
    (2, 118),
    (3, 119),
    (4, 120),
    (5, 115),
    (6, 112),
    (7, 117),
    (8, 114),
    (9, 113),
    (10, 116);


-- Insert dummy data into Podcast.Subtitles table
INSERT INTO Podcast.Subtitles (SubtitlesID, Subtitles, Podcasts_PodcastID)
VALUES
  (501, 'Subtitles for SmartLess', 1),
  (502, 'Subtitles for Fake the Nation', 2),
  (503, 'Subtitles for Song Exploder', 3),
  (504, 'Subtitles for The Lowe Post', 4),
  (505, 'Subtitles for Trending in Education', 5),
  (506, 'Subtitles for Sticky Notes', 6),
  (507, 'Subtitles for The Newsworthy', 7),
  (508, 'Subtitles for SBS News', 8),
  (509, 'Subtitles for The Right Time', 9),
  (510, 'Subtitles for The Knowledge Project', 10),
  (511, 'Subtitles for The Tim Ferriss Show', 11),
  (512, 'Subtitles for Prime Time', 12),
  (513, 'Subtitles for The David Pakman Show', 13),
  (514, 'Subtitles for My Favorite Murder', 14),
  (515, 'Subtitles for The Jason Bateman Experience', 15),
  (516, 'Subtitles for Serial', 16),
  (517, 'Subtitles for Radiolab', 17),
  (518, 'Subtitles for My Favorite Murder', 18),
  (519, 'Subtitles for 99% Invisible', 19),
  (520, 'Subtitles for The Daily', 20),
  (521, 'Subtitles for How I Built This', 21),
  (522, 'Subtitles for Revisionist History', 22),
  (523, 'Subtitles for TED Radio Hour', 23),
  (524, 'Subtitles for S-Town', 24);


-- Insert dummy data into Podcast.Downloads table
INSERT INTO Podcast.Downloads (DownloadsID, Users_UsersID, Podcasts_PodcastID)
VALUES
    (201, 10, 22),
    (202, 10, 12),
    (203, 7, 4),
    (204, 10, 24),
    (205, 9, 6),
    (206, 6, 3),
    (207, 9, 15),
    (208, 10, 19),
    (209, 7, 2),
    (210, 6, 20),
    (211, 9, 8),
    (212, 9, 10);


-- Insert dummy data into Podcast.Favorite table
INSERT INTO Podcast.Favorite (FavouriteID, UsersID, PodcastID)
VALUES
    (301, 2, 20),
    (302, 3, 11),
    (303, 7, 14),
    (304, 8, 2),
    (305, 1, 16),
    (306, 6, 13),
    (307, 9, 5),
    (308, 5, 9),
    (309, 5, 21),
    (310, 6, 23),
    (311, 4, 18),
    (312, 1, 1);




