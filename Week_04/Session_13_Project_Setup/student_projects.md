# 🚀 Django Capstone Projects — Individual Student Assignments

> **Course:** Django & Django REST Framework  
> **Stack:** Python · Django · DRF · JWT · SQLite/PostgreSQL · Bootstrap 5  
> **Objective:** Each student builds a real-world, monetizable web application from scratch using everything covered in this course.

---

> IMPORTANT: Every project must include:
> - User Authentication (Register / Login / Logout / Dashboard)
> - At least **3 Django apps** with proper separation of concerns
> - At least **1 REST API endpoint** (DRF + JWT)
> - A working **payment/subscription flow** (can be simulated with a status field)
> - Deployable locally with `python manage.py runserver`
> - A `README.md` explaining the project and how to run it
> - Code pushed to a **GitHub repository**

---

## 👨‍💻 Student 1 — Richard

### 📦 Project: **MediQueue** — Online Doctor Appointment Booking System

#### 🌍 Real-World Problem
In Nigeria and across Africa, booking a doctor's appointment is chaotic — patients queue for hours, clinics have no system, and records are paper-based. **MediQueue** solves this by allowing patients to book appointments with doctors online, pick a time slot, and get a digital record of their visit.

#### 💰 Monetization Model — Transactional + Commission
- Clinics/hospitals pay a **₦5,000 monthly listing fee** to be on the platform
- Patients pay a **₦500 booking fee** per appointment (platform takes 20% commission)
- Premium clinics pay **₦15,000/month** for featured placement at the top of search results

#### 🗂️ Apps to Build

| App | Responsibility |
|-----|---------------|
| `core` | Homepage, About, Contact |
| `accounts` | Patient & Doctor registration, login, dashboard |
| `clinics` | Clinic profiles, doctor listings, specializations |
| `appointments` | Booking form, time slots, appointment history |

#### 📋 Detailed Feature Requirements

**Patients can:**
- Register and create a profile (name, phone, blood group)
- Browse clinics by **specialization** (e.g., Cardiology, Dentistry, General)
- View a doctor's available time slots
- Book an appointment and receive a **booking reference number**
- View their **appointment history** on the dashboard
- Cancel an appointment (if more than 24 hours away)

**Doctors/Clinic Admins can:**
- Register a clinic with address, specializations, and working hours
- Add doctors to their clinic (name, specialty, bio, photo)
- Set available time slots per doctor (e.g., Mon 9am-12pm, slots every 30 min)
- View upcoming bookings for their clinic
- Mark appointments as **Completed** or **Cancelled**

**Django Admin:**
- Manage clinics, approve clinic listings
- View all bookings and revenue stats

**REST API (DRF):**
- `GET /api/clinics/` — list all clinics with filters (specialization, location)
- `GET /api/clinics/{id}/slots/` — available slots for a clinic
- `POST /api/appointments/` — create a booking (JWT required)

#### 🗃️ Key Models
```
Clinic → Doctor → TimeSlot → Appointment → Patient
```

#### 🎯 Monetization Simulation
- Add a `subscription_tier` field on `Clinic` model (`free`, `standard`, `premium`)
- Free clinics are hidden after 3 bookings per month
- Standard/Premium clinics appear at the top of listings

---

## 👩‍💻 Student 2 — Virtue

### 📦 Project: **SkillBridge** — Freelance Skill Marketplace

#### 🌍 Real-World Problem
Many talented Nigerians (graphic designers, coders, writers, video editors) have no professional platform to showcase and sell their skills. They rely on WhatsApp DMs and referrals. **SkillBridge** is a local alternative to Fiverr — a marketplace where freelancers list their services ("gigs") and clients pay to hire them.

#### 💰 Monetization Model — Commission + Subscription
- Platform takes a **10% commission** on every completed transaction
- Freelancers can subscribe to a **"Pro" plan** (₦3,000/month) which allows listing up to 10 gigs (free plan: 2 gigs max)
- Clients pay an **escrow fee** of ₦200 per order (held until work is confirmed delivered)

#### 🗂️ Apps to Build

| App | Responsibility |
|-----|---------------|
| `core` | Homepage, how it works, about, contact |
| `accounts` | Freelancer & Client registration, profiles, dashboard |
| `gigs` | Gig listings, categories, packages (Basic/Standard/Premium) |
| `orders` | Order creation, delivery tracking, completion |

