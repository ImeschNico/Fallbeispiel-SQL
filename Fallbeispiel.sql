-- Erstellen der Datenbank
CREATE DATABASE kino;

USE kino;

-- Tabellen erstellen
CREATE TABLE movies(
movie_id INT AUTO_INCREMENT PRIMARY KEY,
title VARCHAR(100),
genre VARCHAR(100),
duration INT -- Dauer des Films
);

CREATE TABLE rooms(
rooms_id INT AUTO_INCREMENT PRIMARY KEY,
room_name VARCHAR(50),
seats INT
);

CREATE TABLE customer(
customer_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(30),
e_mail VARCHAR(60) UNIQUE
);

CREATE TABLE tickets(
tickets_id INT AUTO_INCREMENT PRIMARY KEY,
customer_id INT,
movie_id INT,
rooms_id INT,
seats INT,
price INT
);

-- Foreign Key setzten
SET FOREIGN_KEY_CHECKS = 0;

ALTER TABLE tickets
ADD CONSTRAINT fk_customer_tickets 
FOREIGN KEY (customer_id)
REFERENCES customer(customer_id);

ALTER TABLE tickets
ADD CONSTRAINT fk_movie_tickets 
FOREIGN KEY (movie_id)
REFERENCES movies(movie_id);

ALTER TABLE tickets
ADD CONSTRAINT fk_rooms_tickets
FOREIGN KEY (rooms_id)
REFERENCES rooms(rooms_id);

-- KI generierte Daten einfügen
INSERT INTO movies (title, genre, duration)
VALUES
('The Great Adventure', 'Action', 120),
('Romantic Nights', 'Romance', 95),
('Space Journey', 'Science Fiction', 140),
('Comedy Central', 'Comedy', 110),
('The Lost Kingdom', 'Adventure', 130);

INSERT INTO rooms (room_name, seats)
VALUES
('Room 1', 150),
('Room 2', 120),
('Room 3', 100),
('Room 4', 180),
('Room 5', 200);

INSERT INTO customer (name, e_mail)
VALUES
('John Doe', 'john.doe@example.com'),
('Jane Smith', 'jane.smith@example.com'),
('Max Mustermann', 'max.mustermann@example.com'),
('Sarah Miller', 'sarah.miller@example.com'),
('James Brown', 'james.brown@example.com');

INSERT INTO tickets (customer_id, movie_id, rooms_id, seats, price)
VALUES
(1, 1, 1, 2, 20),  -- John Doe, The Great Adventure, Room 1, 2 seats, 20 Euro
(2, 2, 2, 1, 15),  -- Jane Smith, Romantic Nights, Room 2, 1 seat, 15 Euro
(3, 3, 3, 4, 25),  -- Max Mustermann, Space Journey, Room 3, 4 seats, 25 Euro
(4, 4, 4, 3, 18),  -- Sarah Miller, Comedy Central, Room 4, 3 seats, 18 Euro
(5, 5, 5, 2, 22);  -- James Brown, The Lost Kingdom, Room 5, 2 seats, 22 Euro

SET FOREIGN_KEY_CHECKS = 1;

-- Abfragen
-- wer hat Tickets zu Film The Great Adventure gekauft
SELECT  tickets.customer_id, customer.name, movies.title 
FROM tickets
INNER JOIN customer ON customer.customer_id = tickets.customer_id
INNER JOIN movies ON tickets.movie_id = movies.movie_id
WHERE title Like  "The Great%";

-- Wie viele Sitzplätze wurden insgesamt für „Space Journey“ verkauft
SELECT movies.title, tickets.seats
FROM movies
INNER JOIN tickets ON tickets.movie_id = movies.movie_id
WHERE movies.title LIKE "Space%";

-- Mit welchem Film wurde wie viel Umsatz wurde gemacht
SELECT movies.title AS Film, SUM(tickets.price) AS Umsatz
FROM tickets
INNER JOIN movies ON tickets.movie_id = movies.movie_id
GROUP BY movies.title
ORDER BY Umsatz DESC;

-- Welcher Film wird in welchem Saal gezeigt
SELECT movies.title AS Film, rooms.room_name AS Saal
FROM movies
INNER JOIN tickets ON movies.movie_id = tickets.movie_id
INNER JOIN rooms ON tickets.rooms_id = rooms.rooms_id;



