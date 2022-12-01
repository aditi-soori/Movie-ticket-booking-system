--
-- NAME:ADITI SOORI
--SRN:PES1UG20CS017

-- --------------------------------------------------------

--
-- 
--
drop database movie_booking_system;
create database movie_booking_system;
use movie_booking_system;


SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";
--
-- Database: `Movie_Management_System`
--

-- --------------------------------------------------------

--
-- Table structure for table `theatre`
--

CREATE TABLE `theatre` (
  `theatre_id` varchar(10) NOT NULL,
  `theatre_name` varchar(50) NOT NULL,
  `theatre_address` varchar(75) NOT NULL,
  `total_halls` int(4) NOT NULL,
   Primary Key(`theatre_id`) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
--
-- Dumping data for table `theatre`
--

INSERT INTO `theatre` (`theatre_id`,  `theatre_name`, `theatre_address`, `total_halls`) VALUES
('T01', 'PVR Cinemas','Koramangala, Bangalore',15),
('T02', 'INOX Movies', 'Jayanagar, Bangalore',25),
('T03', 'Cinepolis', 'Banaswadi, Bangalore',10),
('T04', 'IMAX Cinemas', 'Malleshwaram, Bangalore',20);
-- --------------------------------------------------------
--
-- Table structure for table `hall`
--

CREATE TABLE `hall` (
  `hall_id` varchar(10) NOT NULL,
  `theatre_id` varchar(10) NOT NULL,
  `classic_seat_no` int(11) NOT NULL,
  `premium_seat_no` int(11) NOT NULL,
  `recliner_seat_no` int(11) NOT NULL,
   Primary Key(`hall_id`),
   Foreign Key(`theatre_id`) REFERENCES `theatre`(`theatre_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
--
-- Dumping data for table `hall`
--

INSERT INTO `hall` (`hall_id`,  `theatre_id`, `classic_seat_no`, `premium_seat_no`,`recliner_seat_no`) VALUES
('T010','T03',80,20,10),
('T014','T01',60,10,15),
('T020','T04',75,35,5),
('T022','T02',60,30,15),
('T006','T03',69,18,12),
('T023','T02',78,20,10),
('T015','T01',92,12,8),
('T012','T04',56,30,15),
('T008','T03',43,40,16),
('T003','T04',81,20,12),
('T021','T02',72,15,20);
-- --------------------------------------------------------
--
-- Table structure for table `movie`
--

CREATE TABLE `movie` (
  `movie_id` varchar(10) NOT NULL,
  `movie_name` varchar(100) NOT NULL,
  `language` varchar(50) NOT NULL,
  `genre` varchar(20),
  `duration` varchar(45) NOT NULL,
   `pg_rating` varchar(5) NOT NULL,
     Primary Key(`movie_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
--
-- Dumping data for table `movie`
--

INSERT INTO `movie` (`movie_id`,`movie_name`,`language`,`genre`,`duration`,`pg_rating`) VALUES
('001', 'Hichki', 'Hindi','Drama/Comedy','2 hrs 15 mins','U/A'),
('002', 'Pacific Rim Uprising',  'English','Fantasy/SciFi','1 hrs 55 mins','U/A'),
('003', 'Strangers : Prey at night','English', 'Horror','3 hrs 10 mins', 'U/A'),
('004', 'Tomb Raider', 'English','Fantasy/Action','3 hrs 15 mins', 'A'),
('005', 'Midnight Sun', 'English','Romance','2 hrs 55 mins','R'),
('006', 'Peter Rabbit','English', 'Fantasy/Adventure','2 hrs 35 mins','U/A'),
('007', 'Black Panther','English', 'Fantasy/SciFi','2 hrs 15 mins','U/A'),
('008', 'Maze Runner: The Death Cure','English', 'Fantasy/SciFi','2 hrs 45 mins','U/A'),
('009', 'Insidious: The Last Key','English', 'Horror','2 hrs 20 mins','U/A'),
('010', 'Blackmail','Hindi', 'Comedy','1 hrs 55 mins','U/A'),
('011', 'Parmanu: The Story of Pokhran','Hindi', 'Drama/Thriller','3 hrs 10 mins','U/A'),
('012', '3 Storeys','Hindi', 'Drama','1 hrs 45 mins','U/A'),
('013', 'Rajaratha','Kannada', 'Comedy','2 hrs 45 mins','U/A'),
('014', 'Yogi Duniya','Kannada', 'Drama/Thriller','3 hrs 10 mins','U/A'),
('015', 'Kurukshetra','Kannada', 'Fantasy/History','1 hrs 45 mins','U/A'),
('016', 'Kantara','Kannada','Drama/Thriller','2 hrs 30 mins','U/A');
--
-- Table structure for table `show`
--

CREATE TABLE `show` (
  `show_id` varchar(10) NOT NULL,
  `hall_id` varchar(10) NOT NULL,
  `movie_id` varchar(10) NOT NULL,
  `start_time` time DEFAULT NULL,
  `date` date DEFAULT NULL,
  `classic_remaining` int NOT NULL CHECK (`classic_remaining` >= 0),
  `premium_remaining` int NOT NULL CHECK (`premium_remaining` >= 0), 
  `recliner_remaining` int NOT NULL CHECK (`recliner_remaining` >= 0),
  `classic_cost` int NOT NULL,
  `premium_cost` int NOT NULL,
  `recliner_cost` int NOT NULL,
    Primary Key(`show_id`),
   Foreign Key(`hall_id`) REFERENCES `hall`(`hall_id`) ON DELETE CASCADE ON UPDATE CASCADE,
   Foreign Key(`movie_id`) REFERENCES `movie`(`movie_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
--
-- Dumping data for table `show`
--

INSERT INTO `show` VALUES
('SHT0140002', 'T014', '015','04:20:00 ', '2022-11-05', 4, 5,12, 300, 450,575),
('SHT0210002',  'T021', '016','04:20:00', '2022-11-08', 22, 8,10, 395, 425,500),
('SHT0220002', 'T022', '001','04:20:00', '2022-11-15', 8, 5,3, 300, 375,450),
('SHT0230002',  'T023', '002','04:20:00 ', '2022-11-25', 40,16,8,295, 355,415),
('SHT0240002',  'T020', '003','04:20:00 ', '2022-11-05', 20,10,2, 395, 325,495),
('SHT0310002', 'T008', '004', '04:20:00 ', '2022-11-21', 35,10,5, 325, 350,400),
('SHT0320002', 'T012', '005', '04:20:00', '2022-11-12', 10,8,2, 315, 375,425),
('SHT0330002', 'T003', '006','04:20:00 ', '2022-11-11', 21,15,1, 425, 450,500),
('SHT0110003', 'T010', '007','07:30:00 ', '2022-11-01', 3,12,8, 400,475, 550),
('SHT0120003', 'T006', '008', '07:30:00', '2022-11-04', 17,6,8, 275, 315,400);
--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` varchar(15) NOT NULL,
  `user_name` varchar(100) NOT NULL,
  `email_id` varchar(50) NOT NULL,
   `phone` varchar(10) NOT NULL,
   Primary Key(`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
--
-- Dumping data for table `user`
--

INSERT INTO `user` VALUES
('100', 'Amit',  'amitsinhT04@gmail.com', '9846273634'),
('101', 'Raghav', 'seth.raghav987@gmail.com','7845279834'),
('102', 'Anjali',  'anjali23g@gmail.com', '8849273345'),
('103', 'Joy', 'jmathew.123@gmail.com',  '9000567890'),
('104', 'Sudha',  'sudha_sunil07@gmail.com',  '8874323461'),
('105', 'Ajay',  'kumarajayv56@gmail.com',  '9078985643'),
('106', 'Vikram',  'jvikram.89@gmail.com', '7750912345'),
('107', 'Komal',  'komal.agarwal87@gmail.com',  '9345687654'),
('108', 'Maitri',  'maitrishahj1@gmail.com',  '9922345016'),
('109', 'Bhavya',  'bhavyashastri@gmail.com',  '8567409098'),
('110', 'Preeti',  'preeti.jain@gmail.com',  '7765433211'),
('111',	'Shreya', 'rathod_shreya@gmail.com','9800215673'),
('112',	'Aditya', 'adityarajesh2902@gmail.com','9108996762');

--
--
-- Table structure for table `booking`
--

CREATE TABLE `booking` (
  `booking_id` varchar(10) NOT NULL,
  `show_id` varchar(10) NOT NULL,
  `no_of_tickets` int(50) NOT NULL,
  `userbook_id` varchar(10) NOT NULL,
   Foreign Key(`userbook_id`) REFERENCES `user`(`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
   Foreign Key(`show_id`) REFERENCES `show`(`show_id`) ON DELETE CASCADE ON UPDATE CASCADE,
    Primary Key(`booking_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
--
-- Dumping data for table `booking`
--
INSERT INTO `booking` VALUES
('B001','SHT0140002',2,'100'),
('B003','SHT0220002',1,'105'),
('B004','SHT0310002',3,'102'),
('B005','SHT0330002',2,'103'),
('B006','SHT0110003',4,'101'),
('B007','SHT0220002',1,'106'),
('B008','SHT0120003',3,'107'),
('B009','SHT0110003',4,'111'),
('B010','SHT0240002',2,'112'),
('B011','SHT0140002',1,'110');
--
-- Table structure for table `ticket`
--

CREATE TABLE `ticket` (
  `ticket_id` varchar(10) NOT NULL,
   `booking_id` varchar(10) NOT NULL,
  `type` varchar(50) NOT NULL,
  `total_price` int NOT NULL,
   Primary Key(`ticket_id`),
   Foreign Key(`booking_id`) REFERENCES `booking`(`booking_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
--
-- Dumping data for table `ticket`
--
INSERT INTO `ticket` VALUES
('T100','B001','classic',300),
('T102','B003','premium',350),
('T103','B004','recliner',315),
('T104','B005','classic',275),
('T105','B006','classic',395),
('T106','B007','premium',315),
('T107','B008','premium',325),
('T108','B009','premium',450),
('T109','B010','recliner',495),
('T110','B004','recliner',500);
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--
-- JOIN QUERIES
--
/*1*/
SELECT
    theatre.theatre_name,
    hall.hall_id,
    (
        hall.classic_seat_no + hall.premium_seat_no + hall.recliner_seat_no
    ) AS total_seats
FROM
    theatre
JOIN hall WHERE theatre.theatre_id = hall.theatre_id;
/*2*/
SELECT
    movie.movie_name,`show`.start_time
FROM
    movie
NATURAL JOIN `show`
    ;
/*3*/
SELECT
    *
FROM
    total
NATURAL JOIN booked WHERE total_remaining < total_seats
/*4*/
SELECT
    user_name
FROM
    `user`
JOIN booking WHERE no_of_tickets = 1 AND `user`.user_id = `booking`.`userbook_id`;
--
-- AGGREGATE FUNCTIONS
--
/*1*/

SELECT
    COUNT(ticket_id)
FROM
    ticket
WHERE TYPE
    = 'premium';

/*2*/
CREATE VIEW most_sales_made AS(
    SELECT
        theatre.theatre_name,
        COUNT(ticket_id) AS ticket_sales
    FROM
        theatre,
        ticket,
        `show`,
        `booking`,
        hall
    WHERE
        theatre.theatre_id = hall.theatre_id AND `show`.hall_id = hall.hall_id AND `show`.show_id = booking.show_id AND ticket.booking_id = booking.booking_id AND `show`.`date` = '2022-11-11'
    GROUP BY
        theatre.theatre_name
);
SELECT
    theatre_name,
    ticket_sales
FROM
    most_sales_made
WHERE
    ticket_sales =(
    SELECT
        MAX(ticket_sales)
    FROM
        most_sales_made
);
/*3*/

SELECT
    AVG(total_price)
FROM
    ticket;

/*4*/
SELECT
    COUNT(*)
FROM
    movie
WHERE
    movie.language = 'English'
/*5*/
CREATE VIEW blockbuster_movie AS(
    SELECT
        (m.movie_name) AS name_of_movie,
        COUNT(b.booking_id) AS no_of_bookings
    FROM
        booking AS b,
        `show` AS s,
        movie AS m
    WHERE
        s.show_id = b.show_id AND m.movie_id = s.movie_id
    GROUP BY
        m.movie_name
);
SELECT
    name_of_movie AS blockbuster_movie_of_the_day
FROM
    blockbuster_movie
WHERE
    no_of_bookings =(
    SELECT
        MAX(no_of_bookings)
    FROM
        blockbuster_movie
);
--
-- SET OPERATIONS
--
/*1*/
SELECT
    movie_name,language
FROM
    movie
WHERE
    movie.language = 'English'
UNION
SELECT
     movie_name,language
FROM
    movie
WHERE
    movie.language = 'Kannada';
/*2*/
SELECT
    movie_name
FROM
    movie
WHERE
    pg_rating = 'U/A'
UNION ALL
SELECT
    movie_name
FROM
    movie
WHERE
    genre = 'Drama/Thriller'
ORDER BY movie_name;

/*3*/
SELECT
    user_name,
    booking.userbook_id
FROM
    `user`,
    booking
WHERE
    `user`.user_id = booking.userbook_id AND EXISTS(
    SELECT
        booking.userbook_id
    FROM
        booking
    WHERE
        no_of_tickets > 2
);

/*4*/
SELECT
    theatre_name,
    hall. classic_seat_no
FROM
    theatre,
    hall
WHERE
    theatre.theatre_id = hall.theatre_id OR classic_seat_no < 85 AND NOT EXISTS(
    SELECT
        hall. classic_seat_no
    FROM
        hall
    WHERE
        classic_seat_no > 40
);
--
-- FUNCTIONS AND PROCEDURES
--
/*PROCEDURE*/
DELIMITER
    $$
CREATE PROCEDURE select_movie_using_language(IN LANGUAGE VARCHAR(10))
BEGIN
    SELECT 
        *
    FROM
        movie
    WHERE
        movie.language = LANGUAGE ;
END $$
DELIMITER
    ;
/*FUNCTION*/
DELIMITER $$
CREATE FUNCTION totalseatsbooked
(show_id varchar(10))
RETURNS INT(10)
BEGIN
	DECLARE seats INT(10);
    select DIFFERENCE(total.total_seats - booked.total_remaining) into seats
    from booked,total
    where total.show_id=booked.show_id;
    RETURN seats;
END
$$
DELIMITER;


--
-- TRIGGERS AND CURSORS
--


/*TRIGGER*/
DELIMITER
    $$
CREATE TRIGGER seatsfull BEFORE INSERT ON
    `show` FOR EACH ROW
BEGIN
    DECLARE
        error_msg VARCHAR(255) ; DECLARE seat INT ;
    SET
        error_msg =(" SEATS ARE FULL") ;
    SELECT SUM(
            new.`classic_remaining` + new.`premium_remaining` + new.`recliner_remaining`
        ) INTO seat FROM `show`; IF seat = 0 THEN SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT
        = error_msg ;
END IF ;
END $$
DELIMITER
    ;
/*CURSOR*/
DELIMITER $$
CREATE PROCEDURE createPhoneList (
	INOUT phoneList varchar(4000)
)
BEGIN
	DECLARE finished INTEGER DEFAULT 0;
	DECLARE phoneno varchar(100) DEFAULT "";

	-- declare cursor for user phone
	DEClARE cur_phone 
		CURSOR FOR 
			SELECT phone FROM `user`;

	-- declare NOT FOUND handler
	DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET finished = 1;

	OPEN cur_phone;

	getPhone: LOOP
		FETCH cur_phone INTO phoneno;
		IF finished = 1 THEN 
			LEAVE getPhone;
		END IF;
		-- build phone list
		SET phoneList = CONCAT(phoneno,";",phoneList);
	END LOOP getPhone;
	CLOSE cur_phone;

END$$
DELIMITER ;

------------------------------------------------------------------------------------------