#### 📋 Detailed Feature Requirements

**Freelancers can:**
- Register and build a profile (bio, skills, profile photo, portfolio link)
- Create gigs with a title, description, category, price, and delivery time
- Offer **3 pricing tiers** per gig: Basic, Standard, Premium (different prices & deliverables)
- Upload a sample/portfolio image to the gig
- Receive orders and mark them as **In Progress → Delivered → Completed**
- View their **earnings dashboard** (total earned, pending, withdrawn)

**Clients can:**
- Browse gigs by **category** (Tech, Design, Writing, Marketing, etc.)
- View a freelancer's profile and past work
- Place an order by selecting a gig package
- Confirm delivery (releases payment from escrow)
- Leave a **star rating and review** after completion

**REST API (DRF):**
- `GET /api/gigs/` — list gigs with search and category filter
- `GET /api/gigs/{id}/` — single gig detail
- `POST /api/orders/` — place an order (JWT required)
- `GET /api/freelancer/{id}/reviews/` — reviews for a freelancer

#### 🗃️ Key Models
```
Category → Gig → GigPackage → Order → Review → FreelancerProfile
```

#### 🎯 Monetization Simulation
- Add `plan` field on `FreelancerProfile` (`free`, `pro`)
- Free plan: only 2 active gigs visible
- Pro plan: up to 10 gigs + featured badge on profile
- `Order` model has `commission_amount` = 10% of order value (auto-calculated)

---

## 👨‍💻 Student 3 — Wisdom

### 📦 Project: **LearnFlow** — Online Course & Tutorial Platform

#### 🌍 Real-World Problem
Quality education is inaccessible to many Nigerians — either too expensive or not available locally. **LearnFlow** is a platform where educators (teachers, professionals) can create and sell video/text courses to students across Africa, similar to a local Udemy.

#### 💰 Monetization Model — Revenue Split + Platform Fee
- Instructors keep **70%** of every course sale, platform keeps **30%**
- Students buy courses with a one-time payment (no subscription needed)
- Instructors can offer **discount coupons** to drive sales
- Featured courses are sold as ad slots — instructors pay ₦10,000/month to appear on homepage

#### 🗂️ Apps to Build

| App | Responsibility |
|-----|---------------|
| `core` | Homepage (featured courses), about, contact |
| `accounts` | Student & Instructor registration, dashboard |
| `courses` | Course creation, lessons (text), categories |
| `enrollments` | Purchase tracking, progress, certificates |

#### 📋 Detailed Feature Requirements

**Instructors can:**
- Register as an instructor (submit bio, expertise, photo)
- Create a course: title, description, category, thumbnail, price, skill level
- Add **lessons** to a course (lesson title, content text, order number)
- Set a course as **Draft** (not visible) or **Published** (available to buy)
- View their **sales dashboard** — number of students enrolled, total revenue
- Apply a discount coupon (percentage off) to a course

**Students can:**
- Browse all published courses, filter by category and price range
- View a course preview (title, description, instructor info, lesson count)
- **Purchase** a course (simulated — sets `is_enrolled = True`)
- Access all lessons once enrolled
- Mark lessons as **completed**
- View a progress bar (e.g., 4/10 lessons completed)
- Download a **completion certificate** (a simple styled HTML page) once all lessons done

**REST API (DRF):**
- `GET /api/courses/` — list all published courses
- `GET /api/courses/{id}/lessons/` — course lessons (JWT required, must be enrolled)
- `POST /api/enrollments/` — enroll in a course (JWT required)
- `GET /api/my-courses/` — student's enrolled courses

#### 🗃️ Key Models
```
Category → Course → Lesson → Enrollment → LessonProgress → Instructor
```

#### 🎯 Monetization Simulation
- `Course.price` field (can be 0 for free courses)
- `Enrollment.payment_status` field (`pending`, `paid`, `refunded`)
- Platform auto-calculates `instructor_earning = price * 0.70`
- Coupon model: `code`, `discount_percentage`, `max_uses`, `times_used`

---

## 👩‍💻 Student 4 — Ekike

