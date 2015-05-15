

--This table stores the information for anyone registered for a class or athletic team
create table Community_Members
(
Community_ID integer primary key,
First_name varchar(40) not null,
Last_name varchar(40) not null,
Gender varchar(6),
check (Gender in ('Male','Female')),
Street_Address varchar (50) not null,
Apartment_# varchar(10),
Home_Phone char(12) not null,
City varchar (20) not null,
State char(2) not null,
Zip integer not null,
Work_Phone varchar(20),
Email_Address varchar(30),
Dat_of_Birth datetime,
Swim_Level integer
)
 
--This table stores the information for those who owe or have owed money for classes or
--athletic teams
create table Invoice
(
Invoice_ID integer primary key,
Community_ID integer foreign key references Community_Members (Community_ID),
Fee integer not null,
Payment_Option varchar(6),
Date_Paid datetime,
check (Payment_Option in ('Debit','Credit','Check','Cash', null)),
)
 
--This table stores information about the city's pools
CREATE TABLE Pools
(
Pool_Name VARCHAR(30) PRIMARY KEY,
Number_of_Lanes INT NOT NULL,
Operating_Hours VARCHAR(30) NOT NULL,
Address VARCHAR(30),
Phone_Number VARCHAr(20)
)
 
--This table stores information about the city's parks
CREATE TABLE Parks
(
Park_Name VARCHAR(30) PRIMARY KEY,
Operating_Hours VARCHAR(30) NOT NULL,
Address VARCHAR(30),
Phone_Number VARCHAR(20)
)
 
--This table stores information about the city's community centers
CREATE TABLE Community_Centers
(
Center_Name VARCHAR(30) PRIMARY KEY,
Operating_Hours VARCHAR(30) NOT NULL,
Address VARCHAR(30),
Phone_Number VARCHAr(20)
)
 
--This table stores information about those who are teaching classes
create table Instructors
(
Instructor_ID integer primary key,
First_Name varchar(30) not null,
Last_Name varchar (40) not null,
Street_Address varchar (50) not null,
Apartment_# varchar(10),
City varchar (20) not null,
State char(2) not null,
Zip integer not null,
Primary_Phone char(12) not null,
Secondary_Phone varchar(20),
Email_Address varchar(30),
)
 
/*This table stores information about classes and is a parent table to the tables
Outdoor_classes, indoor_classes, and aquatic_classes. The attribute Class_Location determines
which of the sub-types each class belongs to */
create table Classes
(
Class_ID integer,
Instructor_ID integer not null foreign key references instructors(Instructor_ID),
Class_Name varchar(50) not null,
Program varchar(30) not null,
Location_type varchar(7)
check (location_type in ('Outdoor','Indoor','Aquatic')),
Start_Time time not null,
End_Time time not null,
Fee numeric (20,2) not null,
Age_requirement integer,
Days_Occuring varchar(60),
Start_Date date not null,
End_Date date not null,
Constraint Classes_PK primary key (Class_ID, Location_Type),
Constraint Classes_FK foreign key (Instructor_ID) references instructors(instructor_ID)
)
--This is a subtype of classes that stores information on classes in parks
create table Outdoor_Classes
(
Class_ID integer not null,
Location_Type varchar(7) not null
Check (location_Type in ('outdoor')),
Park varchar(30) not null,
Area varchar(30) not null,
constraint Outdoor_Classes_PK primary key (Class_ID, location_type),
Constraint Outdoor_Classes_FK1 foreign key (Class_ID, location_Type) references classes(class_ID, location_type),
Constraint Outdoor_Classes_FK2 foreign key (Park) references Parks(Park_Name),
)
--This is a subtype of classes that stores information on classes in community centers
create table Indoor_Classes
(
Class_ID integer not null,
Location_Type varchar(7) not null
Check (location_Type in ('Indoor')),
Community_Center varchar(30) not null,
constraint Indoor_Classes_PK primary key (Class_ID, location_type),
Constraint Indoor_Classes_FK1 foreign key (Class_ID, location_Type) references classes(class_ID, location_type),
Constraint Indoor_Classes_FK2 foreign key (Community_center) references Community_Centers(Center_Name),
)
--This is a subtype of classes that stores information on classes in pools
create table Aquatic_Classes
(
Class_ID integer not null,
Location_Type varchar(7) not null
Check (location_Type in ('Aquatic')),
Pool_Name varchar(30) not null,
constraint Aquatic_Classes_PK primary key (Class_ID, location_type),
Constraint Aquatic_Classes_FK1 foreign key (Class_ID, location_Type) references classes(class_ID, location_type),
Constraint Aquatic_Classes_FK2 foreign key (Pool_Name) references Pools(Pool_Name),
)
 
--This table stores information on athletic teams
create table Teams
(
Team_ID integer primary key,
Team_Name varchar(30) not null,
League varchar(10) not null,
Maximum_Members integer not null,
Manager integer foreign key references Community_Members (Community_ID),
Captain integer foreign key references Community_Members (Community_ID),
Nights_Able_to_Play varchar(100),
)
 
--This table is a bridge between community members and the athletic teams they are on
create table Athletic_Registration
(
Registration_ID integer primary key,
Community_ID integer foreign key references Community_Members (Community_ID),
Team_ID integer foreign key references Teams(Team_ID),
Jersey_Number integer not null,
)
 
/*This table stores information regarding when athletic games will take place.
It is a parent table to Outdoor_Sports_Schedule and Indoor_Sports_Schedule
with the attribute Location_Type defining which of the subtypes each game belongs to */
create table athletic_schedule
(
Game_ID integer not null,
Game_Date date not null,
Start_Time time not null,
End_Time time not null,
Location_Type varchar(7) not null
check (Location_type in ('Outdoor','Indoor')),
Team_1 integer foreign key references teams(team_ID),
Team_2 integer foreign key references teams(team_ID),
Winner integer foreign key references Teams(Team_ID),
Team_1_Score integer,
Team_2_Score integer,
constraint athletic_Schedule_PK primary key (Game_ID, location_type),
)
--This is a subtype of athletic_schedule regarding games in parks
Create TABLE Outdoor_Sports_Schedule
(
Game_ID Integer,
Location_Type varchar(7) default 'Outdoor' not null,
check(Location_type in('Outdoor')),
Park_Name VARCHAR(30) not null,
Area VARCHAR(30) NOT NULL,
constraint Outdoor_Sports_PK primary key (Game_ID, Location_Type),
constraint Outdoor_Sports_FK1 foreign key (Game_ID, Location_Type)references Athletic_Schedule(game_ID, location_Type),
constraint Outdoor_Sports_FK2 foreign key (Park_Name) references Parks(Park_Name),
)
 
