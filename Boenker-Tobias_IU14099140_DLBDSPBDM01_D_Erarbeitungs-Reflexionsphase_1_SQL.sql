START TRANSACTION;

-- Erstellung der Tabelle "Admin"
CREATE TABLE Admin 
(
AdminID 			INT NOT NULL UNIQUE PRIMARY KEY,
AdminProcessID		INT NOT NULL,
Name 				Varchar (50) NOT NULL,
Surname 			Varchar (50) NOT NULL,
Mail				Varchar (50) NOT NULL,
Phone				BIGINT,
Salutation			Varchar (15) NOT NULL,
Title				Varchar (15) NOT NULL
);

-- Erstellung der Tabelle "Process"
CREATE TABLE Process
(
ProcessID 			INT NOT NULL UNIQUE PRIMARY KEY,
ProcessDate 		TIMESTAMP NOT NULL,
Borrower 			INT NOT NULL,
Lender				INT NOT NULL,
ProcessBookID 		INT,
Location 			INT,
TimeOfLoan 			DATETIME,
TimeOfReturn 		DATETIME,
Status 				VARCHAR (50),
ShippingID 			INT
);

-- Erstellung der Tabelle "Shipping"
CREATE TABLE Shipping 
(
ShippingID 			INT NOT NULL PRIMARY KEY,
ShipProcessID		INT NOT NULL,
Shippingcosts		INT,
ShipmentNumber		INT,
ParcelService		varchar(50)
);

-- Erstellung der Tabelle "Borrower"
CREATE TABLE Borrower 
(
BorrowerUserID	 	INT NOT NULL PRIMARY KEY,
BorrowerProcessID	INT NOT NULL,
BorrowerID			INT
);

-- Erstellung der Tabelle "Lender"
CREATE TABLE Lender 
(
LenderUserID	 	INT NOT NULL PRIMARY KEY,
LenderProcessID		INT NOT NULL,
LenderID			INT
);

-- Erstellung der Tabelle "User"
CREATE TABLE User 
(
UserID 				INT NOT NULL UNIQUE PRIMARY KEY,
Name 				Varchar (50) NOT NULL,
Surname 			Varchar (50) NOT NULL,
Mail				Varchar (50) NOT NULL,
Phone				BIGINT,
Salutation			Varchar (15) NOT NULL,
Title				Varchar (15)
);

-- Erstellung der Tabelle "Address"
CREATE TABLE Address 
(
AddressID 			INT NOT NULL PRIMARY KEY,
Line1				VARCHAR(100),
Line2				VARCHAR(100),
Number				INT,
Postcode			INT,
City				VARCHAR(50),
Country				VARCHAR(50)
);

-- Erstellung der Tabelle "UserAddress"
CREATE TABLE UserAddress 
(
UserAddressID	 	INT NOT NULL PRIMARY KEY,
AddressID			INT NOT NULL,
AddressUserID		INT NOT NULL
);

-- Erstellung der Tabelle "AdminMessages"
CREATE TABLE AdminMessages 
(
MessageID 			INT NOT NULL PRIMARY KEY,
MessageUserID		INT NOT NULL,
Message				VARCHAR(300),
MessageCategory		VARCHAR(50)
);

-- Erstellung der Tabelle "Category"
CREATE TABLE Category
(
CategoryID 			INT NOT NULL PRIMARY KEY,
CategoryName		VARCHAR(50),
CategoryDescription	VARCHAR(50)
);

-- Erstellung der Tabelle "Books"
CREATE TABLE Books
(
BookID				INT Unique NOT NULL PRIMARY KEY,
BookUserID			INT NOT NULL,
ISBN				BIGINT NOT NULL,
BookTitle			VARCHAR(50),
Author				VARCHAR(50),
Publisher			VARCHAR(50),
GenreID				INT,
Year				Date,
LanguageID			INT,
UserID				INT,
TimeslotID			INT,
StateID				INT,
Availability		BOOLEAN
);

-- Erstellung der Tabelle "Genre"
CREATE TABLE Genre 
(
GenreID	 			INT NOT NULL PRIMARY KEY,
Genre				VARCHAR(50),
GenreDescription	VARCHAR(200)
);

-- Erstellung der Tabelle "Language"
CREATE TABLE Language 
(
LanguageID 			INT NOT NULL PRIMARY KEY,
Language			VARCHAR(50)
);

-- Erstellung der Tabelle "Timeslot"
CREATE TABLE Timeslot 
(
TimeslotID	 		INT NOT NULL PRIMARY KEY,
SlotBookID			INT,
Availability		BOOLEAN,
Period				TIME
);

-- Erstellung der Tabelle "State"
CREATE TABLE State 
(
StateID	 			INT NOT NULL PRIMARY KEY,
StateBookID			INT,
State				VARCHAR(50)
);

