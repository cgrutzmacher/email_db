DROP DATABASE IF EXISTS email;
CREATE DATABASE email;
USE email;


CREATE TABLE user (
	ID					INT				PRIMARY KEY		AUTO_INCREMENT,
    FirstName			VARCHAR(255)	NOT NULL,
	LastName			VARCHAR(255)	NOT NULL,
	EmailAddress		VARCHAR(255)	NOT NULL,
    userPassword		VARCHAR(255),
    Sha1Password		CHAR(128)			
    
);


CREATE TABLE messages (
	MessageID			INT				PRIMARY KEY		AUTO_INCREMENT,
    Subject				VARCHAR(255),
    Body				TEXT,
    Date				DATE,
    AuthorID			INT,
    RecipientID			INT
    

);