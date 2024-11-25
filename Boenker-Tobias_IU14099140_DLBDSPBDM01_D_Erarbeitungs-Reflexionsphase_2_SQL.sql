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

COMMIT;