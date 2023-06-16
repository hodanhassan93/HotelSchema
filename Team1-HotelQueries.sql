-- 1. Write a query that returns a list of reservations that end in July 2023, including the name of the guest, the room number(s), and the reservation dates.
select g.name 'guest_name', rd.room_num, rd.start_date, rd.end_date
from guests g
join guest_res gr on g.guest_id = gr.guest_id
join final_res fr on gr.guest_res_id = fr.guest_res_id
join reservation_details rd on fr.reservation_id = rd.reservation_id
where rd.end_date >= '2023-07-01' and rd.end_date < '2023-08-01';

-- # guest_name, room_num, start_date, end_date
-- 'Bettyann Seery', '303', '2023-07-28', '2023-07-29'
-- 'Ellie', '205', '2023-06-28', '2023-07-02'
-- 'Walter Holaway', '204', '2023-07-13', '2023-07-14'
-- 'Wilfred Vise','401','2023-07-18','2023-07-21'

-- 2. Write a query that returns a list of all reservations for rooms with a jacuzzi, displaying the guest's name, the room number, and the dates of the reservation.
select g.name "guest_name", rd.room_num, rd.start_date, rd.end_date
from guests g
join guest_res gr on g.guest_id = gr.guest_id
join final_res fr on gr.guest_res_id = fr.guest_res_id
join reservation_details rd on fr.reservation_id = rd.reservation_id
join room r on rd.room_num = r.room_num
join room_amenity ra on r.room_num = ra.room_num
join amenity a on ra.amenities_id = a.amenities_id
where a.amenities_name = 'Jacuzzi';

-- # guest_name, room_num, start_date, end_date
-- 'Karie Yang', '201', '2023-03-06', '2023-03-07'
-- 'Bettyann Seery', '203', '2023-02-05', '2023-02-10'
-- 'Karie Yang', '203', '2023-09-13', '2023-09-15'
-- 'Ellie', '205', '2023-06-28', '2023-07-02'
-- 'Wilfred Vise', '207', '2023-04-23', '2023-04-24'
-- 'Walter Holaway', '301', '2023-04-09', '2023-04-13'
-- 'Mack Simmer', '301', '2023-11-22', '2023-11-25'
-- 'Bettyann Seery', '303', '2023-07-28', '2023-07-29'
-- 'Duane Cullison', '305', '2023-02-22', '2023-02-24'
-- 'Bettyann Seery', '305', '2023-08-30', '2023-09-01'

-- 3. Write a query that returns all the rooms reserved for a specific guest, 
-- including the guest's name, the room(s) reserved, the starting date of the reservation, 
-- and how many people were included in the reservation. (Choose a guest's name from the existing data.)

SELECT G.name, RD.start_date, R.room_num, GR.adults + GR.children AS total_people
FROM guests G
JOIN guest_res GR ON G.guest_id = GR.guest_id
JOIN final_res FR ON GR.guest_res_Id = FR.guest_res_Id
JOIN reservation_details RD ON FR.reservation_Id = RD.reservation_id
JOIN room R ON RD.room_num = R.room_num
WHERE G.name = 'Aurore Lipton';

-- 'Aurore Lipton', '2023-03-18', '302', '3'
-- 'Aurore Lipton', '2023-06-17', '304', '3'

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
    rd.total_cost,
    rt.base_price,
    gr.adults,
    gr.children;
    
/* # room_num, reservation_Id, per_room_cost
'201', '203', '199.99'
'202', '206', '349.98'
'203', '201', '999.95'
'203', '220', '399.98'
'204', '215', '184.99'
'301', '208', '799.96'
'301', '223', '599.97'
'302', '205', '924.95'
'302', '224', '699.96'
'303', '217', '199.99'
'304', '207', '874.95'
'304', '213', '184.99'
'305', '202', '349.98'
'305', '218', '349.98'
'306', NULL, NULL
'307', '204', '524.97'
'308', '200', '299.98'
'401', '210', '1199.97'
'401', '216', '1259.97'
'401', '221', '1199.97'
'402', NULL, NULL
*/

-- 5) Write a query that returns all rooms with a capacity of three or more and that are reserved on any date in April 2023.
select room.room_num
from room
right join room_type on room.type_Id=room_type.type_Id
right join reservation_details on room.room_num=reservation_details.room_num
where (max_occ >=3) AND (MONTH(start_date) = 4 OR MONTH(end_date) = 4 AND YEAR(start_date) = 2023);

-- # room_num
-- '301'
-- '304'

-- 6)Write a query that returns a list of all guest names and the number of reservations per guest, sorted starting with the guest with the most reservations and then by the guest's last name.
select name, count(guest_res.guest_Id) 
from guests
inner join guest_res 
on guests.guest_Id = guest_res.guest_Id
group by guests.guest_Id
order by guests.guest_Id;

-- # name, count(guest_res.guest_Id)
-- 'Mack Simmer', '4'
-- 'Bettyann Seery','3'
-- 'Duane Cullison','2'
-- 'Karie Yang','2'
-- 'Aurore Lipton','2'
-- 'Zachery Luechtefeld','1'
-- 'Walter Holaway','2'
-- 'Wilfred Vise','2'
-- 'Maritza Tilton','2'
-- 'Joleen Tison','2'
-- 'Prisca','1'
-- 'Ellie','1'

-- 7) Write a query that displays the name, address, and phone number of a guest based on their phone number. (Choose a phone number from the existing data.)
select name, address, phone
from guests
where phone = "(446) 396-6785";

-- # name, address, phone
-- 'Walter Holaway', '7556 Arrowhead St.', '(446) 396-6785'

