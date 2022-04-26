

-- 1 create the database schema 

create table train_infor(
train_id int not null,
train_name varchar(20) not null,
source varchar(30) not null,
destionation varchar(20) not null,
av_time time not null, 
capacity int not null)


create table station_info(
station_id int not null, 
station_name varchar(20) not null, 
st_master varchar(20) not null,
no_platform int not null, 
capacity int not null, 
type varchar(20) )

create table schedule_info (
schedule_id int not null, 
train_id int not null,
station_id int not null,
av_time time not null, 
dept_time time not null,
fare money)

create table ticket_reservation(
pnr int not null, 
schedule_id int not null, 
train_id int not null,
age int not null, 
seat_no int not null,
sex char(1) not null )

--- link is a conjunction table because there is a many to many relationship between schedule_info table and ticket_reservation
create table link(
schedule_id int not null, 
train_id int not null,
station_id int not null,
pnr int not null)



create table account(
account_id int constraint pk_account_id PRIMARY KEY,
date datetime not null,
pnr int not null, 
)


--create key constraint
alter table train_infor
add constraint pk_train_id primary key(train_id)

alter table station_info
add constraint pk_station_id primary key(station_id)


alter table ticket_reservation
add constraint pk_pnr primary key(pnr)

alter table schedule_info 
add constraint pk_schedule_id primary key(schedule_id)



--foreing key

alter table schedule_info 
add constraint fk__schedule_info_train_infor foreign KEY (train_id) references train_infor(train_id)


alter table schedule_info 
add constraint fk__schedule_info_station_info foreign KEY (station_id) references station_info(station_id)



alter table ticket_reservation
add constraint fk__ticket_reservation_schedule_info foreign KEY (schedule_id) references schedule_info(schedule_id)
	

alter table ticket_reservation
add constraint fk__ticket_reservation_train_infor foreign KEY (station_id) references train_infor(station_id)


alter table account
add constraint fk__account_ticket_reservation foreign KEY (pnr) references ticket_reservation(pnr)

alter table account
add constraint ck_account  check (pnr =1)

-- we can composite key in the conjunction table


alter table link
add constraint fk__link_sch  foreign KEY (schedule_id) references schedule_info (schedule_id)

alter table link
add constraint fk__link_ticket   foreign KEY (pnr) references ticket_reservation(pnr)

alter table link
add constraint fk__link_compo primary KEY (schedule_id , pnr) 