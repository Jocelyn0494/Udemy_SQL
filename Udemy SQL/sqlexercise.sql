/****************************************/
/*****SECTION 7:Assessment Test 2*******/
/***************************************/
SELECT * FROM cd.bookings;
SELECT * FROM cd.members;
SELECT * FROM cd.facilities;

/*Question 1: How can you retrieve all the information from the cd.facilities table?*/
SELECT * FROM cd.facilities;
/*Question 2: You want to print out a list of all of the facilities and their cost to members. 
How would you retrieve a list of only facility names and costs?*/
SELECT name,membercost FROM cd.facilities;
/*Q3: How can you produce a list of facilities that charge a fee to members?*/
SELECT * FROM cd.facilities
WHERE membercost > 0;
/*Q4: How can you produce a list of facilities that charge a fee to members, 
and that fee is less than 1/50th of the monthly maintenance cost? 
Return the facid, facility name, member cost, and monthly maintenance of the facilities in question. */
SELECT facid, name, membercost,monthlymaintenance
FROM cd.facilities
WHERE membercost>0 and membercost < (1/50*monthlymaintenance);
/*Q5: How can you produce a list of all facilities with the word 'Tennis' in their name?*/
SELECT * FROM cd.facilities
WHERE name LIKE '%Tennis%';
/*Q6: How can you retrieve the details of facilities with ID 1 and 5? Try to do it without using the OR operator.*/
SELECT * FROM cd.facilities
WHERE facid = 1 or facid =5;

/*Q6: How can you retrieve the details of facilities with ID 1 and 5? Try to do it without using the OR operator.*/
SELECT * FROM cd.facilities
WHERE facid in (1,5);
/*Q7: How can you produce a list of members who joined after the start of September 2012? 
Return the memid, surname, firstname, and joindate of the members in question.*/
SELECT memid,surname,firstname,joindate FROM cd.members
WHERE joindate > '2012-09-01';

/*Q8: How can you produce an ordered list of the first 10 surnames in the members table? The list must not contain duplicates.*/
SELECT DISTINCT surname FROM cd.members
ORDER BY surname
LIMIT 10;

/*Q9: You'd like to get the signup date of your last member. How can you retrieve this information?*/

SELECT MAX(joindate) as latest
from cd.members;

/*Q10: Produce a count of the number of facilities that have a cost to guests of 10 or more.*/

SELECT count(*) FROM cd.facilities
WHERE guestcost>10;

/*Q12:Produce a list of the total number of slots booked per facility in the month of September 2012. 
Produce an output table consisting of facility id and slots, sorted by the number of slots.*/

SELECT * FROM cd.facilities
SELECT * FROM cd.bookings

SELECT facid,SUM(slots) as "Total Slots"
FROM cd.bookings
WHERE starttime >= '2012-09-01' and starttime<'2012-10-01'
GROUP BY facid
ORDER BY sum(slots);

/*Q13 Produce a list of facilities with more than 1000 slots booked. 
Produce an output table consisting of facility id and total slots, sorted by facility id.
*/
SELECT facid,SUM(slots)as "Total Slots"
FROM cd.bookings
GROUP BY facid
HAVING SUM(slots)>1000
ORDER BY facid;

/*Q14: How can you produce a list of the start times for bookings for tennis courts, for the date '2012-09-21'? 
Return a list of start time and facility name pairings, ordered by the time.*/
 
SELECT bks.starttime as start, facs.name as name 
FROM cd.facilities facs 
INNER JOIN cd.bookings bks
ON facs.facid = bks.facid
WHERE facs.facid in (0,1) and bks.starttime >='2012-09-21' and bks.starttime<'2019-09-22'
ORDER BY bks.starttime;

/*Q15: How can you produce a list of the start times for bookings by members named 'David Farrell'?*/
SELECT * FROM cd.members

SELECT bks.starttime as start
FROM cd.bookings bks
INNER JOIN cd.members mem
ON mem.memid = bks.memid
WHERE mem.firstname = 'David' and mem.surname = 'Farrell';