### 📦 Project: **RentEase** — House & Apartment Rental Platform

#### 🌍 Real-World Problem
Finding an apartment to rent in Nigerian cities (Lagos, Abuja, PH) is a nightmare — fake listings, no photos, brokers charging excessive fees. **RentEase** is a transparent rental platform where verified landlords list properties and tenants can search, view photos, and contact landlords — no brokers, no wahala.

#### 💰 Monetization Model — Pay-Per-Listing + Featured Ads
- Landlords pay **₦2,000 per listing** (valid for 90 days)
- **Featured Listing** upgrade: ₦5,000/month — property appears at top of search with a "Featured" badge
- **Verified Badge**: ₦3,000 one-time fee — landlord gets a checkmark after ID verification
- Tenants use the platform free

#### 🗂️ Apps to Build

| App | Responsibility |
|-----|---------------|
| `core` | Homepage, search bar, about, contact |
| `accounts` | Landlord & Tenant registration, profiles, dashboard |
| `properties` | Property listings, photos, amenities, location |
| `inquiries` | Tenant sends inquiry message, landlord replies |

#### 📋 Detailed Feature Requirements

**Landlords can:**
- Register and create a landlord profile (name, phone, NIN — simulated)
- List a property: title, description, type (flat/duplex/self-contain/bungalow), state, area, price, bedrooms, bathrooms
- Upload up to **5 photos** of the property (using Pillow/ImageField)
- Mark property as **Available** or **Taken**
- Set amenities: tick checkboxes (Running Water, NEPA, Borehole, Security, Parking, POP Ceiling)
- View all inquiries from tenants for each property
- Reply to inquiries

**Tenants can:**
- Browse all available properties
- Filter by **state, property type, price range, number of bedrooms**
- View property detail page with photo gallery and location description
- Send an inquiry (name, email, message, phone) to a landlord
- Save properties to a **Wishlist** (logged-in users)

**REST API (DRF):**
- `GET /api/properties/` — list properties with filtering
- `GET /api/properties/{id}/` — property detail
- `POST /api/inquiries/` — send inquiry (JWT required)
- `GET /api/landlord/properties/` — landlord's own listings (JWT required)

#### 🗃️ Key Models
```
LandlordProfile → Property → PropertyPhoto → Amenity → Inquiry → Wishlist
```

#### 🎯 Monetization Simulation
- `Property.listing_status` field: `draft`, `active`, `expired`, `featured`
- `Property.expires_at` — DateTimeField (set 90 days from creation)
- `LandlordProfile.is_verified` — Boolean (manually set by admin)
- Properties with `listing_status='expired'` are hidden from search

---

## 👨‍💻 Student 5 — Godspower

### 📦 Project: **QuickDeliver** — Last-Mile Package Delivery Tracker

#### 🌍 Real-World Problem
Small businesses in Nigeria send packages through dispatch riders with no tracking system — buyers are left calling and wondering "where is my order?". **QuickDeliver** is a platform where businesses log deliveries, assign riders, and customers track their package in real-time with a tracking code — a mini DHL for Nigerian SMEs.

#### 💰 Monetization Model — Pay-As-You-Go + Subscription
- **Basic**: ₦300 per shipment logged (individual senders)
- **Business Plan**: ₦15,000/month for up to 150 shipments/month (SMEs)
- **Enterprise Plan**: ₦40,000/month — unlimited shipments + API access
- Riders are independent contractors, not employees

#### 🗂️ Apps to Build

| App | Responsibility |
|-----|---------------|
| `core` | Homepage, tracking search bar, about, pricing page |
| `accounts` | Business & Rider registration, dashboard |
| `shipments` | Package creation, assignment, delivery status updates |
| `tracking` | Public-facing tracking page (no login required) |

#### 📋 Detailed Feature Requirements

**Business Owners can:**
- Register and create a business profile (business name, address, phone)
- Create a shipment: sender name, receiver name, receiver address, receiver phone, description, weight
- System auto-generates a **unique tracking code** (e.g., `QD-2024-ABC123`)
- Assign a shipment to an available rider
- View all their shipments and current status

**Riders can:**
- Register as a delivery rider (name, phone, vehicle type, plate number)
- See **assigned deliveries** in their dashboard
- Update delivery status: `Picked Up → In Transit → Delivered / Failed Delivery`
- Add a note when updating (e.g., "Customer not at home")

