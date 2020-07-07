use books;
select * from ratings; #b
select * from book_name;   #c
select * from users;   #a

# Recommend top 10 books based on ratings
SELECT 
    a.users_id, a.book_rating, b.book_title
FROM
    ratings a,
    books b
WHERE
    a.isbn = b.isbn
ORDER BY a.book_rating desc limit 10;

# Not Recommend least 10 books based on ratings

SELECT 
    a.book_rating, b.book_title
FROM
    ratings a,
    books b
WHERE
    a.isbn = b.isbn
ORDER BY a.book_rating
LIMIT 10;

# Recommend the latest published books

SELECT 
    *
FROM
    books
WHERE
    Year_Of_Publication
ORDER BY Year_Of_Publication DESC;


# Recommend Top 5 books highest rating by maximum user

SELECT 
    SUM(a.book_rating) AS Total_sum_Ratings,
    a.isbn,
    COUNT(a.users_id) AS Total_users,
    b.book_title
FROM
    ratings a,
    books b
WHERE
    a.isbn = b.isbn
GROUP BY a.isbn
ORDER BY SUM(a.book_rating) DESC
LIMIT 5;

# higest rated books by maximum users for each year

SELECT 
    SUM(a.book_rating) AS Total_ratings,
    COUNT(a.users_id) AS Total_users,
    b.year_of_publication,
    b.book_title
FROM
    ratings a,
    book_name b
WHERE
    a.isbn = b.isbn
GROUP BY b.year_of_publication
ORDER BY SUM(a.book_rating) DESC;

select distinct(year_of_publication) from books order by year_of_publication desc;   #crosscheck

#location wise most popular book

SELECT 
    a.location,
    b.isbn,
    SUM(b.book_rating) as Total_rating,
    c.book_title,
    c.year_of_publication
FROM
    users a,
    ratings b,
    book_name c
WHERE
    a.user_id = b.users_id
        AND b.isbn = c.isbn
GROUP BY a.location
ORDER BY SUM(b.book_rating) DESC;

#Separating users on the basis of age (location wise)

SELECT 
    location,
    sum(CASE
        WHEN age BETWEEN 0 AND 18 THEN 1
        ELSE 0
    END) AS Child,
    SUM(CASE
        WHEN age BETWEEN 19 AND 49 THEN 1
        ELSE 0
    END) AS Young,
    SUM(CASE
        WHEN age > 50 THEN 1
        ELSE 0
    END) AS Old
FROM
    users
GROUP BY location;
 
 select * from users where location='stockton'; 

#most liked publisher

SELECT 
    publisher, COUNT(publisher) AS No_of_books_published
FROM
    book_name
GROUP BY publisher
ORDER BY COUNT(publisher) DESC
LIMIT 1;

select * from book_name where  publisher='Ballantine Books';

# Total count of book rated per user

SELECT 
    users_id, COUNT(book_rating) AS Total_book_rated
FROM
    ratings
GROUP BY users_id;

select * from ratings where users_id=8;

#count total users in a location

SELECT 
    COUNT(user_id) AS Total_users, location
FROM
    users
GROUP BY location
ORDER BY COUNT(user_id) DESC;

# Procedure to find a book details from the Data

create procedure find_book(in book varchar(50))
select * from book_name where book_title=book;

call find_book('Life of Pi');

# Distinct number of users who have given one or more ratings,number of distinct book that have been 
# rated and the total number of all the ratings that are available in the table.

SELECT 
    count(distinct users_id) as Individual_users,
    count(distinct isbn) as Distinct_books,
    count(*) as Total_ratings
from
    ratings;

#ratings distribution
#this query returns the count of 10 to 0 ratings in the table

SELECT 
    COUNT(*) AS users, book_rating
FROM
    ratings
GROUP BY book_rating
ORDER BY book_rating DESC;

select * from ratings where book_rating=10;

#View

create view View1 as select * from book_name order by year_of_publication desc;

select * from view1;


