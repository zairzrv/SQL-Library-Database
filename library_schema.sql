--Project 3
--Group 4: Zair Ruiz-Velazquuez, Jack Urchell, Babajide Osiyemi

set echo on;

drop table borrower CASCADE CONSTRAINTS;
drop table publisher CASCADE CONSTRAINTS;
drop table library_item CASCADE CONSTRAINTS;
drop table book CASCADE CONSTRAINTS;
drop table student CASCADE CONSTRAINTS;
drop table magazine CASCADE CONSTRAINTS;
drop table journal CASCADE CONSTRAINTS;
drop table conference_proceeding CASCADE CONSTRAINTS;
drop table faculty CASCADE CONSTRAINTS;
drop table other_borrower CASCADE CONSTRAINTS;
drop table author CASCADE CONSTRAINTS;
drop table written_by CASCADE CONSTRAINTS;
drop table editor CASCADE CONSTRAINTS;
drop table edited_by CASCADE CONSTRAINTS;
drop table reserved_by CASCADE CONSTRAINTS;


CREATE TABLE PUBLISHER(
    name varchar2(50),
    url varchar2(100) NOT NULL, 
    CONSTRAINT pk_publisher PRIMARY KEY(name),
    CONSTRAINT uq_publisher UNIQUE(url)
);

CREATE TABLE BORROWER(
    bid NUMBER(6),
    name varchar2(50) NOT NULL,
    address varchar2(100),
    CONSTRAINT pk_borrower PRIMARY KEY(bid)
);

CREATE TABLE LIBRARY_ITEM(
    congress_id varchar2(30),
    title varchar2(100) NOT NULL,
    publisher_name varchar2(50),
    check_out_date date,
    latest_return_date date,
    b_bid NUMBER(6),
    CONSTRAINT pk_library_item PRIMARY KEY(congress_id),
    CONSTRAINT fk_item_publisher FOREIGN KEY(publisher_name) references PUBLISHER(name),
    CONSTRAINT fk_item_borrower FOREIGN KEY(b_bid) references BORROWER(bid),
    CONSTRAINT ck_item_dates CHECK(check_out_date <= latest_return_date)
);

CREATE TABLE BOOK(
    major varchar2(50),
    congress_id varchar2(30),
    CONSTRAINT pk_book PRIMARY KEY(congress_id),
    CONSTRAINT fk_book_item FOREIGN KEY(congress_id) references library_item(congress_id)

);

CREATE TABLE STUDENT(
    major varchar2(50),
    bid number(6),
    CONSTRAINT pk_student PRIMARY KEY(bid),
    CONSTRAINT fk_student_borrower FOREIGN KEY(bid) references borrower(bid)
);

CREATE TABLE MAGAZINE(
    type varchar2(50),
    date_of_publication date,
    congress_id varchar2(30),
    CONSTRAINT pk_magazine PRIMARY KEY(congress_id),
    CONSTRAINT fk_magazine_item FOREIGN KEY(congress_id) references library_item(congress_id)
);

CREATE TABLE JOURNAL(
    volume varchar2(50),
    issue_number number(20),
    congress_id varchar2(30),
    CONSTRAINT pk_journal PRIMARY KEY(congress_id),
    CONSTRAINT fk_journal_item FOREIGN KEY(congress_id) references library_item(congress_id)
);

CREATE TABLE CONFERENCE_PROCEEDING(
    location varchar2(100),
    conference_date date,
    congress_id varchar2(30),
    CONSTRAINT pk_conference_proceeding PRIMARY KEY(congress_id),
    CONSTRAINT fk_conference_item FOREIGN KEY(congress_id) references library_item(congress_id)
);

CREATE TABLE FACULTY(
    department varchar2(100),
    bid number(6),
    CONSTRAINT pk_faculty PRIMARY KEY(bid),
    CONSTRAINT fk_faculty_borrower FOREIGN KEY(bid) references borrower(bid)
);

CREATE TABLE OTHER_BORROWER(
    membership_length number(3),
    bid number(6),
    CONSTRAINT pk_other_borrower PRIMARY KEY(bid),
    CONSTRAINT fk_other_borrower FOREIGN KEY(bid) references borrower(bid),
    CONSTRAINT ck_other_membership CHECK(membership_length > 0)
);

CREATE TABLE AUTHOR(
    author_id varchar2(30),
    name varchar2(50) NOT NULL,
    CONSTRAINT pk_author PRIMARY KEY(author_id)
);

CREATE TABLE WRITTEN_BY(
    congress_id varchar2(30),
    author_id varchar2(30),
    CONSTRAINT pk_written_by PRIMARY KEY(congress_id, author_id),
    CONSTRAINT fk_written_book FOREIGN KEY(congress_id) references book(congress_id),
    CONSTRAINT fk_written_author FOREIGN KEY(author_id) references author(author_id)
);

CREATE TABLE EDITOR(
    editor_id varchar2(30),
    name varchar2(50) NOT NULL,
    CONSTRAINT pk_editor PRIMARY KEY(editor_id)   
);

CREATE TABLE EDITED_BY(
    editor_id varchar2(30),
    congress_id varchar2(30),
    CONSTRAINT pk_edited_by PRIMARY KEY(editor_id, congress_id),
    CONSTRAINT fk_edited_proceeding FOREIGN KEY(congress_id) references conference_proceeding(congress_id),
    CONSTRAINT fk_edited_editor FOREIGN KEY(editor_id) references editor(editor_id)
);

CREATE TABLE RESERVED_BY(
    bid NUMBER(6),
    congress_id varchar2(30),
    reserve_order NUMBER(3),
    length_reserved NUMBER(3), 
    CONSTRAINT pk_reserved_by PRIMARY KEY(bid, congress_id), 
    CONSTRAINT fk_reserved_item FOREIGN KEY(congress_id) references library_item(congress_id),
    CONSTRAINT fk_reserved_borrower FOREIGN KEY(bid) references borrower(bid),
    CONSTRAINT ck_reserved_length CHECK(length_reserved > 0)
);