**Anyone (no login) can:**
- Visit `/track/` and enter a tracking code
- See the full delivery timeline — each status update with timestamp

**REST API (DRF):**
- `POST /api/shipments/` — create a shipment (JWT required)
- `GET /api/shipments/{tracking_code}/` — get status (public, no auth)
- `PATCH /api/shipments/{tracking_code}/status/` — rider updates status (JWT)
- `GET /api/riders/available/` — list available riders (JWT required)

#### 🗃️ Key Models
```
BusinessProfile → Rider → Shipment → TrackingEvent → StatusUpdate
```

#### 🎯 Monetization Simulation
- `BusinessProfile.plan` field: `pay_as_you_go`, `business`, `enterprise`
- `BusinessProfile.shipment_credits` — integer that decrements per shipment
- When credits hit 0, new shipment creation is blocked with a message: "Upgrade your plan to continue"
- `Shipment.tracking_code` — auto-generated in `save()` method using `uuid` or `secrets`

---

## 👩‍💻 Student 6 — Miracle

### 📦 Project: **EduAlert** — School Result & Notification Portal

#### 🌍 Real-World Problem
Schools in Nigeria send results home via paper (or not at all). Parents have no idea how their child is performing until term end. **EduAlert** is a school management portal where teachers upload student results, and parents/guardians can view their ward's results, attendance records, and school notifications — all online and real-time.

#### 💰 Monetization Model — Subscription Per School
- Schools pay a monthly or termly subscription:
  - **Starter** (up to 100 students): ₦8,000/month
  - **Standard** (up to 500 students): ₦25,000/month
  - **Enterprise** (unlimited): ₦60,000/month
- Parents access the portal **free** using a unique student PIN provided by the school
- Schools can send SMS alerts (simulated) — included in Standard & Enterprise plans

#### 🗂️ Apps to Build

| App | Responsibility |
|-----|---------------|
| `core` | Landing page, features, pricing page, contact |
| `accounts` | School admin, teacher, and parent registration |
| `students` | Student profiles, class assignment, parent linking |
| `results` | Subject results, term reports, attendance, notifications |

#### 📋 Detailed Feature Requirements

**School Admins can:**
- Register the school (name, address, type: Primary/Secondary/University)
- Create classes (e.g., JSS1A, SS2B, Year 3)
- Add students to classes (name, DOB, student ID, gender)
- Generate a unique **parent access PIN** per student
- Add teachers and assign them to classes/subjects
- Send a school-wide **announcement** (shows on all parent dashboards)
- View the school subscription tier and student count

**Teachers can:**
- Log in and see their assigned classes
- Enter **subject scores** for each student (CA1, CA2, Exam, Total, Grade, Remark)
- Mark **attendance** (Present / Absent / Late) per student per day
- View the full class result sheet

**Parents can:**
- Log in using their child's **PIN** (no need to register separately)
- View their child's results by term
- See **attendance record** (days present/absent)
- Read school announcements
- View academic performance trend (simple table showing improvement/decline per term)

**REST API (DRF):**
- `GET /api/students/{pin}/results/` — get student result by PIN (JWT)
- `POST /api/results/` — teacher submits results (JWT required)
- `GET /api/attendance/{class_id}/` — class attendance (JWT required)
- `GET /api/announcements/` — school announcements

#### 🗃️ Key Models
```
School → Class → Student → Subject → Result → AttendanceRecord → Announcement → ParentAccess
```

#### 🎯 Monetization Simulation
- `School.plan` field: `starter`, `standard`, `enterprise`
- `School.student_limit` property — returns 100, 500, or `None` based on plan
- Attempting to add a student beyond the limit shows an upgrade prompt
- `School.plan_expires_at` — DateTimeField; expired schools see a "Subscription Expired" banner

---

## 👨‍💻 Student 7 — Userie

### 📦 Project: **StoreFront** — Multi-Vendor E-Commerce Platform

#### 🌍 Real-World Problem
Small shop owners in Nigeria can't afford to build their own e-commerce website. They sell on Instagram and WhatsApp without any professional presence. **StoreFront** allows any small business to open their own mini online store in minutes — with a storefront page, product listings, and a simple checkout — all under one umbrella platform, similar to a local Shopify.