-- Erstellung der Tabelle "Rating"
CREATE TABLE Rating 
(
RatingID	 		INT NOT NULL PRIMARY KEY,
RatingBookID		INT,
RatingUserID		INT,
Rating				VARCHAR(300),
Stars				INT CHECK (Stars >= 0 AND Stars <= 5)
);

-- Hinzufügen von Fremdschlüsseln
ALTER TABLE Admin 
ADD CONSTRAINT AdminProcessID
FOREIGN KEY (AdminProcessID)
REFERENCES Process(ProcessID);

-- Hinzufügen von Fremdschlüsseln
ALTER TABLE Process 
ADD CONSTRAINT Borrower
FOREIGN KEY (Borrower)
REFERENCES Borrower(BorrowerUserID),
ADD CONSTRAINT Lender
FOREIGN KEY (Lender)
REFERENCES Lender(LenderUserID),
ADD CONSTRAINT ProcessBookID
FOREIGN KEY (ProcessBookID)
REFERENCES Books(BookID),
ADD CONSTRAINT Location
FOREIGN KEY (Location)
REFERENCES Address(AddressID),
ADD CONSTRAINT ShippingID
FOREIGN KEY (ShippingID)
REFERENCES Shipping(ShippingID);

-- Hinzufügen von Fremdschlüsseln
ALTER TABLE Shipping 
ADD CONSTRAINT ShipProcessID
FOREIGN KEY (ShipProcessID)
REFERENCES Process(ProcessID);

-- Hinzufügen von Fremdschlüsseln
ALTER TABLE Borrower 
ADD CONSTRAINT BorrowerProcessID
FOREIGN KEY (BorrowerProcessID)
REFERENCES Process(ProcessID),
ADD CONSTRAINT BorrowerID
FOREIGN KEY (BorrowerID)
REFERENCES Process(Borrower);

-- Hinzufügen von Fremdschlüsseln
ALTER TABLE Lender 
ADD CONSTRAINT LenderProcessID
FOREIGN KEY (LenderProcessID)
REFERENCES Process(ProcessID),
ADD CONSTRAINT LenderID
FOREIGN KEY (LenderID)
REFERENCES Process(Lender);

-- Hinzufügen von Fremdschlüsseln
ALTER TABLE UserAddress 
ADD CONSTRAINT AddressID
FOREIGN KEY (AddressID)
REFERENCES Address(AddressID),
ADD CONSTRAINT AddressUserID
FOREIGN KEY (AddressUserID)
REFERENCES User(UserID);

-- Hinzufügen von Fremdschlüsseln
ALTER TABLE AdminMessages 
ADD CONSTRAINT MessageUserID
FOREIGN KEY (MessageUserID)
REFERENCES User(UserID);

-- Hinzufügen von Fremdschlüsseln
ALTER TABLE Books 
ADD CONSTRAINT GenreID
FOREIGN KEY (GenreID)
REFERENCES Genre(GenreID),
ADD CONSTRAINT LanguageID
FOREIGN KEY (LanguageID)
REFERENCES Language(LanguageID),
ADD CONSTRAINT UserID
FOREIGN KEY (UserID)
REFERENCES User(UserID),
ADD CONSTRAINT TimeslotID
FOREIGN KEY (TimeslotID)
REFERENCES Timeslot(TimeslotID),
ADD CONSTRAINT StateID
FOREIGN KEY (StateID)
REFERENCES State(StateID),
ADD CONSTRAINT BookUserID
FOREIGN KEY (BookUserID)
REFERENCES User(UserID);

-- Hinzufügen von Fremdschlüsseln
ALTER TABLE Timeslot 
ADD CONSTRAINT SlotBookID
FOREIGN KEY (SlotBookID)
REFERENCES Books(BookID);

-- Hinzufügen von Fremdschlüsseln
ALTER TABLE State 
ADD CONSTRAINT StateBookID
FOREIGN KEY (StateBookID)
REFERENCES Books(BookID);

-- Hinzufügen von Fremdschlüsseln
ALTER TABLE Rating 
ADD CONSTRAINT RatingBookID
FOREIGN KEY (RatingBookID)
REFERENCES Books(BookID),
ADD CONSTRAINT RatingUserID
FOREIGN KEY (RatingUserID)
REFERENCES User(UserID);

-- Start Hinzufügen der Dummy-Daten

-- Fremdschlüsselcheck deaktivieren um die gegenseitigen Referenzen zu ermöglichen
SET FOREIGN_KEY_CHECKS = 0;

