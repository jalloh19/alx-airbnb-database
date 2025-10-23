-- ============================================================
-- Sample Data Seeding Script
-- ============================================================

-- Insert sample users
INSERT INTO "user" (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES
    (gen_random_uuid(), 'Alice', 'Johnson', 'alice@example.com', 'hashed_pass1', '1234567890', 'host'),
    (gen_random_uuid(), 'Bob', 'Smith', 'bob@example.com', 'hashed_pass2', '0987654321', 'guest'),
    (gen_random_uuid(), 'Charlie', 'Brown', 'charlie@example.com', 'hashed_pass3', NULL, 'guest');

-- Insert sample locations
INSERT INTO location (location_id, street, city, state, country, postal_code, latitude, longitude)
VALUES
    (gen_random_uuid(), '123 Beach Rd', 'Miami', 'FL', 'USA', '33101', 25.7617, -80.1918),
    (gen_random_uuid(), '42 High St', 'London', NULL, 'UK', 'SW1A 1AA', 51.5074, -0.1278);

-- Insert sample properties
INSERT INTO property (property_id, host_id, name, description, location_id, pricepernight)
SELECT
    gen_random_uuid(), u.user_id, 'Seaside Apartment', 'A cozy apartment near the beach.', l.location_id, 120.00
FROM "user" u, location l
WHERE u.email = 'alice@example.com' AND l.city = 'Miami'
LIMIT 1;

INSERT INTO property (property_id, host_id, name, description, location_id, pricepernight)
SELECT
    gen_random_uuid(), u.user_id, 'Downtown Loft', 'Modern loft in the heart of London.', l.location_id, 200.00
FROM "user" u, location l
WHERE u.email = 'alice@example.com' AND l.city = 'London'
LIMIT 1;

-- Insert sample bookings
INSERT INTO booking (booking_id, property_id, user_id, start_date, end_date, status)
SELECT
    gen_random_uuid(), p.property_id, u.user_id, '2025-11-01', '2025-11-05', 'confirmed'
FROM property p, "user" u
WHERE p.name = 'Seaside Apartment' AND u.email = 'bob@example.com'
LIMIT 1;

-- Insert sample payments
INSERT INTO payment (payment_id, booking_id, amount, payment_method)
SELECT
    gen_random_uuid(), b.booking_id, 480.00, 'stripe'
FROM booking b
WHERE b.status = 'confirmed'
LIMIT 1;

-- Insert sample reviews
INSERT INTO review (review_id, property_id, user_id, rating, comment)
SELECT
    gen_random_uuid(), p.property_id, u.user_id, 5, 'Fantastic stay, highly recommended!'
FROM property p, "user" u
WHERE p.name = 'Seaside Apartment' AND u.email = 'bob@example.com'
LIMIT 1;

-- Insert sample messages
INSERT INTO message (message_id, sender_id, recipient_id, message_body)
SELECT
    gen_random_uuid(), u1.user_id, u2.user_id, 'Hi Alice, is the apartment available for next month?'
FROM "user" u1, "user" u2
WHERE u1.email = 'bob@example.com' AND u2.email = 'alice@example.com'
LIMIT 1;

INSERT INTO message (message_id, sender_id, recipient_id, message_body)
SELECT
    gen_random_uuid(), u1.user_id, u2.user_id, 'Yes, it’s available from December 1st!'
FROM "user" u1, "user" u2
WHERE u1.email = 'alice@example.com' AND u2.email = 'bob@example.com'
LIMIT 1;


