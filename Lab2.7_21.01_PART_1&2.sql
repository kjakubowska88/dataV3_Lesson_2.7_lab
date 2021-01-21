use sakila; 
-- Part 1--

drop table if exists films_2020;

CREATE TABLE `films_2020` (
  `film_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text,
  `release_year` year(4) DEFAULT NULL,
  `language_id` tinyint(3) unsigned NOT NULL,
  `original_language_id` tinyint(3) unsigned DEFAULT NULL,
  `rental_duration` int(6),
  `rental_rate` decimal(4,2),
  `length` smallint(5) unsigned DEFAULT NULL,
  `replacement_cost` decimal(5,2) DEFAULT NULL,
  `rating` enum('G','PG','PG-13','R','NC-17') DEFAULT NULL,
  PRIMARY KEY (`film_id`),
  CONSTRAINT FOREIGN KEY (`original_language_id`) REFERENCES `language` (`language_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1003 DEFAULT CHARSET=utf8;


show variables like 'local_infile';
set global local_infile = 1;
set global local_infile=true;


load data local infile 'C:/Users/zdepptana/IRON_HACK_2week/Day_9/dataV3_Lesson_2.7_lab/files_for_part1/films_2020.csv'
into table films_2020
fields terminated by ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(film_id,title,description,release_year,language_id,original_language_id,rental_duration,rental_rate,length,replacement_cost,rating);


show global variables like 'local_infile';
select * from films_2020;


update films_2020 set rental_duration = 3, rental_rate = 2.99, replacement_cost = 8.99;

select * from films_2020;

-- Part 2 --
-- 1-- 

select last_name as unique_names, COUNT(last_name) AS times from actor
group by last_name having times = 1;

-- 2
select last_name as Last_name, count(last_name) as Count from actor
group by last_name
having count(last_name) > 1 
order by count(last_name) ASC;

-- 3
select staff_id, count(*) As rental_amount from rental
group by staff_id
Order by rental_amount DESC;

-- 4
select release_year, count(*) as films from film
group by release_year
order by release_year ASC;

-- 5
select rating, count(*) as num_films from film
group by rating
order by rating ASC ;

-- 6
select rating, round(avg(length),2) as avg_duration from film
group by rating
order by avg_duration desc;

-- 7
select rating, round(avg(length),2) as avg_duration from sakila.film
group by rating
having avg_duration > 120
order by avg_duration desc;