-- Dummy-Daten für Tabelle "Admin"
INSERT INTO Admin (AdminID, AdminProcessID, Name, Surname, Mail, Phone, Salutation, Title)
VALUES
    (1, 101, 'John', 'Doe', 'john.doe@example.com', 1234567890, 'Mr.', 'Dr'),
    (2, 102, 'Jane', 'Smith', 'jane.smith@example.com', 9876543210, 'Ms.', 'Prof Dr'),
    (3, 103, 'Michael', 'Johnson', 'michael.johnson@example.com', 5551234567, 'Mr.', ''),
    (4, 104, 'Emily', 'Brown', 'emily.brown@example.com', 1234567890, 'Ms.', ''),
    (5, 105, 'Daniel', 'Martinez', 'daniel.martinez@example.com', 9876543210, 'Mr.', ''),
    (6, 106, 'Sophia', 'Lee', 'sophia.lee@example.com', 5551234567, 'Ms.', 'Dr'),
    (7, 107, 'Ethan', 'Garcia', 'ethan.garcia@example.com', 1234567890, 'Mr.', 'Prof'),
    (8, 108, 'Isabella', 'Lopez', 'isabella.lopez@example.com', 9876543210, 'Ms.', ''),
    (9, 109, 'Alexander', 'Gonzalez', 'alexander.gonzalez@example.com', 5551234567, 'Mr.', ''),
    (10, 110, 'Mia', 'Harris', 'mia.harris@example.com', 1234567890, 'Ms.', 'Dr'),
    (11, 111, 'William', 'Clark', 'william.clark@example.com', 9876543210, 'Mr.', 'Dr'),
    (12, 112, 'Ava', 'Young', 'ava.young@example.com', 5551234567, 'Ms.', ''),
    (13, 113, 'James', 'Lewis', 'james.lewis@example.com', 1234567890, 'Mr.', ''),
    (14, 114, 'Charlotte', 'Martin', 'charlotte.martin@example.com', 9876543210, 'Ms.', ''),
    (15, 115, 'Benjamin', 'Walker', 'benjamin.walker@example.com', 5551234567, 'Mr.', 'Dr');

-- Dummy-Daten für Tabelle "Process"
INSERT INTO Process (ProcessID, ProcessDate, Borrower, Lender, ProcessBookID, Location, TimeOfLoan, TimeOfReturn, Status, ShippingID)
VALUES
	(101, '2024-01-01', 1, 2, 201, 1, '2024-01-01 10:00:00', '2024-01-05 15:00:00', 'Completed', 301),
    (102, '2024-01-02', 3, 1, 202, 2, '2024-01-02 11:00:00', '2024-01-06 16:00:00', 'In Progress', 302),
    (103, '2024-01-03', 2, 3, 203, 3, '2024-01-03 12:00:00', '2024-01-07 17:00:00', 'Pending', 303),
    (104, '2024-01-04', 4, 5, 204, 4, '2024-01-04 13:00:00', '2024-01-08 18:00:00', 'Completed', 304),
    (105, '2024-01-05', 6, 7, 205, 5, '2024-01-05 14:00:00', '2024-01-09 19:00:00', 'In Progress', 305),
    (106, '2024-01-06', 8, 9, 206, 6, '2024-01-06 15:00:00', '2024-01-10 20:00:00', 'Pending', 306),
    (107, '2024-01-07', 10, 11, 207, 7, '2024-01-07 16:00:00', '2024-01-11 21:00:00', 'Completed', 307),
    (108, '2024-01-08', 12, 13, 208, 8, '2024-01-08 17:00:00', '2024-01-12 22:00:00', 'In Progress', 308),
    (109, '2024-01-09', 14, 15, 209, 9, '2024-01-09 18:00:00', '2024-01-13 23:00:00', 'Pending', 309),
    (110, '2024-01-10', 16, 17, 210, 10, '2024-01-10 19:00:00', '2024-01-14 08:00:00', 'Completed', 310),
    (111, '2024-01-11', 18, 19, 211, 11, '2024-01-11 20:00:00', '2024-01-15 09:00:00', 'In Progress', 311),
    (112, '2024-01-12', 20, 21, 212, 12, '2024-01-12 21:00:00', '2024-01-16 10:00:00', 'Pending', 312),
    (113, '2024-01-13', 22, 23, 213, 13, '2024-01-13 22:00:00', '2024-01-17 11:00:00', 'Completed', 313),
    (114, '2024-01-14', 24, 25, 214, 14, '2024-01-14 23:00:00', '2024-01-18 12:00:00', 'In Progress', 314),
    (115, '2024-01-15', 26, 27, 215, 15, '2024-01-15 08:00:00', '2024-01-19 13:00:00', 'Pending', 315);

