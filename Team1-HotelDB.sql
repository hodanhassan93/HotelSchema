drop database Team1HotelDb;
create database Team1HotelDb;
use Team1HotelDb;

create table guests(
guest_id int primary key,
name varchar(55), -- may need to be renamed--
address varchar (70) not null,
city varchar(25) not null,
state char(5) not null,
zip int not null,
phone varchar(20)
);

create table room_type(
type_Id int primary key,
type varchar(15) NOT NULL,
standard_occ int NOT NULL,
max_occ int NOT NULL,
base_price double NOT NULL,
extra_person int);

create table guest_res(
guest_res_Id int primary key,
guest_Id int,
adults int NOT NULL,
children int NOT NULL,
constraint foreign key(guest_Id) REFERENCES guests(guest_id)
);

Create table amenity(
amenities_Id int primary key,
amenities_name varchar(20) not null
);

create table room(
room_num int primary key,
type_Id int,
ada varchar(5) NOT NULL,
constraint foreign key(type_Id) REFERENCES room_type(type_Id));

create table reservation_details(
reservation_id int primary key,
start_date date NOT NULL,
end_date date NOT NULL, 
room_num int,
total_cost double NOT NULL,
constraint foreign key(room_num) REFERENCES room(room_num)
);

create table room_amenity(
room_num int,
amenities_Id int,
constraint foreign key(room_num) REFERENCES room(room_num),
constraint foreign key(amenities_Id) REFERENCES amenity(amenities_Id),
CONSTRAINT pk_room_amenities
    	PRIMARY KEY (room_num, amenities_Id));
        
create table final_res(
guest_res_Id int,
reservation_Id int,
constraint foreign key(guest_res_Id) REFERENCES guest_res(guest_res_Id),
constraint foreign key(reservation_Id) REFERENCES reservation_details(reservation_Id),
CONSTRAINT pk_final_res
    	PRIMARY KEY (guest_res_Id, reservation_Id));





