# Database Schema (DDL)

## Overview
This directory contains the SQL definition for the Airbnb Clone project.  
The schema is normalized to **Third Normal Form (3NF)** for data consistency and scalability.

## Entities
- **Users** – Stores guest and host information.
- **Location** – Represents detailed address and coordinates.
- **Property** – Lists properties owned by hosts.
- **Booking** – Manages reservation details.
- **Payment** – Tracks transactions linked to bookings.
- **Review** – Captures user feedback on stays.
- **Message** – Handles communication between users.

## Relationships
- A **User** can list multiple **Properties** (1-to-N).
- A **User** can make multiple **Bookings** (1-to-N).
- A **Property** can have many **Bookings** (1-to-N).
- A **Booking** has one **Payment** (1-to-1).
- A **Booking** can have one **Review** (1-to-1).
- A **Message** is exchanged between **Users** (N-to-N via sender and recipient).

## Performance
Indexes are added on:
- Foreign keys (`user_id`, `property_id`, `booking_id`)
- Frequently queried fields (`email`, `city`, `country`)

## Next Steps
- Execute `schema.sql` using `psql` or pgAdmin4.
- Verify relationships via ERD reverse engineering.