-- Dummy-Daten für Tabelle "Shipping"
INSERT INTO Shipping (ShippingID, ShipProcessID, Shippingcosts, ShipmentNumber, ParcelService)
VALUES
    (301, 101, 10, 123456, 'UPS'),
    (302, 102, 8, 987654, 'FedEx'),
    (303, 103, 12, 456789, 'DHL'),
    (304, 104, 15, 987654, 'DHL'),
    (305, 105, 20, 654321, 'UPS'),
    (306, 106, 25, 456789, 'FedEx'),
    (307, 107, 30, 123456, 'DHL'),
    (308, 108, 35, 135792, 'UPS'),
    (309, 109, 40, 246810, 'FedEx'),
    (310, 110, 45, 369258, 'DHL'),
    (311, 111, 50, 987123, 'UPS'),
    (312, 112, 55, 147258, 'FedEx'),
    (313, 113, 60, 369147, 'DHL'),
    (314, 114, 65, 258369, 'UPS'),
    (315, 115, 70, 123789, 'FedEx');

-- Dummy-Daten für Tabelle "Borrower"
INSERT INTO Borrower (BorrowerUserID, BorrowerProcessID, BorrowerID)
VALUES
    (1, 101, 1001),
    (2, 102, 1002),
    (3, 103, 1003),
	(4, 104, 1004),
    (5, 105, 1005),
    (6, 106, 1006),
    (7, 107, 1007),
    (8, 108, 1008),
    (9, 109, 1009),
    (10, 110, 1010),
    (11, 111, 1011),
    (12, 112, 1012),
    (13, 113, 1013),
    (14, 114, 1014),
    (15, 115, 1015);

-- Dummy-Daten für Tabelle "Lender"
INSERT INTO Lender (LenderUserID, LenderProcessID, LenderID)
VALUES
    (1, 101, 2001),
    (2, 102, 2002),
    (3, 103, 2003),
    (16, 114, 2004),
    (17, 115, 2005),
    (18, 116, 2006),
    (19, 117, 2007),
    (20, 118, 2008),
    (21, 119, 2009),
    (22, 120, 2010),
    (23, 121, 2011),
    (24, 122, 2012),
    (25, 123, 2013),
    (26, 124, 2014),
    (27, 125, 2015);

-- Dummy-Daten für Tabelle "User"
INSERT INTO User (UserID, Name, Surname, Mail, Phone, Salutation, Title)
VALUES
    (1001, 'Alice', 'Johnson', 'alice.johnson@example.com', 5559876543, 'Ms.', 'Dr'),
    (1002, 'Bob', 'Williams', 'bob.williams@example.com', 8885551234, 'Mr.', ''),
    (1003, 'Carol', 'Brown', 'carol.brown@example.com', 3334445678, 'Ms.', ''),
	(1004, 'Olivia', 'Taylor', 'olivia.taylor@example.com', 5559876543, 'Ms.', ''),
    (1005, 'Noah', 'Moore', 'noah.moore@example.com', 8885551234, 'Mr.', 'Prof Dr'),
    (1006, 'Emma', 'Miller', 'emma.miller@example.com', 3334445678, 'Ms.', ''),
    (1007, 'Liam', 'Jackson', 'liam.jackson@example.com', 5559876543, 'Mr.', ''),
    (1008, 'Avery', 'White', 'avery.white@example.com', 8885551234, 'Ms.', 'Dr'),
    (1009, 'Lucas', 'Hill', 'lucas.hill@example.com', 3334445678, 'Mr.', ''),
    (1010, 'Evelyn', 'Moore', 'evelyn.moore@example.com', 5559876543, 'Ms.', ''),
    (1011, 'Mason', 'Allen', 'mason.allen@example.com', 8885551234, 'Mr.', ''),
    (1012, 'Harper', 'Carter', 'harper.carter@example.com', 3334445678, 'Ms.', ''),
    (1013, 'Elijah', 'Wood', 'elijah.wood@example.com', 5559876543, 'Mr.', 'Dr'),
    (1014, 'Amelia', 'Hall', 'amelia.hall@example.com', 8885551234, 'Ms.', ''),
    (1015, 'Oliver', 'Adams', 'oliver.adams@example.com', 3334445678, 'Mr.', '');

-- Dummy-Daten für Tabelle "Address"
INSERT INTO Address (AddressID, Line1, Line2, Number, Postcode, City, Country)
VALUES
    (1, '123 Main St', NULL, 1, 12345, 'City1', 'Country1'),
    (2, '456 Elm St', NULL, 2, 23456, 'City2', 'Country2'),
    (3, '789 Oak St', NULL, 3, 34567, 'City3', 'Country3'),
    (4, '321 Pine St', NULL, 4, 45678, 'City4', 'Country4'),
    (5, '654 Cedar St', NULL, 5, 56789, 'City5', 'Country5'),
    (6, '987 Maple St', NULL, 6, 67890, 'City6', 'Country6'),
    (7, '135 Elm St', NULL, 7, 78901, 'City7', 'Country7'),
    (8, '246 Oak St', NULL, 8, 89012, 'City8', 'Country8'),
    (9, '369 Walnut St', NULL, 9, 90123, 'City9', 'Country9'),
    (10, '147 Birch St', NULL, 10, 01234, 'City10', 'Country10'),
    (11, '258 Ash St', NULL, 11, 12345, 'City11', 'Country11'),
    (12, '369 Pine St', NULL, 12, 23456, 'City12', 'Country12'),
    (13, '456 Cedar St', NULL, 13, 34567, 'City13', 'Country13'),
    (14, '789 Maple St', NULL, 14, 45678, 'City14', 'Country14'),
    (15, '321 Elm St', NULL, 15, 56789, 'City15', 'Country15');