#### 💰 Monetization Model — Subscription (SaaS)
- Vendors subscribe to keep their store active:
  - **Free Store**: 5 products max, no custom domain, platform branding shown
  - **Starter** (₦5,000/month): 50 products, custom store URL (e.g., `/store/amaka-fashion/`)
  - **Pro** (₦15,000/month): unlimited products, no platform branding, analytics dashboard
- Platform takes a **3% transaction fee** on every sale (simulated)

#### 🗂️ Apps to Build

| App | Responsibility |
|-----|---------------|
| `core` | Platform homepage, vendor signup CTA, featured stores |
| `accounts` | Vendor & Customer registration, dashboard |
| `stores` | Store creation, store profile, store page |
| `products` | Product listings, categories, inventory |
| `orders` | Cart, checkout, order history |

#### 📋 Detailed Feature Requirements

**Vendors can:**
- Register and create a store (store name, description, category, logo, banner)
- Add products: name, description, price, stock quantity, category, photo
- Manage product inventory (mark as **In Stock / Out of Stock**)
- View all orders placed in their store
- Mark orders as **Processing → Shipped → Delivered**
- View a simple **sales summary** (total orders, total revenue, pending orders)
- Their store is accessible at `/store/<store-slug>/`

**Customers can:**
- Browse the platform homepage (shows all active stores and featured products)
- Visit a specific vendor's storefront page
- Filter products by **category and price range**
- Add products to a **shopping cart** (session-based or DB-based)
- Place an order (fills in name, address, phone number — no payment gateway needed)
- View their **order history** and current order status

**REST API (DRF):**
- `GET /api/stores/` — list all active stores
- `GET /api/stores/{slug}/products/` — products in a specific store
- `POST /api/orders/` — place an order (JWT required)
- `GET /api/my-orders/` — customer order history (JWT required)
- `PATCH /api/orders/{id}/status/` — vendor updates order status (JWT required)

#### 🗃️ Key Models
```
VendorProfile → Store → Category → Product → Cart → CartItem → Order → OrderItem
```

#### 🎯 Monetization Simulation
- `Store.plan` field: `free`, `starter`, `pro`
- Free plan: only 5 products visible, extra products saved but marked `hidden=True`
- `Store.is_active` — Boolean; expired subscription = `is_active = False`, store goes offline
- `Order.platform_fee` = 3% of order total (auto-calculated in `save()`)
- Pro stores have `show_branding = False`, free stores show "Powered by StoreFront" banner

---

## 📅 Submission Requirements (All Students)

| Requirement | Detail |
|-------------|--------|
| **GitHub Repo** | Public repository with descriptive README |
| **README.md** | Setup instructions, features list, screenshots |
| **Models** | At least 5 Django models with proper relationships |
| **Auth** | Login, Register, Dashboard (per user role) |
| **REST API** | Minimum 3 DRF endpoints with JWT protection |
| **Admin Panel** | Key models registered and manageable in Django Admin |
| **Monetization** | At least one pricing tier or transaction fee simulated in the database |
| **Deadline** | To be announced by instructor |

---

## 🏆 Grading Rubric

| Category | Max Score | Notes |
|----------|-----------|-------|
| Project Setup & Structure | 10 | Clean apps, settings, requirements.txt |
| Models & Database Design | 20 | Relationships, field choices, logic in `save()` |
| Views & Templates | 20 | Functional pages, forms, user feedback |
| Authentication | 15 | Role-based login, dashboard, permissions |
| REST API | 20 | Working endpoints, JWT, filtering |
| Monetization Logic | 10 | Plan field, limits enforced in code |
| Code Quality & README | 5 | Clean code, documented README |
| **TOTAL** | **100** | |

---

> Pro Tip for Students: Start with your models first. Draw them on paper, identify the relationships (ForeignKey, ManyToMany), then migrate. Everything else — views, templates, APIs — flows from a solid database design.

> Note: The payment flows in these projects are simulated (no real payment gateway). The focus is on the business logic — plan tiers, access control, commission calculations. Real payments (Paystack, Flutterwave) can be integrated as a bonus.
