-- Airbnb Clone Database Schema (Normalized to 3NF)


-- Create Schema
CREATE SCHEMA IF NOT EXISTS airbnb_db;
SET search_path TO airbnb_db;


-- USERS

CREATE TABLE users (
    user_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(20) DEFAULT 'guest' CHECK (role IN ('guest', 'host', 'admin')),
    date_joined TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_users_email ON users(email);

-- LOCATION

CREATE TABLE location (
    location_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    street VARCHAR,
    city VARCHAR NOT NULL,
    state VARCHAR,
    country VARCHAR NOT NULL,
    postal_code VARCHAR,
    latitude NUMERIC(9,6),
    longitude NUMERIC(9,6),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_location_city_country ON location(city, country);

--PROPERTY

CREATE TABLE property (
    property_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL,
    location_id UUID,
    title VARCHAR(150) NOT NULL,
    description TEXT,
    price_per_night NUMERIC(10,2) NOT NULL CHECK (price_per_night >= 0),
    property_type VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_property_user FOREIGN KEY (user_id)
        REFERENCES users(user_id) ON DELETE CASCADE,

    CONSTRAINT fk_property_location FOREIGN KEY (location_id)
        REFERENCES location(location_id) ON DELETE SET NULL
);

CREATE INDEX idx_property_user ON property(user_id);
CREATE INDEX idx_property_location ON property(location_id);

-- BOOKING

CREATE TABLE booking (
    booking_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL,
    property_id UUID NOT NULL,
    check_in DATE NOT NULL,
    check_out DATE NOT NULL,
    status VARCHAR(20) DEFAULT 'pending' CHECK (status IN ('pending', 'confirmed', 'cancelled')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_booking_user FOREIGN KEY (user_id)
        REFERENCES users(user_id) ON DELETE CASCADE,

    CONSTRAINT fk_booking_property FOREIGN KEY (property_id)
        REFERENCES property(property_id) ON DELETE CASCADE,

    CONSTRAINT chk_booking_dates CHECK (check_out > check_in)
);

CREATE INDEX idx_booking_user ON booking(user_id);
CREATE INDEX idx_booking_property ON booking(property_id);

-- PAYMENT

CREATE TABLE payment (
    payment_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    booking_id UUID NOT NULL,
    amount NUMERIC(10,2) NOT NULL CHECK (amount >= 0),
    payment_status VARCHAR(20) DEFAULT 'pending' CHECK (payment_status IN ('pending', 'completed', 'failed')),
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_payment_booking FOREIGN KEY (booking_id)
        REFERENCES booking(booking_id) ON DELETE CASCADE
);

CREATE INDEX idx_payment_booking ON payment(booking_id);

-- REVIEW

CREATE TABLE review (
    review_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    booking_id UUID NOT NULL,
    user_id UUID NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_review_booking FOREIGN KEY (booking_id)
        REFERENCES booking(booking_id) ON DELETE CASCADE,

    CONSTRAINT fk_review_user FOREIGN KEY (user_id)
        REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE INDEX idx_review_booking ON review(booking_id);
CREATE INDEX idx_review_user ON review(user_id);

-- MESSAGE

CREATE TABLE message (
    message_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    sender_id UUID NOT NULL,
    recipient_id UUID NOT NULL,
    content TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_message_sender FOREIGN KEY (sender_id)
        REFERENCES users(user_id) ON DELETE CASCADE,

    CONSTRAINT fk_message_recipient FOREIGN KEY (recipient_id)
        REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE INDEX idx_message_sender ON message(sender_id);
CREATE INDEX idx_message_recipient ON message(recipient_id);