-- Dummy-Daten für Tabelle "UserAddressID"
INSERT INTO UserAddress (UserAddressID, AddressID, AddressUserID)
VALUES
    (1, 1, 1001),
    (2, 2, 1002),
    (3, 3, 1003),
    (4, 4, 1004),
    (5, 5, 1005),
    (6, 6, 1006),
    (7, 7, 1007),
    (8, 8, 1008),
    (9, 9, 1009),
    (10, 10, 1010),
    (11, 11, 1011),
    (12, 12, 1012),
    (13, 13, 1013),
    (14, 14, 1014),
    (15, 15, 1015);

-- Dummy-Daten für Tabelle "AdminMessages"
INSERT INTO AdminMessages (MessageID, MessageUserID, Message, MessageCategory)
VALUES
    (1, 1, 'Message 1', 'Category1'),
    (2, 2, 'Message 2', 'Category2'),
    (3, 3, 'Message 3', 'Category3'),
    (4, 4, 'Message 4', 'Category4'),
    (5, 5, 'Message 5', 'Category5'),
    (6, 6, 'Message 6', 'Category6'),
    (7, 7, 'Message 7', 'Category7'),
    (8, 8, 'Message 8', 'Category8'),
    (9, 9, 'Message 9', 'Category9'),
    (10, 10, 'Message 10', 'Category10'),
    (11, 11, 'Message 11', 'Category11'),
    (12, 12, 'Message 12', 'Category12'),
    (13, 13, 'Message 13', 'Category13'),
    (14, 14, 'Message 14', 'Category14'),
    (15, 15, 'Message 15', 'Category15');

-- Dummy-Daten für Tabelle "Category"
INSERT INTO Category (CategoryID, CategoryName, CategoryDescription)
VALUES
    (1, 'CategoryName1', 'Description1'),
    (2, 'CategoryName2', 'Description2'),
    (3, 'CategoryName3', 'Description3'),
	(4, 'CategoryName4', 'Description4'),
    (5, 'CategoryName5', 'Description5'),
    (6, 'CategoryName6', 'Description6'),
    (7, 'CategoryName7', 'Description7'),
    (8, 'CategoryName8', 'Description8'),
    (9, 'CategoryName9', 'Description9'),
    (10, 'CategoryName10', 'Description10'),
    (11, 'CategoryName11', 'Description11'),
    (12, 'CategoryName12', 'Description12'),
    (13, 'CategoryName13', 'Description13'),
    (14, 'CategoryName14', 'Description14'),
    (15, 'CategoryName15', 'Description15');

-- Dummy-Daten für Tabelle "Books"
INSERT INTO Books (BookID, BookUserID, ISBN, BookTitle, Author, Publisher, GenreID, Year, LanguageID, UserID, TimeslotID, StateID, Availability)
VALUES
    (201, 1001, 9780451524935, '1984', 'George Orwell', 'Houghton Mifflin Harcourt', 1, '1949-06-08', 1, 1001, 1, 1, true),
    (202, 1002, 9780679783268, 'To Kill a Mockingbird', 'Harper Lee', 'J.B. Lippincott & Co.', 2, '1960-07-11', 2, 1002, 2, 2, true),
    (203, 1003, 9780743273565, 'The Great Gatsby', 'F. Scott Fitzgerald', 'Charles Scribner''s Sons', 3, '1925-04-10', 3, 1003, 3, 3, false),
    (204, 1004, 9780316769488, 'The Catcher in the Rye', 'J.D. Salinger', 'Little, Brown and Company', 4, '1951-07-16', 4, 1004, 4, 4, true),
    (205, 1005, 9780747532743, 'Harry Potter and the Philosopher''s Stone', 'J.K. Rowling', 'Bloomsbury', 5, '1997-06-26', 5, 1005, 5, 5, false),
    (206, 1006, 9780061120084, 'To Kill a Mockingbird', 'Harper Lee', 'Harper Perennial Modern Classics', 6, '2006-05-23', 6, 1006, 6, 6, true),
    (207, 1007, 9780307277671, 'The Road', 'Cormac McCarthy', 'Alfred A. Knopf', 7, '2006-09-26', 7, 1007, 7, 7, true),
    (208, 1008, 9780439139595, 'Harry Potter and the Goblet of Fire', 'J.K. Rowling', 'Scholastic', 8, '2000-07-08', 8, 1008, 8, 8, false),
    (209, 1009, 9780316037924, 'Twilight', 'Stephenie Meyer', 'Little, Brown and Company', 9, '2005-10-05', 9, 1009, 9, 9, true),
    (210, 1010, 9780060254926, 'Where the Wild Things Are', 'Maurice Sendak', 'HarperCollins', 10, '1963-04-09', 10, 1010, 10, 10, true),
    (211, 1011, 9780140283334, 'Animal Farm', 'George Orwell', 'Penguin Books', 11, '1945-08-17', 11, 1011, 11, 11, false),
    (212, 1012, 9780439554930, 'Harry Potter and the Order of the Phoenix', 'J.K. Rowling', 'Scholastic', 12, '2003-06-21', 12, 1012, 12, 12, true),
    (213, 1013, 9780345339683, 'The Hobbit', 'J.R.R. Tolkien', 'George Allen & Unwin', 13, '1937-09-21', 13, 1013, 13, 13, false),
    (214, 1014, 9780143125427, 'Pride and Prejudice', 'Jane Austen', 'T. Egerton', 14, '1813-01-28', 14, 1014, 14, 14, true),
    (215, 1015, 9780439139601, 'Harry Potter and the Prisoner of Azkaban', 'J.K. Rowling', 'Scholastic', 15, '1999-07-08', 15, 1015, 15, 15, true);

