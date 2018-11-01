DROP DATABASE IF EXISTS email;
CREATE DATABASE email;
USE email;

/*
TODO:
ADD two tables to random_names_db ("subject" and "body") and fill it with dummy information 
[rename random_names_db.sql and rename db to something that makes more sense]
ADD convenience function to generate sent and recieved emails from different users.
*/


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





DELIMITER //

CREATE FUNCTION get_random_date
(start_year INT)
RETURNS DATE
NOT DETERMINISTIC
BEGIN
	DECLARE rand_date DATE;
    SET rand_date = (SELECT CURDATE() - INTERVAL RAND()*start_year YEAR - INTERVAL RAND()*365 DAY);
    RETURN rand_date;
    
END; //

DELIMITER ;

DELIMITER //

CREATE FUNCTION get_first_name
(first_name VARCHAR(25))
RETURNS VARCHAR(25)
NOT DETERMINISTIC
BEGIN
		SET @max_users = (SELECT COUNT(*) FROM names.firstName);
        SET first_name =  (SELECT name FROM names.firstname ORDER BY RAND() LIMIT 1);
		
        RETURN first_name;
        
END; //

DELIMITER ;

DELIMITER //

CREATE FUNCTION get_last_name
(last_name VARCHAR(25))
RETURNS VARCHAR(25)
NOT DETERMINISTIC
BEGIN
		SET @max_users = (SELECT COUNT(*) FROM names.firstName);
        SET last_name =  (SELECT name FROM names.lastname ORDER BY RAND() LIMIT 1);
        
        RETURN last_name;

END; //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE generate_random_accounts
(IN num_of_accounts INT)
BEGIN
	SET @i = 0;
    
    WHILE @i <= num_of_accounts DO
		SET @first_name = get_first_name('');
        SET @last_name = get_last_name('');
    
		INSERT INTO user VALUES
			(NULL, @first_name, @last_name, CONCAT(@first_name, '.', @last_name, '@cmail.com'), NULL, NULL);
            
		SET @i = @i+1;
    
    END WHILE;


END; //

DELIMITER ;


CALL generate_random_accounts(25);
