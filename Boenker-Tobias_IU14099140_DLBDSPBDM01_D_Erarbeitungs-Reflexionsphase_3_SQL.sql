-- Buch hinzufügen
START TRANSACTION;
INSERT INTO Books (BookID, BookUserID, ISBN, BookTitle, Author, Publisher, GenreID, Year, LanguageID, UserID, TimeslotID, StateID, Availability)
VALUES
    (299, 1001, 9780451522344, '1984', 'George Orwell', 'Houghton Mifflin Harcourt', 1, '1949-06-08', 1, 1002, 1, 1, false);
COMMIT;

-- Verfügbarkeit eines Buches ändern (BookID muss existieren)
UPDATE Books
SET Availability = true
WHERE BookID = 299;

-- Vergangene Prozesse nach Datum sortiert ausgeben (mit Filter nach Borrower und Lender) --> alle Bücher die eine Person von einer anderen Person ausgeliehen hat
SELECT Lender, Borrower, ProcessDate, BookTitle, BookID, Process.Borrower as BorrowerUserID
FROM Process
JOIN Lender ON Process.Lender = Lender.LenderUserID
JOIN Borrower ON Process.Borrower = Borrower.BorrowerUserID
JOIN Books ON Process.ProcessBookID = Books.BookID   
WHERE Lender = 1 AND Borrower = 2
ORDER BY Process.ProcessDate;

-- Meldung für Admin hinzufügen (in AdminMessages)
START TRANSACTION;
SET FOREIGN_KEY_CHECKS = 0;
INSERT INTO AdminMessages (MessageID, MessageUserID, Message, MessageCategory)
VALUES
    (99, 1, 'Test Message 123', 'Category1');
SET FOREIGN_KEY_CHECKS = 1;
COMMIT;  

-- Alle verfügbaren Bücher suchen
SELECT *
FROM Books
WHERE Availability = true;

-- Buch bewerten 1 --> ohne Benutzer-Check
START TRANSACTION;
INSERT INTO Rating (RatingID, RatingBookID, RatingUserID, Rating, Stars)
VALUES
    (98, 201, 1001, 'Good, not perfect', 4);
COMMIT; 

-- Buch bewerten 2 --> mit Bedingung, dass Benutzer bewertetes Buch ausgeliehen hat, falls Benutzer Buch nicht hat/hatte wird die Bewertung nicht eingetragen (Der Befehl läuft trotzdem ohne Error durch)
START TRANSACTION;
INSERT INTO Rating (RatingID, RatingBookID, RatingUserID, Rating, Stars)
SELECT 98, 201, 1001, 'Good, not perfect', 4
FROM Process
WHERE Process.ProcessBookID = 201 AND Process.Borrower = 1001 OR Process.Lender = 1001;
COMMIT;