-- Dummy-Daten für Tabelle "Genre"
INSERT INTO Genre (GenreID, Genre, GenreDescription)
VALUES
    (1, 'Fiction', 'Narrative literary works whose content is produced by the imagination and is not necessarily based on fact.'),
    (2, 'Non-Fiction', 'Prose writing that is informative or factual rather than fictional.'),
    (3, 'Science Fiction', 'Genre of speculative fiction that typically deals with imaginative and futuristic concepts.'),
    (4, 'Fantasy', 'Genre of speculative fiction set in a fictional universe, often inspired by real world myth and folklore.'),
    (5, 'Mystery', 'Genre of fiction that deals with the solution of a crime or the unraveling of secrets.'),
    (6, 'Biography', 'Detailed description of a person\'s life.'),
    (7, 'History', 'Study of past events, particularly in human affairs.'),
    (8, 'Romance', 'Genre of fiction that involves a central love story and an emotionally satisfying and optimistic ending.'),
    (9, 'Horror', 'Genre of fiction which is intended to, or has the capacity to frighten, scare, or disgust.'),
    (10, 'Self-Help', 'Genre of books written with the intention to instruct its readers on solving personal problems.'),
    (11, 'Health', 'Books related to health, wellness, and medical topics.'),
    (12, 'Travel', 'Books about travel, including travel guides, travelogues, and narratives.'),
    (13, 'Cookbooks', 'Books containing recipes and other information about the preparation and cooking of food.'),
    (14, 'Children\'s', 'Books written for children, typically featuring themes and language appropriate for young readers.'),
    (15, 'Poetry', 'Genre of literature that uses aesthetic and rhythmic qualities of language to evoke meanings.'),
    (16, 'Graphic Novels', 'Book-length works that convey a story through comic strip format.'),
    (17, 'Education', 'Books related to teaching, learning, and educational topics.'),
    (18, 'Science', 'Books that explore topics related to various scientific fields and concepts.'),
    (19, 'Philosophy', 'Books that explore fundamental questions about existence, knowledge, values, and reason.'),
    (20, 'Religion', 'Books that explore religious beliefs, practices, and history.'),
    (21, 'Art', 'Books related to visual and performing arts.'),
    (22, 'Business', 'Books that cover topics related to business, economics, and management.'),
    (23, 'Technology', 'Books that cover topics related to technological innovations and advancements.'),
    (24, 'Politics', 'Books that explore political theories, practices, and history.'),
    (25, 'Law', 'Books related to legal principles, systems, and cases.'),
    (26, 'Adventure', 'Books that involve exciting journeys and experiences.'),
    (27, 'Drama', 'Books that focus on realistic characters and emotional themes.'),
    (28, 'Humor', 'Books intended to be humorous and entertaining.'),
    (29, 'Thriller', 'Genre of fiction characterized by excitement, suspense, and high stakes.'),
    (30, 'Classics', 'Books that have stood the test of time and are considered to be of high literary quality.');

-- Dummy-Daten für Tabelle "Language"
INSERT INTO Language (LanguageID, Language)
VALUES
    (1, 'English'),
    (2, 'German'),
    (3, 'Spanish'),
    (4, 'French'),
    (5, 'Italian'),
    (6, 'Chinese'),
    (7, 'Japanese'),
    (8, 'Russian'),
    (9, 'Portuguese'),
    (10, 'Arabic'),
    (11, 'Korean'),
    (12, 'Dutch'),
    (13, 'Swedish'),
    (14, 'Danish'),
    (15, 'Finnish');