--This is a subtype of athletic_schedule regarding games in community center
Create TABLE Indoor_Sports_Schedule
(
Game_ID Integer,
Location_Type varchar(7) default 'Indoor' not null,
check(Location_type in('Indoor')),
Community_Center VARCHAR(30) not null,
constraint Indoor_Sports_PK primary key (Game_ID, Location_Type),
constraint Indoor_Sports_FK1 foreign key (Game_ID, Location_Type)references Athletic_Schedule(game_ID, location_Type),
constraint Indoor_Sports_FK2 foreign key (Community_Center) references Community_Centers(Center_Name),
)
 
--this table is a bridge between community members and the classes they are registered for
Create table Class_Registration
(
Registration_ID integer primary key,
Community_ID integer foreign key references Community_Members (Community_ID),
Class_ID integer not null,
)
  
INSERT [dbo].[Community_Members] ([Community_ID], [First_name], [Last_name], [Gender], [Street_Address], [Apartment_#], [Home_Phone], [City], [State], [Zip], [Work_Phone], [Email_Address], [Dat_of_Birth], [Swim_Level]) VALUES (1, N'Bob', N'Benson', N'Male', N'659 Westcott St', N'5', N'323-234-1235', N'Syracuse', N'NY', 13210, NULL, N'bb@gmail.com', NULL, NULL)
INSERT [dbo].[Community_Members] ([Community_ID], [First_name], [Last_name], [Gender], [Street_Address], [Apartment_#], [Home_Phone], [City], [State], [Zip], [Work_Phone], [Email_Address], [Dat_of_Birth], [Swim_Level]) VALUES (2, N'Joan', N'Holloway', N'Female', N'765 Euclid Ave', NULL, N'233-232-5341', N'Syracuse', N'NY', 13210, NULL, N'JH@scp.org', NULL, NULL)
INSERT [dbo].[Community_Members] ([Community_ID], [First_name], [Last_name], [Gender], [Street_Address], [Apartment_#], [Home_Phone], [City], [State], [Zip], [Work_Phone], [Email_Address], [Dat_of_Birth], [Swim_Level]) VALUES (3, N'Sally', N'Draper', N'Female', N'312 Maryland Ave', NULL, N'233-213-1243', N'Syracuse', N'NY', 13210, NULL, N'sd@hotmail.com', CAST(0x00009E7F00000000 AS DateTime), 2)
INSERT [dbo].[Community_Members] ([Community_ID], [First_name], [Last_name], [Gender], [Street_Address], [Apartment_#], [Home_Phone], [City], [State], [Zip], [Work_Phone], [Email_Address], [Dat_of_Birth], [Swim_Level]) VALUES (4, N'Peter', N'Campbell', N'Male', N'231 Ostram Ave', N'3', N'233-242-1232', N'Syracuse', N'NY', 13210, N'433-545-2341', N'pc@yahoo.com', NULL, NULL)
INSERT [dbo].[Community_Members] ([Community_ID], [First_name], [Last_name], [Gender], [Street_Address], [Apartment_#], [Home_Phone], [City], [State], [Zip], [Work_Phone], [Email_Address], [Dat_of_Birth], [Swim_Level]) VALUES (5, N'Peggy', N'Olsen', N'Female', N'231 S Salina St', N'4', N'232-234-2433', N'Syracuse', N'NY', 13210, NULL, N'po@gmail.com', NULL, NULL)
INSERT [dbo].[Community_Members] ([Community_ID], [First_name], [Last_name], [Gender], [Street_Address], [Apartment_#], [Home_Phone], [City], [State], [Zip], [Work_Phone], [Email_Address], [Dat_of_Birth], [Swim_Level]) VALUES (6, N'Lane', N'Price', N'Male', N'432 University Ave', NULL, N'343-434-2342', N'Syracuse', N'NY', 13210, NULL, N'lp@scp.org', NULL, NULL)
INSERT [dbo].[Community_Members] ([Community_ID], [First_name], [Last_name], [Gender], [Street_Address], [Apartment_#], [Home_Phone], [City], [State], [Zip], [Work_Phone], [Email_Address], [Dat_of_Birth], [Swim_Level]) VALUES (7, N'Ken', N'Cosgrove', N'Male', N'231 Main St', N'4', N'232-234-2445', N'Syracuse', N'NY', 13210, N'234-232-4534', N'kc@gmail.com', NULL, NULL)
INSERT [dbo].[Community_Members] ([Community_ID], [First_name], [Last_name], [Gender], [Street_Address], [Apartment_#], [Home_Phone], [City], [State], [Zip], [Work_Phone], [Email_Address], [Dat_of_Birth], [Swim_Level]) VALUES (8, N'Rachel', N'Menken', N'Female', N'342 Lancaster Ave', NULL, N'235-343-1231', N'Syracuse', N'NY', 13210, N'343-343-1234', N'RM@outlook.com', NULL, NULL)
INSERT [dbo].[Community_Members] ([Community_ID], [First_name], [Last_name], [Gender], [Street_Address], [Apartment_#], [Home_Phone], [City], [State], [Zip], [Work_Phone], [Email_Address], [Dat_of_Birth], [Swim_Level]) VALUES (9, N'Glen', N'Bishop', N'Male', N'343 E Jefferson St', N'3', N'434-343-2342', N'Syracuse', N'NY', 13210, NULL, N'gb@yahoo.com', CAST(0x0000936F00000000 AS DateTime), 1)
INSERT [dbo].[Community_Members] ([Community_ID], [First_name], [Last_name], [Gender], [Street_Address], [Apartment_#], [Home_Phone], [City], [State], [Zip], [Work_Phone], [Email_Address], [Dat_of_Birth], [Swim_Level]) VALUES (10, N'Betty', N'Francis', N'Female', N'453 E Fayette St', NULL, N'423-345-2355', N'Syracuse', N'NY', 13210, NULL, N'bf@outlook.com', NULL, NULL)
INSERT [dbo].[Community_Members] ([Community_ID], [First_name], [Last_name], [Gender], [Street_Address], [Apartment_#], [Home_Phone], [City], [State], [Zip], [Work_Phone], [Email_Address], [Dat_of_Birth], [Swim_Level]) VALUES (11, N'Roger', N'Sterling', N'Male', N'343 Onondaga St', N'10', N'343-234-2344', N'Syracuse', N'NY', 13210, N'534-342-2322', N'rs@scp.org', NULL, NULL)
INSERT [dbo].[Community_Members] ([Community_ID], [First_name], [Last_name], [Gender], [Street_Address], [Apartment_#], [Home_Phone], [City], [State], [Zip], [Work_Phone], [Email_Address], [Dat_of_Birth], [Swim_Level]) VALUES (12, N'Dawn', N'Chambers', N'Female', N'645 Townsend St', NULL, N'232-233-3242', N'Syracuse', N'NY', 13210, NULL, N'dc@yahoo.com', NULL, NULL)
INSERT [dbo].[Community_Members] ([Community_ID], [First_name], [Last_name], [Gender], [Street_Address], [Apartment_#], [Home_Phone], [City], [State], [Zip], [Work_Phone], [Email_Address], [Dat_of_Birth], [Swim_Level]) VALUES (13, N'Ted', N'Chough', N'Male', N'233 W Washington St', NULL, N'234-454-2342', N'Syracuse', N'NY', 13210, NULL, N'tc@gmail.com', NULL, NULL)
INSERT [dbo].[Community_Members] ([Community_ID], [First_name], [Last_name], [Gender], [Street_Address], [Apartment_#], [Home_Phone], [City], [State], [Zip], [Work_Phone], [Email_Address], [Dat_of_Birth], [Swim_Level]) VALUES (14, N'Bert', N'Cooper', N'Male', N'534 Bank St', N'11', N'243-345-3433', N'Syracuse', N'NY', 13210, N'423-534-4353', N'bc@hotmail.com', NULL, NULL)
INSERT [dbo].[Community_Members] ([Community_ID], [First_name], [Last_name], [Gender], [Street_Address], [Apartment_#], [Home_Phone], [City], [State], [Zip], [Work_Phone], [Email_Address], [Dat_of_Birth], [Swim_Level]) VALUES (15, N'Faye', N'Miller', N'Female', N'232 E Genesee St', NULL, N'323-234-3242', N'Syracuse', N'NY', 13210, NULL, N'FM@gmail.com', NULL, NULL)
 
 
INSERT [dbo].[Community_Centers] ([Center_Name], [Operating_Hours], [Address], [Phone_Number]) VALUES (N'Bob Cecile Community Center', N'Mon-Fri: 9am - 3pm', N'174 W. Seneca Turnpike', N'473-2678')
INSERT [dbo].[Community_Centers] ([Center_Name], [Operating_Hours], [Address], [Phone_Number]) VALUES (N'Cannon Street Community Center', N'Mon-Fri: 2pm - 6pm', N'529 Cannon Street', N'471-2106')
INSERT [dbo].[Community_Centers] ([Center_Name], [Operating_Hours], [Address], [Phone_Number]) VALUES (N'Northeast Community Center', N'Mon-Fri: 2pm - 7pm', N'716 Hawley Ave', N'472-6343')
INSERT [dbo].[Community_Centers] ([Center_Name], [Operating_Hours], [Address], [Phone_Number]) VALUES (N'Seals Community Center', N'Mon-Fri: 2pm - 7pm', N'300 Borden Ave', N'473-2799')
INSERT [dbo].[Community_Centers] ([Center_Name], [Operating_Hours], [Address], [Phone_Number]) VALUES (N'Westside Senior Center', N'Mon, Tue & Thu: 9:30am -2:30pm', N'135 State Fair Blvd.', N' 466-5711')
 
 
INSERT [dbo].[Pools] ([Pool_Name], [Number_of_Lanes], [Operating_Hours], [Address], [Phone_Number]) VALUES (N'Burnet Pool', 7, N'3:00pm - 7:00pm', N'300 Coleridge Ave', N'437-4330 x3025')
INSERT [dbo].[Pools] ([Pool_Name], [Number_of_Lanes], [Operating_Hours], [Address], [Phone_Number]) VALUES (N'Schiller Park Pool', 16, N'12:00pm - 7:00pm', N'1100 Rugby Road at Oak St', N'437-4330 x3025')
INSERT [dbo].[Pools] ([Pool_Name], [Number_of_Lanes], [Operating_Hours], [Address], [Phone_Number]) VALUES (N'Southwest Community Center', 7, N'11:00am - 8:00pm', N'230 Lincoln Ave at Clover St', N'437-4330 x3025')
INSERT [dbo].[Pools] ([Pool_Name], [Number_of_Lanes], [Operating_Hours], [Address], [Phone_Number]) VALUES (N'Valley Pool', 7, N'6:30am - 8:00pm', N'4900 S Salina St', N'437-4330 x3025')
INSERT [dbo].[Pools] ([Pool_Name], [Number_of_Lanes], [Operating_Hours], [Address], [Phone_Number]) VALUES (N'Wilson Park Pool', 7, N'12:00pm - 6:00pm', N'1117 South McBridge St', N'437-4330 x3025')
 
 
INSERT [dbo].[Parks] ([Park_Name], [Address], [Acerage], [Type]) VALUES (N'Barry Park', N'Meadowbrook Dr., Broad & Wescott Streets', CAST(15.130 AS Decimal(6, 3)), N'Neighborhood Park')
INSERT [dbo].[Parks] ([Park_Name], [Address], [Acerage], [Type]) VALUES (N'Clinton Square', N'Erie Blvd. West & North Salina Street', CAST(0.553 AS Decimal(6, 3)), N'Downtown Park')
INSERT [dbo].[Parks] ([Park_Name], [Address], [Acerage], [Type]) VALUES (N'Faldo Park', N'500 Block of Milton Ave', CAST(0.225 AS Decimal(6, 3)), N'Median')
INSERT [dbo].[Parks] ([Park_Name], [Address], [Acerage], [Type]) VALUES (N'Homer Wheaton Park', N'Mountainview and Ball Aves', CAST(11.430 AS Decimal(6, 3)), N'Neighborhood')
INSERT [dbo].[Parks] ([Park_Name], [Address], [Acerage], [Type]) VALUES (N'Onondaga Park', N'655 Onondaga Avenue to 1100 South Avenue', CAST(15.600 AS Decimal(6, 3)), N'Community Park')
 
 
INSERT [dbo].[Instructors] ([Instructor_ID], [First_Name], [Last_Name], [Street_Address], [Apartment_#], [City], [State], [Zip], [Primary_Phone], [Secondary_Phone], [Email_Address]) VALUES (1, N'Carl', N'Jenkins', N'555 Westcott Street', N'5', N'Syracuse', N'NY', 13210, N'555-753-0928', NULL, N'cj@gmail.com')
INSERT [dbo].[Instructors] ([Instructor_ID], [First_Name], [Last_Name], [Street_Address], [Apartment_#], [City], [State], [Zip], [Primary_Phone], [Secondary_Phone], [Email_Address]) VALUES (2, N'Wendy', N'Mathers', N'342 Ostram Ave', NULL, N'Syracuse', N'NY', 13210, N'423-233-1223', N'546-212-2342', N'wm@hotmail.com')
INSERT [dbo].[Instructors] ([Instructor_ID], [First_Name], [Last_Name], [Street_Address], [Apartment_#], [City], [State], [Zip], [Primary_Phone], [Secondary_Phone], [Email_Address]) VALUES (3, N'Billy', N'Mays', N'621 Lancaster Rd', NULL, N'Syracuse', N'NY', 13210, N'542-122-1231', NULL, N'bm@yahoo.com')
INSERT [dbo].[Instructors] ([Instructor_ID], [First_Name], [Last_Name], [Street_Address], [Apartment_#], [City], [State], [Zip], [Primary_Phone], [Secondary_Phone], [Email_Address]) VALUES (4, N'Gregory', N'Herman', N'452 University Ave', NULL, N'Syracuse', N'NY', 13210, N'335-121-7545', NULL, N'gh@syr.edu')
INSERT [dbo].[Instructors] ([Instructor_ID], [First_Name], [Last_Name], [Street_Address], [Apartment_#], [City], [State], [Zip], [Primary_Phone], [Secondary_Phone], [Email_Address]) VALUES (5, N'Yohan', N'Noodles', N'432 Marshall Ave', N'2', N'Syracuse', N'NY', 13210, N'533-234-1234', NULL, N'yn@gmail.com')
 
 
INSERT [dbo].[Invoice] ([Invoice_ID], [Community_ID], [Fee], [Payment_Option], [Date_Paid]) VALUES (1, 6, 10, NULL, NULL)
INSERT [dbo].[Invoice] ([Invoice_ID], [Community_ID], [Fee], [Payment_Option], [Date_Paid]) VALUES (2, 3, 35, N'Credit', CAST(0x0000A2EE00000000 AS DateTime))
INSERT [dbo].[Invoice] ([Invoice_ID], [Community_ID], [Fee], [Payment_Option], [Date_Paid]) VALUES (3, 8, 50, N'Cash', CAST(0x0000A30100000000 AS DateTime))
INSERT [dbo].[Invoice] ([Invoice_ID], [Community_ID], [Fee], [Payment_Option], [Date_Paid]) VALUES (4, 10, 35, NULL, NULL)
INSERT [dbo].[Invoice] ([Invoice_ID], [Community_ID], [Fee], [Payment_Option], [Date_Paid]) VALUES (5, 3, 2, N'Cash', CAST(0x0000A31100000000 AS DateTime))
INSERT [dbo].[Invoice] ([Invoice_ID], [Community_ID], [Fee], [Payment_Option], [Date_Paid]) VALUES (6, 1, 25, N'Debit', CAST(0x0000A2C700000000 AS DateTime))
INSERT [dbo].[Invoice] ([Invoice_ID], [Community_ID], [Fee], [Payment_Option], [Date_Paid]) VALUES (7, 9, 25, N'Credit', CAST(0x0000A30B00000000 AS DateTime))
INSERT [dbo].[Invoice] ([Invoice_ID], [Community_ID], [Fee], [Payment_Option], [Date_Paid]) VALUES (8, 15, 25, NULL, NULL)
INSERT [dbo].[Invoice] ([Invoice_ID], [Community_ID], [Fee], [Payment_Option], [Date_Paid]) VALUES (9, 8, 35, N'Cash', CAST(0x0000A30100000000 AS DateTime))
INSERT [dbo].[Invoice] ([Invoice_ID], [Community_ID], [Fee], [Payment_Option], [Date_Paid]) VALUES (10, 9, 25, NULL, NULL)
 
 
INSERT [dbo].[Teams] ([Team_ID], [Team_Name], [League], [Maximum_Members], [Manager], [Captain], [Nights_Able_to_Play], [Sport]) VALUES (1, N'Fighting Warriors', N'C-1', 15, 1, 4, N'Monday, Wednesday, Friday', N'Softball')
INSERT [dbo].[Teams] ([Team_ID], [Team_Name], [League], [Maximum_Members], [Manager], [Captain], [Nights_Able_to_Play], [Sport]) VALUES (2, N'Lucky Ladies', N'W C-1', 15, 2, 5, N'Tuesday, Friday, Sunday', N'Broomball')
INSERT [dbo].[Teams] ([Team_ID], [Team_Name], [League], [Maximum_Members], [Manager], [Captain], [Nights_Able_to_Play], [Sport]) VALUES (3, N'Ad Men', N'C-1', 10, 13, 14, N'Monday, Tuesday, Wednesday', N'Softball')
INSERT [dbo].[Teams] ([Team_ID], [Team_Name], [League], [Maximum_Members], [Manager], [Captain], [Nights_Able_to_Play], [Sport]) VALUES (4, N'Broncos', N'w C-1', 15, 10, 12, N'Tuesday, Thursday', N'Broomball')
INSERT [dbo].[Teams] ([Team_ID], [Team_Name], [League], [Maximum_Members], [Manager], [Captain], [Nights_Able_to_Play], [Sport]) VALUES (5, N'Pitchers', N'D-2', 12, 7, 6, N'Monday, Wednesday, Saturday', N'Basketball')
INSERT [dbo].[Teams] ([Team_ID], [Team_Name], [League], [Maximum_Members], [Manager], [Captain], [Nights_Able_to_Play], [Sport]) VALUES (6, N'Sellers', N'D-2', 12, 11, 4, N'Wednesday, Friday, Sunday', N'Basketball')
 
 
INSERT [dbo].[Classes] ([Class_ID], [Instructor_ID], [Class_Name], [Program], [Location_type], [Start_Time], [End_Time], [Fee], [Age_requirement], [Days_Occuring], [Start_Date], [End_Date]) VALUES (1, 2, N'Little Swimmers', N'Aquatic', N'Aquatic', CAST(0x0700E03495640000 AS Time), CAST(0x07001417C6680000 AS Time), CAST(10.00 AS Numeric(20, 2)), 2, N'Wednesday', CAST(0x6A380B00 AS Date), CAST(0x78380B00 AS Date))
INSERT [dbo].[Classes] ([Class_ID], [Instructor_ID], [Class_Name], [Program], [Location_type], [Start_Time], [End_Time], [Fee], [Age_requirement], [Days_Occuring], [Start_Date], [End_Date]) VALUES (2, 3, N'Adult Beginner Watercolor', N'Arts & Crafts', N'Indoor', CAST(0x070048F9F66C0000 AS Time), CAST(0x07001882BA7D0000 AS Time), CAST(25.00 AS Numeric(20, 2)), NULL, N'Wednesday', CAST(0x7F380B00 AS Date), CAST(0xEF380B00 AS Date))
INSERT [dbo].[Classes] ([Class_ID], [Instructor_ID], [Class_Name], [Program], [Location_type], [Start_Time], [End_Time], [Fee], [Age_requirement], [Days_Occuring], [Start_Date], [End_Date]) VALUES (3, 4, N'X-C Ski', N'Fitness', N'Outdoor', CAST(0x070010ACD1530000 AS Time), CAST(0x0700E80A7E8E0000 AS Time), CAST(2.00 AS Numeric(20, 2)), NULL, N'Monday', CAST(0x4F390B00 AS Date), CAST(0xA8390B00 AS Date))
INSERT [dbo].[Classes] ([Class_ID], [Instructor_ID], [Class_Name], [Program], [Location_type], [Start_Time], [End_Time], [Fee], [Age_requirement], [Days_Occuring], [Start_Date], [End_Date]) VALUES (4, 1, N'Zumba In The Square', N'Fitness', N'Outdoor', CAST(0x0700FAA5AD660000 AS Time), CAST(0x07002E88DE6A0000 AS Time), CAST(0.00 AS Numeric(20, 2)), NULL, N'Tuesday', CAST(0x5B380B00 AS Date), CAST(0xF3380B00 AS Date))
INSERT [dbo].[Classes] ([Class_ID], [Instructor_ID], [Class_Name], [Program], [Location_type], [Start_Time], [End_Time], [Fee], [Age_requirement], [Days_Occuring], [Start_Date], [End_Date]) VALUES (5, 5, N'Advanced Raku Pottery Hand Building', N'Recreation', N'Indoor', CAST(0x0700E03495640000 AS Time), CAST(0x0700E49F89790000 AS Time), CAST(50.00 AS Numeric(20, 2)), NULL, N'Wednesday', CAST(0xB1380B00 AS Date), CAST(0xF0380B00 AS Date))
INSERT [dbo].[Classes] ([Class_ID], [Instructor_ID], [Class_Name], [Program], [Location_type], [Start_Time], [End_Time], [Fee], [Age_requirement], [Days_Occuring], [Start_Date], [End_Date]) VALUES (6, 2, N'Lifeguard Training', N'Aquatic', N'Aquatic', CAST(0x0700A8E76F4B0000 AS Time), CAST(0x0700E03495640000 AS Time), CAST(25.00 AS Numeric(20, 2)), 15, N'Saturday, Sunday', CAST(0x74380B00 AS Date), CAST(0x9E380B00 AS Date))
INSERT [dbo].[Classes] ([Class_ID], [Instructor_ID], [Class_Name], [Program], [Location_type], [Start_Time], [End_Time], [Fee], [Age_requirement], [Days_Occuring], [Start_Date], [End_Date]) VALUES (7, 5, N'Zumba Gold', N'Senior Recreation', N'Outdoor', CAST(0x0700DCC9A04F0000 AS Time), CAST(0x0700448E02580000 AS Time), CAST(35.00 AS Numeric(20, 2)), NULL, N'Monday, Wednesday', CAST(0x06380B00 AS Date), CAST(0x39380B00 AS Date))
INSERT [dbo].[Classes] ([Class_ID], [Instructor_ID], [Class_Name], [Program], [Location_type], [Start_Time], [End_Time], [Fee], [Age_requirement], [Days_Occuring], [Start_Date], [End_Date]) VALUES (8, 2, N'Seahorse Lessons', N'Aquatic', N'Aquatic', CAST(0x070048F9F66C0000 AS Time), CAST(0x0700B0BD58750000 AS Time), CAST(35.00 AS Numeric(20, 2)), 3, N'Wednesday', CAST(0xD9380B00 AS Date), CAST(0x40380B00 AS Date))
INSERT [dbo].[Classes] ([Class_ID], [Instructor_ID], [Class_Name], [Program], [Location_type], [Start_Time], [End_Time], [Fee], [Age_requirement], [Days_Occuring], [Start_Date], [End_Date]) VALUES (9, 3, N'Mile Loops', N'Fitness', N'Outdoor', CAST(0x070040230E430000 AS Time), CAST(0x0700A8E76F4B0000 AS Time), CAST(0.00 AS Numeric(20, 2)), NULL, N'Monday, Thursday', CAST(0x29380B00 AS Date), CAST(0x62390B00 AS Date))
INSERT [dbo].[Classes] ([Class_ID], [Instructor_ID], [Class_Name], [Program], [Location_type], [Start_Time], [End_Time], [Fee], [Age_requirement], [Days_Occuring], [Start_Date], [End_Date]) VALUES (10, 1, N'Fit Kids Program', N'Fitness', N'Outdoor', CAST(0x0700B4284D8A0000 AS Time), CAST(0x07001CEDAE920000 AS Time), CAST(0.00 AS Numeric(20, 2)), NULL, N'Friday, Saturday, Sunday', CAST(0x4C380B00 AS Date), CAST(0x96380B00 AS Date))
 
 
INSERT [dbo].[Class_Registration] ([Registration_ID], [Community_ID], [Class_ID]) VALUES (1, 1, 2)
INSERT [dbo].[Class_Registration] ([Registration_ID], [Community_ID], [Class_ID]) VALUES (2, 3, 3)
INSERT [dbo].[Class_Registration] ([Registration_ID], [Community_ID], [Class_ID]) VALUES (3, 6, 1)
INSERT [dbo].[Class_Registration] ([Registration_ID], [Community_ID], [Class_ID]) VALUES (4, 3, 8)
INSERT [dbo].[Class_Registration] ([Registration_ID], [Community_ID], [Class_ID]) VALUES (5, 8, 5)
INSERT [dbo].[Class_Registration] ([Registration_ID], [Community_ID], [Class_ID]) VALUES (6, 9, 6)
INSERT [dbo].[Class_Registration] ([Registration_ID], [Community_ID], [Class_ID]) VALUES (7, 6, 7)
INSERT [dbo].[Class_Registration] ([Registration_ID], [Community_ID], [Class_ID]) VALUES (8, 10, 7)
INSERT [dbo].[Class_Registration] ([Registration_ID], [Community_ID], [Class_ID]) VALUES (9, 15, 2)
INSERT [dbo].[Class_Registration] ([Registration_ID], [Community_ID], [Class_ID]) VALUES (10, 8, 10)
INSERT [dbo].[Class_Registration] ([Registration_ID], [Community_ID], [Class_ID]) VALUES (11, 1, 1)
INSERT [dbo].[Class_Registration] ([Registration_ID], [Community_ID], [Class_ID]) VALUES (12, 9, 6)
 
 
INSERT [dbo].[athletic_schedule] ([Game_ID], [Game_Date], [Start_Time], [End_Time], [Location_Type], [Team_1], [Team_2], [Winner], [Team_1_Score], [Team_2_Score]) VALUES (1, CAST(0x6F380B00 AS Date), CAST(0x07002058A3A70000 AS Time), CAST(0x0700BCFE35B40000 AS Time), N'Outdoor', 1, 3, 3, 2, 5)
INSERT [dbo].[athletic_schedule] ([Game_ID], [Game_Date], [Start_Time], [End_Time], [Location_Type], [Team_1], [Team_2], [Winner], [Team_1_Score], [Team_2_Score]) VALUES (2, CAST(0x70380B00 AS Date), CAST(0x070050CFDF960000 AS Time), CAST(0x0700EC7572A30000 AS Time), N'Indoor', 2, 4, 2, 7, 3)
INSERT [dbo].[athletic_schedule] ([Game_ID], [Game_Date], [Start_Time], [End_Time], [Location_Type], [Team_1], [Team_2], [Winner], [Team_1_Score], [Team_2_Score]) VALUES (3, CAST(0x71380B00 AS Date), CAST(0x0700E80A7E8E0000 AS Time), CAST(0x070084B1109B0000 AS Time), N'Indoor', 5, 6, 6, 3, 4)
INSERT [dbo].[athletic_schedule] ([Game_ID], [Game_Date], [Start_Time], [End_Time], [Location_Type], [Team_1], [Team_2], [Winner], [Team_1_Score], [Team_2_Score]) VALUES (4, CAST(0x76380B00 AS Date), CAST(0x070050CFDF960000 AS Time), CAST(0x0700EC7572A30000 AS Time), N'Outdoor', 1, 3, 1, 4, 2)
INSERT [dbo].[athletic_schedule] ([Game_ID], [Game_Date], [Start_Time], [End_Time], [Location_Type], [Team_1], [Team_2], [Winner], [Team_1_Score], [Team_2_Score]) VALUES (5, CAST(0x78380B00 AS Date), CAST(0x07000C41DD3E0000 AS Time), CAST(0x0700A8E76F4B0000 AS Time), N'Outdoor', 1, 3, 3, 2, 3)
INSERT [dbo].[athletic_schedule] ([Game_ID], [Game_Date], [Start_Time], [End_Time], [Location_Type], [Team_1], [Team_2], [Winner], [Team_1_Score], [Team_2_Score]) VALUES (6, CAST(0x79380B00 AS Date), CAST(0x070050CFDF960000 AS Time), CAST(0x0700EC7572A30000 AS Time), N'Indoor', 5, 6, 6, 6, 7)
INSERT [dbo].[athletic_schedule] ([Game_ID], [Game_Date], [Start_Time], [End_Time], [Location_Type], [Team_1], [Team_2], [Winner], [Team_1_Score], [Team_2_Score]) VALUES (7, CAST(0x7E380B00 AS Date), CAST(0x070080461C860000 AS Time), CAST(0x07001CEDAE920000 AS Time), N'Indoor', 2, 4, 2, 1, 8)
INSERT [dbo].[athletic_schedule] ([Game_ID], [Game_Date], [Start_Time], [End_Time], [Location_Type], [Team_1], [Team_2], [Winner], [Team_1_Score], [Team_2_Score]) VALUES (8, CAST(0x7F380B00 AS Date), CAST(0x07002058A3A70000 AS Time), CAST(0x0700BCFE35B40000 AS Time), N'Outdoor', 1, 3, 1, 2, 1)
INSERT [dbo].[athletic_schedule] ([Game_ID], [Game_Date], [Start_Time], [End_Time], [Location_Type], [Team_1], [Team_2], [Winner], [Team_1_Score], [Team_2_Score]) VALUES (9, CAST(0x7F380B00 AS Date), CAST(0x070050CFDF960000 AS Time), CAST(0x0700EC7572A30000 AS Time), N'Indoor', 5, 6, NULL, NULL, NULL)
INSERT [dbo].[athletic_schedule] ([Game_ID], [Game_Date], [Start_Time], [End_Time], [Location_Type], [Team_1], [Team_2], [Winner], [Team_1_Score], [Team_2_Score]) VALUES (10, CAST(0x84380B00 AS Date), CAST(0x07002058A3A70000 AS Time), CAST(0x0700BCFE35B40000 AS Time), N'Outdoor', 1, 3, NULL, NULL, NULL)
 
 
 
INSERT [dbo].[Athletic_Registration] ([Registration_ID], [Community_ID], [Team_ID], [Jersey_Number]) VALUES (1, 1, 1, 3)
INSERT [dbo].[Athletic_Registration] ([Registration_ID], [Community_ID], [Team_ID], [Jersey_Number]) VALUES (2, 4, 1, 4)
INSERT [dbo].[Athletic_Registration] ([Registration_ID], [Community_ID], [Team_ID], [Jersey_Number]) VALUES (3, 2, 2, 14)
INSERT [dbo].[Athletic_Registration] ([Registration_ID], [Community_ID], [Team_ID], [Jersey_Number]) VALUES (4, 5, 2, 5)
INSERT [dbo].[Athletic_Registration] ([Registration_ID], [Community_ID], [Team_ID], [Jersey_Number]) VALUES (5, 13, 3, 56)
INSERT [dbo].[Athletic_Registration] ([Registration_ID], [Community_ID], [Team_ID], [Jersey_Number]) VALUES (6, 14, 3, 22)
INSERT [dbo].[Athletic_Registration] ([Registration_ID], [Community_ID], [Team_ID], [Jersey_Number]) VALUES (7, 10, 4, 3)
INSERT [dbo].[Athletic_Registration] ([Registration_ID], [Community_ID], [Team_ID], [Jersey_Number]) VALUES (8, 12, 4, 65)
INSERT [dbo].[Athletic_Registration] ([Registration_ID], [Community_ID], [Team_ID], [Jersey_Number]) VALUES (9, 7, 5, 23)
INSERT [dbo].[Athletic_Registration] ([Registration_ID], [Community_ID], [Team_ID], [Jersey_Number]) VALUES (10, 6, 5, 12)
INSERT [dbo].[Athletic_Registration] ([Registration_ID], [Community_ID], [Team_ID], [Jersey_Number]) VALUES (11, 11, 6, 8)
INSERT [dbo].[Athletic_Registration] ([Registration_ID], [Community_ID], [Team_ID], [Jersey_Number]) VALUES (12, 4, 6, 32)
 
 
INSERT [dbo].[Aquatic_Classes] ([Class_ID], [Location_Type], [Pool_Name]) VALUES (1, N'Aquatic', N'Valley Pool')
INSERT [dbo].[Aquatic_Classes] ([Class_ID], [Location_Type], [Pool_Name]) VALUES (6, N'Aquatic', N'Burnet Pool')
INSERT [dbo].[Aquatic_Classes] ([Class_ID], [Location_Type], [Pool_Name]) VALUES (8, N'Aquatic', N'Schiller Park Pool')
 
 
INSERT [dbo].[Outdoor_Classes] ([Class_ID], [Location_Type], [Park], [Area]) VALUES (3, N'Outdoor', N'Faldo Park', N'Track')
INSERT [dbo].[Outdoor_Classes] ([Class_ID], [Location_Type], [Park], [Area]) VALUES (4, N'Outdoor', N'Clinton Square', N'Square')
INSERT [dbo].[Outdoor_Classes] ([Class_ID], [Location_Type], [Park], [Area]) VALUES (7, N'Outdoor', N'Onondaga Park', N'Southern Field')
INSERT [dbo].[Outdoor_Classes] ([Class_ID], [Location_Type], [Park], [Area]) VALUES (9, N'Outdoor', N'Faldo Park', N'Track')
INSERT [dbo].[Outdoor_Classes] ([Class_ID], [Location_Type], [Park], [Area]) VALUES (10, N'Outdoor', N'Faldo Park', N'Track')
 
 
INSERT [dbo].[Indoor_Classes] ([Class_ID], [Location_Type], [Community_Center]) VALUES (2, N'Indoor', N'Bob Cecile Community Center')
INSERT [dbo].[Indoor_Classes] ([Class_ID], [Location_Type], [Community_Center]) VALUES (5, N'Indoor', N'Westside Senior Center')
 
 
INSERT [dbo].[Outdoor_Sports_Schedule] ([Game_ID], [Location_Type], [Park_Name], [Area]) VALUES (1, N'Outdoor', N'Barry Park', N'NW Field')
INSERT [dbo].[Outdoor_Sports_Schedule] ([Game_ID], [Location_Type], [Park_Name], [Area]) VALUES (5, N'Outdoor', N'Faldo Park', N'SE Field')
INSERT [dbo].[Outdoor_Sports_Schedule] ([Game_ID], [Location_Type], [Park_Name], [Area]) VALUES (8, N'Outdoor', N'Faldo Park', N'Central Field')
INSERT [dbo].[Outdoor_Sports_Schedule] ([Game_ID], [Location_Type], [Park_Name], [Area]) VALUES (10, N'Outdoor', N'Onondaga Park', N'North Field')
 
 
INSERT [dbo].[Indoor_Sports_Schedule] ([Game_ID], [Location_Type], [Community_Center]) VALUES (2, N'Indoor', N'Seals Community Center')
INSERT [dbo].[Indoor_Sports_Schedule] ([Game_ID], [Location_Type], [Community_Center]) VALUES (3, N'Indoor', N'Northeast Community Center')
INSERT [dbo].[Indoor_Sports_Schedule] ([Game_ID], [Location_Type], [Community_Center]) VALUES (6, N'Indoor', N'Bob Cecile Community Center')
INSERT [dbo].[Indoor_Sports_Schedule] ([Game_ID], [Location_Type], [Community_Center]) VALUES (7, N'Indoor', N'Cannon Street Community Center')
INSERT [dbo].[Indoor_Sports_Schedule] ([Game_ID], [Location_Type], [Community_Center]) VALUES (9, N'Indoor', N'Bob Cecile Community Center')








select * from Athletic_Schedule

select * from Classes c where c.start_date <= '2014-04-30' and c.end_date >= '2014-04-30';

select * from Class_Registration

select * from Outdoor_Classes;

select * from Indoor_Classes;

select * from Aquatic_Classes;

select * from Instructors;

select * from Community_Members;

select * from Athletic_Registration;

select * from Parks;

select * from Community_Centers;

select * from Pools;

select * from Indoor_Sports_Schedule;
select * from Outdoor_Sports_Schedule;
select * from Athletic_Registration;
select * from Teams;
select * from Athletic_Schedule;


--This query allows you to see what classes are happening in all parks, community centers, and pools every day
create view Class_Schedule as
select c.Class_ID, c.Class_Name, c.Start_Time, c.End_Time, a.pool_name, o.park, i.community_center
from classes c
left join Aquatic_Classes a
on c.Class_ID=a.Class_ID
left join Indoor_Classes i
on i.Class_ID = c.Class_ID
left join outdoor_classes o
on o.Class_ID = c.Class_ID
where '2014-04-01'  between Start_Date and end_date--replace getdate with the date you're looking for
and Days_Occuring like (select datename(dw, '2014-04-01'))--replace getdate with the date you're looking for


--This query allows one to see what athletic events are happening on a specific day
select a_s.Game_Date, a_s.Start_time, a_s.end_time, a_s.Team_1, a_s.team_2, o.park_name, i.community_center
from athletic_schedule a_s
left join indoor_sports_schedule i
on a_s.game_ID=i.game_ID
left join outdoor_sports_schedule o
on o.game_ID=a_s.game_ID
where game_date = ('2014-04-21')--replace the date in parenthesis with whatever date you're looking for

--This query allows you to input a specific date and park name to see what sports are happening in that park
--on that date
create view specific_outdoor_athletic_schedule as
select a_s.Game_Date, a_s.Start_time, a_s.end_time, a_s.Team_1, a_s.team_2, o.park_name
from athletic_schedule a_s
left join outdoor_sports_schedule o
on o.game_ID=a_s.game_ID
where game_date = ('2014-05-07')--replace the date in parenthesis with whatever date you're looking for
and o.park_name='Faldo Park'--replace this park with any other park


--This query allows you to input a specific date and community center to see what sports are happening in that
--community center on that date
create view specific_indoor_athletic_schedule as
select a_s.Game_Date, a_s.Start_time, a_s.end_time, a_s.Team_1, a_s.team_2, i.community_center
from athletic_schedule a_s
left join indoor_sports_schedule 
on a_s.game_ID=i.game_ID
where game_date = ('2014-05-07')--replace the date in parenthesis with whatever date you're looking for
and i.community_center='Bob Cecile Community Center'--replace this with any other community center


--This view allows one to see what's happening in a specific pool on a specific day
create view specific_pool_Schedule as
select c.Class_ID, c.Class_Name, c.Start_Time, c.End_Time, a.pool_name
from classes c
left join Aquatic_Classes a
on c.Class_ID=a.Class_ID
where '2014-04-23' between Start_Date and end_date--replace the date with the date you're looking for
and Days_Occuring like (select datename(dw, '2014-04-23'))--replace getdate with the date you're looking for
and a.Pool_Name='Valley Pool'--replace Valley Pool with any other pool



--This view allows one to see what's happening in a specific park on a specific day
create view specific_park_schedule as
select c.Class_ID, c.Class_Name, c.Start_Time, c.End_Time,o.park
from classes c
left join outdoor_classes o
on o.Class_ID = c.Class_ID
where '2014-04-15' between Start_Date and end_date--replace getdate with the date you're looking for
and Days_Occuring like (select datename(dw, '2014-04-15'))--replace getdate with the date you're looking for
and o.Park='Clinton Square'--replace Clinton Square with any park

--This view allows one to see what's happening in a specific community center on a specific day
create view specific_community_center_schedule as
select c.Class_ID, c.Class_Name, c.Start_Time, c.End_Time,i.community_center
from classes c
left join Indoor_Classes i
on i.Class_ID = c.Class_ID
where '2014-07-02' between Start_Date and end_date--replace getdate with the date you're looking for
and Days_Occuring like (select datename(dw, '2014-05-07'))--replace getdate with the date you're looking for
and i.Community_Center='Bob Cecile Community Center'



---This view allows one to see how much revenue a specific class, in this case ‘Little Swimmers’ has made on a specific year (in the case below,’2014’, we define a class in 2014 as it starts after '2014-01-01' and before '2014-12-31') 
create view specificClass_Revenue_specificYear as 
select c.Class_Name, (COUNT(cr.Community_ID)*c.Fee) as 'Revenue' from Classes c, Class_Registration cr where c.Class_ID = cr.Class_ID and c.Class_Name = 'Little Swimmers' and c.start_date >= '2014-01-01' and c.start_date <= '2014-12-31' group by c.Class_Name, c.Fee;
select * from class_Revenue_specificYear;

-----The query allow one to order the classes by the revenues they have made
create view class_Revenue_Order as
select c.Class_Name, (COUNT(cr.Community_ID)*c.Fee) as 'Revenue' from Classes c, Class_Registration cr where c.Class_ID = cr.Class_ID and c.start_date >= '2014-01-01' and c.start_date <= '2014-12-31' group by c.Class_Name, c.Fee;
 --order by 'Revenue' desc
 
-------What are the most popular types of classes in 2014-------
create view class_Registration_records_specificYear as 
select c.Class_Name, COUNT(cr.Community_ID) as 'Registration records count' from Classes c, Class_Registration cr where c.Class_ID = cr.Class_ID and c.start_date >= '2014-01-01' and c.start_date <= '2014-12-31' group by c.Class_ID, c.Class_Name;

-------What are the best athletic teams in 2014-------
create view winningTimes_Team_specificYear as
select t.Team_ID, t.Team_Name, sum(a.Winner) as 'WinningTimes' from Teams t, Athletic_Schedule a where t.Team_ID = a.Winner and a.Game_Date >= '2014-01-01' and a.Game_Date <= '2014-12-31' group by t.Team_ID, t.Team_Name;

drop view winningTimes_Team_specificYear;


--The following queries will show what teams are available on each day of the week
--these views make it easy to see who can play against each other when utilized in Access
 
create view Monday_Availability as
select team_ID,Team_Name,League,sport
from Teams
where Nights_able_to_Play like '%Monday%'
 
create view Tuesday_Availability as
select team_ID,Team_Name,League,sport
from Teams
where Nights_able_to_Play like '%Tuesday%'
 
 
create view Wednesday_Availability as
select team_ID,Team_Name,League,sport
from Teams
where Nights_able_to_Play like '%Wednesday%'
 
 
create view Thursday_Availability as
select team_ID,Team_Name,League,sport
from Teams
where Nights_able_to_Play like '%Thursday%'
 
 
create view Friday_Availability as
select team_ID,Team_Name,League,sport
from Teams
where Nights_able_to_Play like '%Friday%'
 
 
create view Saturday_Availability as
select team_ID,Team_Name,League,sport
from Teams
where Nights_able_to_Play like '%Saturday%'
 
create view Sunday_Availability as
select team_ID,Team_Name,League,sport
from Teams
where Nights_able_to_Play like '%Sunday%'
select * from Monday_Availability;
select * from Tuesday_Availability;

----Create a view which contains the Class_ID, the total occurence time of each class and the information of the occuring days each week
create view Class_Occurence_View as
select c.Class_ID, datediff(day, c.Start_Date, c.End_Date)/7*(SELECT (LEN(c.Days_Occuring) - LEN(REPLACE(c.Days_Occuring, 'day', ''))) / LEN('day')) as 'ClassOccurenceTimes', p.Park_Name from Classes c, Outdoor_Classes oc, Parks p where c.Class_ID = oc.Class_ID and c.start_date >= '2014-01-01' and c.start_date <= '2014-12-31' and p.Park_Name = oc.Park;
select * from Class_Occurence_View;

-----Create the second view based on Class_Occurence_View that would display the total occuring times of classes on each park
create view Classes_Parks as
select cov.Park_Name, sum(ClassOccurenceTimes) as 'TotalClassTimes' from Class_Occurence_View cov group by cov.Park_Name;
select * from Classes_Parks;

-----Create a view that displays the total times of Games occurence in each park
create view Games_Parks as
select p.Park_Name, COUNT(distinct os.Game_ID) as 'GamesHappeningTimes' from Parks p, Athletic_Schedule a, Outdoor_Sports_Schedule os where a.Game_ID=os.Game_ID and a.Game_Date >= '2014-01-01' and a.Game_Date <= '2014-12-31' and os.Park_Name = p.Park_Name group by p.Park_Name;
select * from Games_Parks;

-----Full join Classes_Parks view and Games_Parks view to find all the count of class happenings and game happening on every park (we do the full join because sometimes some parks only have athletic games and no classes and vice versa)
select * from Games_Parks full join Classes_Parks on Games_Parks.Park_Name = Classes_Parks.Park_Name;       