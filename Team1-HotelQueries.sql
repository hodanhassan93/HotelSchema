-- 1. Write a query that returns a list of reservations that end in July 2023, including the name of the guest, the room number(s), and the reservation dates.
select g.name 'guest_name', r.room_num, r.start_date, r.end_date
from reservation_details r
join guests g on r.guest_Id = g.guest_Id
where r.end_date >= '2023-07-01' and r.end_date <= '2023-07-31';
-- 1. Write a query that returns a list of reservations that end in July 2023, including the name of the guest, the room number(s), and the reservation dates.
select g.name 'guest_name', rd.room_num, rd.start_date, rd.end_date
from Reservation_details rd
join Final_res fr on rd.reservation_Id = fr.reservation_Id
join guests g on fr.guest_res_Id = g.guest_Id
where rd.end_date >= '2023-07-01' and rd.end_date <= '2023-07-31';
-- 2. Write a query that returns a list of all reservations for rooms with a jacuzzi, displaying the guest's name, the room number, and the dates of the reservation.
select g.name 'guest_name', rd.room_num, rd.start_date, rd.end_date
from Reservation_details rd
join Final_res fr on rd.reservation_Id = fr.reservation_Id
join guests g on fr.guest_res_Id = g.guest_Id
join Room r on rd.room_num = r.room_num
join room_amenity ra on r.room_num = ra.room_num
join amenity a on ra.amenities_Id = a.amenities_Id
where a.amenities_name = 'jacuzzi';

-- 3. Write a query that returns all the rooms reserved for a specific guest, 
-- including the guest's name, the room(s) reserved, the starting date of the reservation, 
-- and how many people were included in the reservation. (Choose a guest's name from the existing data.)

SELECT G.name, RD.start_date, R.room_num, GR.adults + GR.children "total_people"
FROM Guests G
JOIN guest_res GR ON G.guest_Id = GR.guest_Id
JOIN Final_res FR ON GR.guest_res_Id = FR.guest_res.guest_Id
JOIN Reservation_details RD ON FR.reservation_Id = RD.reservation_Id
JOIN Room R ON RD.room_num = R.room_num
WHERE G.name = "Aurore Lipton";

-- 4. Write a query that returns a list of rooms, reservation ID, and per-room cost for each reservation. 
-- The results should include all rooms, whether or not there is a reservation associated with the room.

SELECT 
    r.room_num,
    fr.reservation_Id,
    rd.total_cost AS per_room_cost
FROM
    Room r
LEFT JOIN
    Reservation_details rd ON r.room_num = rd.room_num
LEFT JOIN
    Final_res fr ON rd.reservation_Id = fr.reservation_Id
LEFT JOIN
    guest_res gr ON fr.guest_res_Id = gr.guest_res_Id
LEFT JOIN
    room_type rt ON r.type_Id = rt.type_Id
LEFT JOIN
    room_amenity ra ON r.room_num = ra.room_num
LEFT JOIN
    amenity am ON ra.amenities_Id = am.amenities_Id
GROUP BY
    r.room_num,
    fr.reservation_Id,
    rt.base_price,
    gr.adults,
    gr.children;

-- 5) Write a query that returns all rooms with a capacity of three or more and that are reserved on any date in April 2023.
select room_num
from reservation_detail
where start_date = "%-04-%" OR end_date = "%-04-%";


-- 6)Write a query that returns a list of all guest names and the number of reservations per guest, sorted starting with the guest with the most reservations and then by the guest's last name.
select guest_name, count(guest_res.guest_Id) 
from Guests
inner join guest_res 
on Guests.guest_Id = guest_res.guest_Id
group by Guests.guest_Id
order by Guests.guest_Id;

-- 7) Write a query that displays the name, address, and phone number of a guest based on their phone number. (Choose a phone number from the existing data.)
select guest_name, address, phone
from Guests
where phone = "(446) 396-6785";