-- Dummy-Daten für Tabelle "Timeslot"
INSERT INTO Timeslot (TimeslotID, SlotBookID, Availability, Period)
VALUES
    (1, 201, TRUE, '08:00:00'),
    (2, 202, FALSE, '12:00:00'),
    (3, 203, TRUE, '16:00:00'),
    (4, 204, TRUE, '08:00:00'),
    (5, 205, FALSE, '12:00:00'),
    (6, 206, TRUE, '16:00:00'),
    (7, 207, FALSE, '08:00:00'),
    (8, 208, TRUE, '12:00:00'),
    (9, 209, FALSE, '16:00:00'),
    (10, 210, TRUE, '08:00:00'),
    (11, 211, FALSE, '12:00:00'),
    (12, 212, TRUE, '16:00:00'),
    (13, 213, FALSE, '08:00:00'),
    (14, 214, TRUE, '12:00:00'),
    (15, 215, FALSE, '16:00:00');

-- Dummy-Daten für Tabelle "State"
INSERT INTO State (StateID, StateBookID, State)
VALUES
    (1, 201, 'State1'),
    (2, 202, 'State2'),
    (3, 203, 'State3'),
	(4, 204, 'State4'),
    (5, 205, 'State5'),
    (6, 206, 'State6'),
    (7, 207, 'State7'),
    (8, 208, 'State8'),
    (9, 209, 'State9'),
    (10, 210, 'State10'),
    (11, 211, 'State11'),
    (12, 212, 'State12'),
    (13, 213, 'State13'),
    (14, 214, 'State14'),
    (15, 215, 'State15');

-- Dummy-Daten für Tabelle "Rating"
INSERT INTO Rating (RatingID, RatingBookID, RatingUserID, Rating, Stars)
VALUES
    (1, 201, 1001, 'Rating1', 4),
    (2, 202, 1002, 'Rating2', 5),
    (3, 203, 1003, 'Rating3', 3),
    (4, 204, 1004, 'Rating4', 3),
    (5, 205, 1005, 'Rating5', 4),
    (6, 206, 1006, 'Rating6', 5),
    (7, 207, 1007, 'Rating7', 4),
    (8, 208, 1008, 'Rating8', 3),
    (9, 209, 1009, 'Rating9', 5),
    (10, 210, 1010, 'Rating10', 4),
    (11, 211, 1011, 'Rating11', 3),
    (12, 212, 1012, 'Rating12', 5),
    (13, 213, 1013, 'Rating13', 4),
    (14, 214, 1014, 'Rating14', 3),
    (15, 215, 1015, 'Rating15', 5);

