# Entity-Relationship Diagram (ERD)

## Entities and Relationships

### Key Entities
- **User**
- **Property**
- **Booking**
- **Payment**
- **Review**
- **Message**

### Relationships
- A **User** (host) can own multiple **Properties**.
- A **User** (guest) can make multiple **Bookings**.
- A **Booking** belongs to one **Property** and one **User**.
- A **Booking** has one **Payment**.
- A **Property** can have many **Reviews**.
- A **User** can send and receive **Messages** from other users.

### Files
- `airbnb_luchichard.png`
- `airbnb_pgAdmin4.png`

