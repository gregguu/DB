create DATABASE TransitSystem;
USE TransitSystem;

CREATE TABLE Province(
	ProvinceId INTEGER PRIMARY KEY,
	ProvinceName VARCHAR(30) NOT NULL
);

CREATE TABLE City(
	CityId INTEGER PRIMARY KEY,
	CityName VARCHAR(30) NOT NULL
);

CREATE TABLE Country(
	CountryId INTEGER PRIMARY KEY,
	CountryName VARCHAR(30) NOT NULL
);

CREATE TABLE SystemType(
	TypeId INTEGER PRIMARY KEY,
	TypeName VARCHAR(30) NOT NULL
);

CREATE TABLE Sector(
	SectorId INTEGER PRIMARY KEY,
	SectorName VARCHAR(30) NOT NULL
);

CREATE TABLE TicketType(
	PassId INTEGER PRIMARY KEY,
	Validity VARCHAR(30) NOT NULL, 
	NumberOfUse INTEGER 
);

CREATE TABLE TransportationZone(
	ZoneId INTEGER PRIMARY KEY,
	ZoneName VARCHAR(30)
);

CREATE TABLE ZoneCombination(
	Id INTEGER PRIMARY KEY
);

CREATE TABLE ZoneDistribution( 
	ZoneId INTEGER,
	Id INTEGER,
	PRIMARY KEY (ZoneId, Id),
	FOREIGN KEY (ZoneId) REFERENCES TransportationZone(ZoneId),
	FOREIGN KEY (Id) REFERENCES ZoneCombination(Id)
);

CREATE TABLE Notification(
	NotificationId INTEGER PRIMARY KEY,
	NotiDescription TEXT NOT NULL,
	NotiStatus VARCHAR(30) NOT NULL
);

CREATE TABLE Ticket(
	Id INTEGER PRIMARY KEY,
	Price INTEGER NOT NULL,
	PassId INTEGER,
	ZoneId INTEGER,
	FOREIGN KEY (ZoneId) REFERENCES  ZoneCombination(Id),
	FOREIGN KEY (PassID) REFERENCES TicketType(PassId)
);

CREATE TABLE ScheduleType(
	TypeId INTEGER PRIMARY KEY,
	TypeName VARCHAR(30) NOT NULL
);

CREATE TABLE Station(
	StationId INTEGER PRIMARY KEY,
	PostalCode VARCHAR(30) NOT NULL,
	CivicNumber INTEGER NOT NULL,
	Name VARCHAR(30) NOT NULL,
	Street VARCHAR(30) NOT NULL,
	AppartmentNumber INTEGER,
	ProvinceId INTEGER,
	CityId INTEGER,
	CountryId INTEGER,
	NotificationId INTEGER,
	ConnectedStationId INTEGER,
	UNIQUE (StationId, NotificationId),
	FOREIGN KEY (ProvinceId) REFERENCES Province(ProvinceId),
	FOREIGN KEY (CityId) REFERENCES City(CityId),
	FOREIGN KEY (CountryId) REFERENCES Country(CountryId),
	FOREIGN KEY (NotificationId) REFERENCES Notification(NotificationId),
	FOREIGN KEY (ConnectedStationId) REFERENCES Station(StationId)
);

CREATE TABLE StationsZone(
	StationId INTEGER,
	ZoneId INTEGER,
	PRIMARY KEY (StationId, ZoneId),
	FOREIGN KEY (StationId) REFERENCES Station(StationId),
	FOREIGN KEY (ZoneId) REFERENCES TransportationZone(ZoneId)
);

CREATE TABLE Branch(
	BranchId INTEGER PRIMARY KEY,
	BranchName VARCHAR(30) NOT NULL,
	StartStationId INTEGER,
	EndStationId INTEGER,
	FOREIGN KEY (StartStationId) REFERENCES Station(StationId),
	FOREIGN KEY (EndStationId) REFERENCES Station(StationId)
);

CREATE TABLE IsOn(
	StationId INTEGER,
	BranchId INTEGER,
	PRIMARY KEY (StationId, BranchId),
	FOREIGN KEY (StationId) REFERENCES Station(StationId),
	FOREIGN KEY (BranchId) REFERENCES Branch(BranchId)
);

CREATE TABLE Schedule(
	ScheduleId INTEGER PRIMARY KEY,
	FirstDeparture DATETIME NOT NULL,
	LastDeparture DATETIME NOT NULL,
	FrequencyPeak INTEGER NOT NULL,
	FrequencyOffPeak INTEGER NOT NULL,
	TypeId INTEGER,
	StationId INTEGER,
	BranchId INTEGER
	FOREIGN KEY (TypeId) REFERENCES ScheduleType(TypeId),
	FOREIGN KEY (StationId) REFERENCES Station(StationId),
	FOREIGN KEY (BranchId) REFERENCES Branch(BranchId)
);

CREATE TABLE Category(
	CategoryId INTEGER PRIMARY KEY,
	CategoryName VARCHAR(30) NOT NULL
);

CREATE TABLE FAQ(
	FAQId INTEGER PRIMARY KEY,
	FAQName VARCHAR(30) NOT NULL,
	ShortAnswer TEXT,
	LongAnswer TEXT,
	CategoryId INTEGER,
	FOREIGN KEY (CategoryId) REFERENCES Category(CategoryId)
);

CREATE TABLE News(
	NewsId INTEGER PRIMARY KEY, 
	Title VARCHAR(30) NOT NULL,
	PublishedDate DATETIME NOT NULL,
	Content TEXT NOT NULL,
	SectorId INTEGER, 
	CategoryId INTEGER,
	FOREIGN KEY (SectorId) REFERENCES Sector(SectorId),
	FOREIGN KEY (CategoryId) REFERENCES Category(CategoryId)
);

CREATE TABLE SystemProperties(
	UniqueId INTEGER PRIMARY KEY,
	TrainSpeed INTEGER NOT NULL,
	HoursOfService INTEGER NOT NULL,
	PropelledBy VARCHAR(30) NOT NULL, 
	OperatedBy VARCHAR(30) NOT NULL,
	TrackLength INTEGER NOT NULL
);

CREATE TABLE Services(
	ServiceId INTEGER PRIMARY KEY, 
	Name VARCHAR(30) NOT NULL
);

CREATE TABLE TypeOfService(
	StationId INTEGER,
	ServiceId INTEGER,
	PRIMARY KEY(StationId, ServiceId),
	FOREIGN KEY (StationId) REFERENCES Station(StationId),
	FOREIGN KEY (ServiceId) REFERENCES Services(ServiceId)
);