-- Dummy-Daten für Tabelle "Process"    
INSERT INTO Process (ProcessID, ProcessDate, Borrower, Lender, ProcessBookID, Location, TimeOfLoan, TimeOfReturn, Status, ShippingID)
VALUES
    (116, '2024-01-20', 1, 2, 201, 6, '2024-01-20 10:00:00', '2024-01-25 15:00:00', 'Completed', 301),
    (117, '2024-01-21', 3, 4, 202, 7, '2024-01-21 11:00:00', '2024-01-26 16:00:00', 'In Progress', 302),
    (118, '2024-01-22', 5, 6, 203, 8, '2024-01-22 12:00:00', '2024-01-27 17:00:00', 'Pending', 303),
    (119, '2024-01-23', 7, 8, 204, 9, '2024-01-23 13:00:00', '2024-01-28 18:00:00', 'Completed', 304),
    (120, '2024-01-24', 9, 10, 205, 10, '2024-01-24 14:00:00', '2024-01-29 19:00:00', 'In Progress', 305),
    (121, '2024-01-25', 11, 12, 206, 11, '2024-01-25 15:00:00', '2024-01-30 20:00:00', 'Pending', 306),
    (122, '2024-01-26', 13, 14, 207, 12, '2024-01-26 16:00:00', '2024-01-31 21:00:00', 'Completed', 307),
    (123, '2024-01-27', 15, 16, 208, 13, '2024-01-27 17:00:00', '2024-02-01 22:00:00', 'In Progress', 308),
    (124, '2024-01-28', 17, 18, 209, 14, '2024-01-28 18:00:00', '2024-02-02 23:00:00', 'Pending', 309),
    (125, '2024-01-29', 19, 20, 210, 15, '2024-01-29 19:00:00', '2024-02-03 08:00:00', 'Completed', 310),
    (126, '2024-01-30', 1, 2, 201, 6, '2024-01-30 10:00:00', '2024-02-04 15:00:00', 'Completed', 301),
    (127, '2024-01-31', 3, 4, 202, 7, '2024-01-31 11:00:00', '2024-02-05 16:00:00', 'In Progress', 302),
    (128, '2024-02-01', 5, 6, 203, 8, '2024-02-01 12:00:00', '2024-02-06 17:00:00', 'Pending', 303),
    (129, '2024-02-02', 7, 8, 204, 9, '2024-02-02 13:00:00', '2024-02-07 18:00:00', 'Completed', 304),
    (130, '2024-02-03', 9, 10, 205, 10, '2024-02-03 14:00:00', '2024-02-08 19:00:00', 'In Progress', 305),
    (131, '2024-02-04', 11, 12, 206, 11, '2024-02-04 15:00:00', '2024-02-09 20:00:00', 'Pending', 306),
    (132, '2024-02-05', 13, 14, 207, 12, '2024-02-05 16:00:00', '2024-02-10 21:00:00', 'Completed', 307),
    (133, '2024-02-06', 15, 16, 208, 13, '2024-02-06 17:00:00', '2024-02-11 22:00:00', 'In Progress', 308),
    (134, '2024-02-07', 17, 18, 209, 14, '2024-02-07 18:00:00', '2024-02-12 23:00:00', 'Pending', 309),
    (135, '2024-02-08', 19, 20, 210, 15, '2024-02-08 19:00:00', '2024-02-13 08:00:00', 'Completed', 310),
    (136, '2024-02-09', 2, 1, 201, 16, '2024-02-09 10:00:00', '2024-02-14 15:00:00', 'Completed', 311),
    (137, '2024-02-10', 4, 3, 202, 17, '2024-02-10 11:00:00', '2024-02-15 16:00:00', 'In Progress', 312),
    (138, '2024-02-11', 6, 5, 203, 18, '2024-02-11 12:00:00', '2024-02-16 17:00:00', 'Pending', 313),
    (139, '2024-02-12', 8, 7, 204, 19, '2024-02-12 13:00:00', '2024-02-17 18:00:00', 'Completed', 314),
    (140, '2024-02-13', 10, 9, 205, 20, '2024-02-13 14:00:00', '2024-02-18 19:00:00', 'In Progress', 315),
    (141, '2024-02-14', 12, 11, 206, 21, '2024-02-14 15:00:00', '2024-02-19 20:00:00', 'Pending', 315),
    (142, '2024-02-15', 14, 13, 207, 22, '2024-02-15 16:00:00', '2024-02-20 21:00:00', 'Completed', 315),
    (143, '2024-02-16', 16, 15, 208, 23, '2024-02-16 17:00:00', '2024-02-21 22:00:00', 'In Progress', 315),
    (144, '2024-02-17', 18, 17, 209, 24, '2024-02-17 18:00:00', '2024-02-22 23:00:00', 'Pending', 313),
    (145, '2024-02-18', 20, 19, 210, 25, '2024-02-18 19:00:00', '2024-02-23 08:00:00', 'Completed', 312),
    (146, '2024-02-19', 1, 3, 201, 26, '2024-02-19 10:00:00', '2024-02-24 15:00:00', 'Completed', 311),
    (147, '2024-02-20', 2, 4, 202, 27, '2024-02-20 11:00:00', '2024-02-25 16:00:00', 'In Progress', 303),
    (148, '2024-02-21', 3, 5, 203, 28, '2024-02-21 12:00:00', '2024-02-26 17:00:00', 'Pending', 313),
    (149, '2024-02-22', 4, 6, 204, 29, '2024-02-22 13:00:00', '2024-02-27 18:00:00', 'Completed', 304),
    (150, '2024-02-23', 5, 7, 205, 30, '2024-02-23 14:00:00', '2024-02-28 19:00:00', 'In Progress', 305),
    (151, '2024-02-24', 6, 8, 206, 31, '2024-02-24 15:00:00', '2024-02-29 20:00:00', 'Pending', 306),
    (152, '2024-02-25', 7, 9, 207, 32, '2024-02-25 16:00:00', '2024-03-01 21:00:00', 'Completed', 307),
    (153, '2024-02-26', 8, 10, 208, 33, '2024-02-26 17:00:00', '2024-03-02 22:00:00', 'In Progress', 308),
    (154, '2024-02-27', 9, 11, 209, 34, '2024-02-27 18:00:00', '2024-03-03 23:00:00', 'Pending', 309),
    (155, '2024-02-28', 10, 12, 210, 35, '2024-02-28 19:00:00', '2024-03-04 08:00:00', 'Completed', 301);

-- Fremdschlüsselcheck aktivieren um gegebenenfalls Fehler zu erkennen
SET FOREIGN_KEY_CHECKS = 1;

-- Ende Hinzufügen der Dummy-Daten

COMMIT;