# Database Normalization: 3NF

## Objective
Ensure the Airbnb database design is normalized up to the **Third Normal Form (3NF)** 

---

## Step 1: First Normal Form (1NF)

 **Result:** Schema satisfies 1NF.

---

## Step 2: Second Normal Form (2NF)

**Result:** Schema satisfies 2NF.

---

## Step 3: Third Normal Form (3NF)
**Rule:** There should be no **transitive dependency** 

**Analysis & Adjustments:**

- In the **Booking** table, `total_price` can be derived from `pricepernight × number_of_nights`.  
- In the **Property** table, the `location` field may contain multiple values (city, country, etc.).   
- In the **User** table, if multiple phone numbers are needed, create a separate `User_Phone` table.  
- The **role** attribute in `User` currently uses an ENUM.  
  This is acceptable, but if roles need metadata or scalability, use a `Role` lookup table.


---

✅ **Final Result:**  
The Airbnb Clone database is in **Third Normal Form (3NF)**.
