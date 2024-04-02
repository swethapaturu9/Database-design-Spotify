
USE master;
GO
CREATE DATABASE Project4;
GO
 

GO
CREATE SCHEMA Podcast; 
GO

------ Creation of all tables 


CREATE TABLE Podcast.Collection (
  CollectionID INT NOT NULL,
  CollectionName VARCHAR(45) NOT NULL,
  ReleaseDate DATE NOT NULL,
  PRIMARY KEY (CollectionID),
  CHECK (ReleaseDate <= GETDATE()) 
);

CREATE TABLE Podcast.Users (
  UsersID INT NOT NULL,
  FirstName VARCHAR(45) NOT NULL,
  LastName VARCHAR(45) NOT NULL,
  Email VARCHAR(45) NOT NULL,
  Username VARCHAR(45) NOT NULL,
  Password VARCHAR(45) NOT NULL,
  Usertype VARCHAR(45) NOT NULL,
  PRIMARY KEY (UsersID),
  CHECK (Email LIKE '%@%.com')
);


CREATE TABLE Podcast.Playlist (
  PlaylistID INT NOT NULL,
  Playlist_Name VARCHAR(45) NOT NULL,
  No_Of_Podcasts INT NOT NULL,
  Users_UsersID INT NOT NULL,
  PRIMARY KEY (PlaylistID),
  FOREIGN KEY (Users_UsersID) REFERENCES Podcast.Users (UsersID)
);

CREATE TABLE Podcast.Genre (
GenreID INT NOT NULL,
GenreName VARCHAR(45) NOT NULL,
PRIMARY KEY (GenreID)
);

CREATE TABLE Podcast.Speakers (
SpeakerID INT NOT NULL,
Speaker_Name VARCHAR(45) NOT NULL,
PRIMARY KEY (SpeakerID)
);

CREATE TABLE Podcast.Rating (
Rating_ID INT NOT NULL,
User_Rating VARCHAR(45) NOT NULL,
CHECK (User_Rating BETWEEN '0' AND '5'),
PRIMARY KEY (Rating_ID));

CREATE TABLE Podcast.Podcasts (
  PodcastID INT NOT NULL,
  PodcastName VARCHAR(45) NOT NULL,
  PodcastSpeakerName VARCHAR(45) NOT NULL,
  PodcastRatingID INT NOT NULL,
  PodcastLength TIME NOT NULL,
  Genre VARCHAR(45) NOT NULL,
  Language VARCHAR(45) NOT NULL,
  PRIMARY KEY (PodcastID),
    FOREIGN KEY (PodcastRatingID)
    REFERENCES Podcast.Rating (Rating_ID)
);

CREATE TABLE Podcast.Downloads (
  DownloadsID INT NOT NULL,
  Users_UsersID INT NOT NULL,
 Podcasts_PodcastID INT NOT NULL,
  PRIMARY KEY (DownloadsID, Users_UsersID, Podcasts_PodcastID),
  
    FOREIGN KEY (Users_UsersID) REFERENCES Podcast.Users (UsersID),
    FOREIGN KEY (Podcasts_PodcastID) REFERENCES Podcast.Podcasts (PodcastID)
 
);

CREATE TABLE Podcast.Podcasts_Collection (
  PodcastID INT NOT NULL,
  CollectionID INT NOT NULL,
  PRIMARY KEY (PodcastID, CollectionID),
    FOREIGN KEY (PodcastID)
    REFERENCES Podcast.Podcasts (PodcastID),
    FOREIGN KEY (CollectionID)
    REFERENCES Podcast.Collection (CollectionID)
);

CREATE TABLE Podcast.Podcasts_Playlist (
  Podcast_ID INT NOT NULL,
  Playlist_ID INT NOT NULL,
  
    FOREIGN KEY (Podcast_ID)
    REFERENCES Podcast.Podcasts (PodcastID),

    FOREIGN KEY (Playlist_ID)
    REFERENCES Podcast.Playlist (PlaylistID)
   );

CREATE TABLE  Podcast.Favorite (
  FavouriteID INT NOT NULL,
  PodcastID INT NOT NULL,
  UsersID INT NOT NULL,
  PRIMARY KEY (FavouriteID, PodcastID, UsersID),
  FOREIGN KEY (UsersID)
    REFERENCES Podcast.Users (UsersID),
  FOREIGN KEY (PodcastID)
    REFERENCES Podcast.Podcasts (PodcastID)
)

CREATE TABLE  Podcast.Subtitles (
  SubtitlesID INT NOT NULL,
  Subtitles VARCHAR NOT NULL,
  Podcasts_PodcastID INT NOT NULL,
  PRIMARY KEY (SubtitlesID, Podcasts_PodcastID),
  FOREIGN KEY (Podcasts_PodcastID)
    REFERENCES Podcast.Podcasts (PodcastID)
);

CREATE TABLE  Podcast.Collection_Genre (
  Collection_CollectionID INT NOT NULL,
  Genre_GenreID INT NOT NULL,
  PRIMARY KEY (Collection_CollectionID, Genre_GenreID),
    FOREIGN KEY (Collection_CollectionID)
    REFERENCES Podcast.Collection (CollectionID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (Genre_GenreID)
    REFERENCES Podcast.Genre (GenreID)
    )


CREATE TABLE Podcast.Speaker_Genre (
  Speaker_SpeakerID INT NOT NULL,
  Genre_GenreID INT NOT NULL,
  PRIMARY KEY (Speaker_SpeakerID, Genre_GenreID),
  FOREIGN KEY (Speaker_SpeakerID)
    REFERENCES Podcast.Speakers (SpeakerID),
  FOREIGN KEY (Genre_GenreID)
    REFERENCES Podcast.Genre (GenreID)
)

CREATE TABLE Podcast.Speaker_Collection(
  Speaker_SpeakerID INT NOT NULL,
  Collection_CollectionID INT NOT NULL,
  PRIMARY KEY (Speaker_SpeakerID, Collection_CollectionID),
  FOREIGN KEY (Speaker_SpeakerID)
    REFERENCES Podcast.Speakers (SpeakerID),
  FOREIGN KEY (Collection_CollectionID)
    REFERENCES Podcast.Collection (CollectionID)
)


SELECT * FROM information_schema.tables WHERE table_schema = 'Podcast';

