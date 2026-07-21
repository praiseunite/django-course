# Session 13: Building LuxStay — Project Setup & Frontend Pages

**Platform:** LuxStay — Hotel & Event Booking Platform
**What you build today:** Full project structure, navigation, Landing page, About page, Contact page

---

## Presenter's Guide

### Session Timing (2 Hours)
| Time | Activity |
|---|---|
| 0:00 – 0:15 | Introduction — explain the platform & what we're building |
| 0:15 – 0:40 | Step 1–3: Install, create project, configure settings |
| 0:40 – 1:00 | Step 4–5: Base template & navigation |
| 1:00 – 1:30 | Step 6–8: Landing, About, Contact pages |
| 1:30 – 1:50 | Step 9: Wire up URLs, run server, view in browser |
| 1:50 – 2:00 | Q&A and recap |

### What to Say at the Start
> *"Today we start building a real-world hotel booking platform called LuxStay. By the end of these four sessions, you will have a complete Django application with a website, user accounts, a booking system, and a REST API — everything a junior developer is expected to know."*

---

## Student Quick Reference

### Project Structure We Are Building
```
LuxStay/                    <- Your project folder
├── manage.py
├── requirements.txt
├── db.sqlite3              <- auto-created after migrations
├── luxstay/                <- project config package
│   ├── __init__.py
│   ├── settings.py
│   ├── urls.py
│   └── wsgi.py
├── core/                   <- app for shared pages (home, about, contact)
│   ├── __init__.py
│   ├── apps.py
│   ├── views.py
│   ├── urls.py
│   └── templates/
│       └── core/
│           ├── home.html
│           ├── about.html
│           └── contact.html
├── templates/
│   └── base.html           <- shared layout (nav + footer)
└── static/
    └── css/
        └── custom.css      <- our own styles
```

---

## Step 1 — Install Django and Create the Project

> Open your terminal. Make sure you are in the folder where you want to create the project.

```bash
# Install Django and all packages we need for the whole course
pip install django djangorestframework djangorestframework-simplejwt django-filter Pillow

# Create the Django project (the dot means "in current folder")
django-admin startproject luxstay .

# Create our first app — core (handles home, about, contact pages)
python manage.py startapp core
```

> Check: You should now see a `manage.py` file and a `luxstay/` folder.

---

## Step 2 — Create `requirements.txt`

> "This file lists all the packages our project needs. Any developer can run one command to install everything."

Create a new file called `requirements.txt` in the root folder:

```
Django>=5.0
djangorestframework>=3.15
djangorestframework-simplejwt>=5.3
django-filter>=24.0
Pillow>=10.0
```

> To install from this file: `pip install -r requirements.txt`

---

## Step 3 — Configure `settings.py`

Open `luxstay/settings.py`. Make these changes:

### 3a — Register all apps

Find `INSTALLED_APPS` and update it:

```python
INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',

    # Third-party packages
    'rest_framework',
    'rest_framework_simplejwt',
    'django_filters',

    # Our apps
    'core',
]
```

> WARN students: "Don't forget the comma after each app name — a missing comma is a very common error."

### 3b — Configure Templates directory

Find `'DIRS': []` and change it to:

```python
'DIRS': [BASE_DIR / 'templates'],
```

### 3c — Add Static & Media file settings

After `STATIC_URL = '/static/'`, add:

```python
STATICFILES_DIRS = [BASE_DIR / 'static']

MEDIA_URL = '/media/'
MEDIA_ROOT = BASE_DIR / 'media'
```

### 3d — Add Login redirect settings

At the bottom of settings.py, add:

```python
LOGIN_URL = '/accounts/login/'
LOGIN_REDIRECT_URL = '/accounts/dashboard/'
LOGOUT_REDIRECT_URL = '/'
```

### 3e — Add DRF settings

```python
REST_FRAMEWORK = {
    'DEFAULT_AUTHENTICATION_CLASSES': [
        'rest_framework_simplejwt.authentication.JWTAuthentication',
        'rest_framework.authentication.SessionAuthentication',
    ],
    'DEFAULT_PERMISSION_CLASSES': [
        'rest_framework.permissions.IsAuthenticatedOrReadOnly',
    ],
    'DEFAULT_FILTER_BACKENDS': [
        'django_filters.rest_framework.DjangoFilterBackend',
        'rest_framework.filters.SearchFilter',
    ],
}
```

---

## Step 4 — Create the Folder Structure

```bash
mkdir templates
mkdir static
mkdir static\css
mkdir core\templates
mkdir core\templates\core
```

---

## Step 5 — Build the Base Template (Shared Navigation)

> "Every page on LuxStay uses this one base template. It has the nav bar and footer.
> Every other page just fills in the middle `block content` section."

Create `templates/base.html`:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{% block title %}LuxStay — Premium Hotel & Events{% endblock %}</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">

    {% load static %}
    <link rel="stylesheet" href="{% static 'css/custom.css' %}">

    {% block extra_css %}{% endblock %}
</head>
<body>

<!-- NAVIGATION -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNav">
    <div class="container">
        <a class="navbar-brand fw-bold fs-4" href="/">
            <i class="bi bi-building me-2"></i>LuxStay
        </a>
        <button class="navbar-toggler" type="button"
                data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link {% if request.path == '/' %}active{% endif %}" href="/">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link {% if '/rooms' in request.path %}active{% endif %}" href="/rooms/">Rooms</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link {% if '/events' in request.path %}active{% endif %}" href="/events/">Events</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link {% if '/about' in request.path %}active{% endif %}" href="/about/">About</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link {% if '/contact' in request.path %}active{% endif %}" href="/contact/">Contact</a>
                </li>
            </ul>
            <ul class="navbar-nav">
                {% if user.is_authenticated %}
                    <li class="nav-item">
                        <a class="nav-link" href="/accounts/dashboard/">
                            <i class="bi bi-person-circle me-1"></i>{{ user.first_name|default:user.username }}
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/accounts/logout/">Logout</a>
                    </li>
                {% else %}
                    <li class="nav-item">
                        <a class="nav-link" href="/accounts/login/">Login</a>
                    </li>
                    <li class="nav-item">
                        <a class="btn btn-gold ms-2" href="/accounts/register/">Register</a>
                    </li>
                {% endif %}
            </ul>
        </div>
    </div>
</nav>

<!-- FLASH MESSAGES -->
{% if messages %}
<div class="container mt-5 pt-4">
    {% for message in messages %}
        <div class="alert alert-{{ message.tags|default:'info' }} alert-dismissible fade show" role="alert">
            {{ message }}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    {% endfor %}
</div>
{% endif %}

<!-- PAGE CONTENT -->
{% block content %}
{% endblock %}

<!-- FOOTER -->
<footer class="footer-dark py-5 mt-5">
    <div class="container">
        <div class="row g-4">
            <div class="col-md-4">
                <h5 class="text-white fw-bold mb-3">
                    <i class="bi bi-building me-2"></i>LuxStay
                </h5>
                <p class="text-muted">Premium hotel and event experiences. Where every stay becomes a memory.</p>
            </div>
            <div class="col-md-2">
                <h6 class="text-white mb-3">Explore</h6>
                <ul class="list-unstyled">
                    <li><a href="/rooms/" class="footer-link">Rooms</a></li>
                    <li><a href="/events/" class="footer-link">Events</a></li>
                    <li><a href="/about/" class="footer-link">About</a></li>
                </ul>
            </div>
            <div class="col-md-2">
                <h6 class="text-white mb-3">Account</h6>
                <ul class="list-unstyled">
                    <li><a href="/accounts/register/" class="footer-link">Register</a></li>
                    <li><a href="/accounts/login/" class="footer-link">Login</a></li>
                    <li><a href="/accounts/dashboard/" class="footer-link">Dashboard</a></li>
                </ul>
            </div>
            <div class="col-md-4">
                <h6 class="text-white mb-3">Contact</h6>
                <p class="text-muted mb-1"><i class="bi bi-geo-alt me-2"></i>123 Luxury Avenue, Lagos</p>
                <p class="text-muted mb-1"><i class="bi bi-telephone me-2"></i>+234 800 000 0000</p>
                <p class="text-muted"><i class="bi bi-envelope me-2"></i>hello@luxstay.com</p>
            </div>
        </div>
        <hr class="border-secondary mt-4">
        <p class="text-center text-muted mb-0">© 2024 LuxStay. Built with Django & DRF.</p>
    </div>
</footer>

<!-- Bootstrap 5 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Navbar becomes solid on scroll
    window.addEventListener('scroll', function () {
        const nav = document.getElementById('mainNav');
        if (window.scrollY > 50) {
            nav.classList.add('navbar-scrolled');
        } else {
            nav.classList.remove('navbar-scrolled');
        }
    });
</script>
{% block extra_js %}{% endblock %}
</body>
</html>
```

> Point out to students:
> - `{% block content %}` — each page puts its unique HTML here
> - `{% if user.is_authenticated %}` — Django knows if user is logged in automatically
> - `{% load static %}` — must be at top to use `{% static %}` tags

---

## Step 6 — Create the Custom CSS

Create `static/css/custom.css`:

```css
/* ===== GOOGLE FONTS ===== */
body {
    font-family: 'Inter', sans-serif;
    color: #2d2d2d;
}
h1, h2, h3, .navbar-brand {
    font-family: 'Playfair Display', serif;
}

/* ===== COLOUR VARIABLES ===== */
:root {
    --gold: #c9a84c;
    --gold-dark: #a8873a;
    --dark: #1a1a2e;
    --dark-2: #16213e;
    --light-bg: #f8f6f0;
}

/* ===== NAVIGATION ===== */
#mainNav {
    background: transparent;
    transition: background 0.4s ease, box-shadow 0.4s ease;
    padding: 1rem 0;
}
#mainNav.navbar-scrolled {
    background: var(--dark) !important;
    box-shadow: 0 2px 20px rgba(0,0,0,0.3);
    padding: 0.5rem 0;
}
.navbar-nav .nav-link {
    font-weight: 500;
    letter-spacing: 0.3px;
    padding: 0.5rem 1rem !important;
    transition: color 0.2s;
}
.navbar-nav .nav-link:hover,
.navbar-nav .nav-link.active {
    color: var(--gold) !important;
}

/* ===== GOLD BUTTON ===== */
.btn-gold {
    background: var(--gold);
    color: #fff;
    border: none;
    padding: 0.5rem 1.4rem;
    border-radius: 4px;
    font-weight: 600;
    transition: background 0.3s, transform 0.2s;
    text-decoration: none;
    display: inline-block;
}
.btn-gold:hover {
    background: var(--gold-dark);
    color: #fff;
    transform: translateY(-2px);
}

/* ===== HERO SECTION ===== */
.hero-section {
    min-height: 100vh;
    background: linear-gradient(135deg, var(--dark) 0%, var(--dark-2) 50%, #0f3460 100%);
    display: flex;
    align-items: center;
    position: relative;
    overflow: hidden;
}
.hero-content { position: relative; z-index: 2; }

.hero-badge {
    display: inline-block;
    background: rgba(201, 168, 76, 0.2);
    color: var(--gold);
    border: 1px solid rgba(201, 168, 76, 0.4);
    padding: 0.4rem 1.2rem;
    border-radius: 20px;
    font-size: 0.85rem;
    font-weight: 600;
    letter-spacing: 1px;
    text-transform: uppercase;
    margin-bottom: 1.5rem;
}
.hero-title {
    font-size: clamp(2.5rem, 6vw, 4.5rem);
    color: #fff;
    line-height: 1.1;
    margin-bottom: 1.5rem;
}
.hero-title .gold-text { color: var(--gold); }
.hero-subtitle {
    font-size: 1.15rem;
    color: rgba(255,255,255,0.75);
    max-width: 500px;
    line-height: 1.7;
    margin-bottom: 2.5rem;
}

/* ===== STATS ===== */
.stats-section {
    background: var(--dark);
    padding: 3rem 0;
}
.stat-item { text-align: center; padding: 1.5rem; }
.stat-number {
    font-size: 2.5rem;
    font-weight: 700;
    color: var(--gold);
    font-family: 'Playfair Display', serif;
}
.stat-label {
    color: rgba(255,255,255,0.6);
    font-size: 0.9rem;
    text-transform: uppercase;
    letter-spacing: 1px;
}

/* ===== SECTION HEADINGS ===== */
.section-title {
    font-size: 2.2rem;
    font-weight: 700;
    color: var(--dark);
}
.section-subtitle { color: #888; font-size: 1rem; margin-bottom: 3rem; }
.gold-divider {
    width: 60px;
    height: 3px;
    background: var(--gold);
    margin: 1rem auto 1.5rem;
}

/* ===== FEATURE CARDS ===== */
.feature-card {
    background: #fff;
    border-radius: 12px;
    padding: 2.5rem 2rem;
    box-shadow: 0 4px 20px rgba(0,0,0,0.07);
    transition: transform 0.3s, box-shadow 0.3s;
    height: 100%;
    border-bottom: 3px solid transparent;
}
.feature-card:hover {
    transform: translateY(-8px);
    box-shadow: 0 12px 40px rgba(0,0,0,0.12);
    border-bottom-color: var(--gold);
}
.feature-icon {
    width: 64px;
    height: 64px;
    background: linear-gradient(135deg, var(--gold), var(--gold-dark));
    border-radius: 16px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.8rem;
    color: #fff;
    margin-bottom: 1.5rem;
}

/* ===== ROOM CARDS ===== */
.room-card {
    border: none;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 4px 20px rgba(0,0,0,0.08);
    transition: transform 0.3s, box-shadow 0.3s;
}
.room-card:hover {
    transform: translateY(-6px);
    box-shadow: 0 16px 40px rgba(0,0,0,0.15);
}
.room-card img { height: 220px; object-fit: cover; width: 100%; }
.room-price { font-size: 1.4rem; font-weight: 700; color: var(--gold); }
.badge-room-type {
    background: var(--gold);
    color: #fff;
    font-size: 0.75rem;
    padding: 0.3rem 0.8rem;
    border-radius: 20px;
}

/* ===== FORMS ===== */
.form-control:focus, .form-select:focus {
    border-color: var(--gold);
    box-shadow: 0 0 0 0.2rem rgba(201, 168, 76, 0.25);
}

/* ===== PAGE HERO (inner pages) ===== */
.page-hero {
    background: linear-gradient(135deg, var(--dark) 0%, var(--dark-2) 100%);
    padding: 8rem 0 4rem;
}
.page-hero h1 { color: #fff; font-size: 2.8rem; }
.page-hero p { color: rgba(255,255,255,0.7); font-size: 1.1rem; }

/* ===== ABOUT PAGE ===== */
.team-card {
    text-align: center;
    padding: 2rem;
    border-radius: 12px;
    background: #fff;
    box-shadow: 0 4px 20px rgba(0,0,0,0.07);
    transition: transform 0.3s;
}
.team-card:hover { transform: translateY(-6px); }
.team-avatar {
    width: 90px;
    height: 90px;
    background: linear-gradient(135deg, var(--gold), var(--gold-dark));
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 2rem;
    color: #fff;
    margin: 0 auto 1rem;
}

/* ===== CONTACT PAGE ===== */
.contact-info-card {
    background: var(--dark);
    border-radius: 12px;
    padding: 2.5rem;
    height: 100%;
}
.contact-info-item {
    display: flex;
    align-items: flex-start;
    gap: 1rem;
    margin-bottom: 2rem;
}
.contact-info-icon {
    width: 48px;
    height: 48px;
    background: rgba(201, 168, 76, 0.2);
    border-radius: 10px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: var(--gold);
    font-size: 1.3rem;
    flex-shrink: 0;
}

/* ===== FOOTER ===== */
.footer-dark { background: var(--dark); }
.footer-link {
    color: rgba(255,255,255,0.5);
    text-decoration: none;
    display: block;
    padding: 0.2rem 0;
    transition: color 0.2s;
}
.footer-link:hover { color: var(--gold); }

/* ===== UTILITY ===== */
.bg-light-gold { background: var(--light-bg); }
.text-gold { color: var(--gold) !important; }
.border-gold { border-color: var(--gold) !important; }
```

---

## Step 7 — Build the `core` App

### 7a — `core/views.py`

```python
from django.shortcuts import render, redirect
from django.contrib import messages
from django import forms


class ContactForm(forms.Form):
    name = forms.CharField(max_length=100)
    email = forms.EmailField()
    subject = forms.CharField(max_length=200)
    message = forms.CharField(widget=forms.Textarea)


def home(request):
    return render(request, 'core/home.html')


def about(request):
    return render(request, 'core/about.html')


def contact(request):
    if request.method == 'POST':
        form = ContactForm(request.POST)
        if form.is_valid():
            messages.success(request, 'Thank you! We will get back to you within 24 hours.')
            return redirect('contact')
    else:
        form = ContactForm()
    return render(request, 'core/contact.html', {'form': form})
```

### 7b — Create `core/urls.py`

```python
from django.urls import path
from . import views

urlpatterns = [
    path('', views.home, name='home'),
    path('about/', views.about, name='about'),
    path('contact/', views.contact, name='contact'),
]
```

### 7c — Update `luxstay/urls.py`

```python
from django.contrib import admin
from django.urls import path, include
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include('core.urls')),
]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
```

---

## Step 8 — Build the Page Templates

### 8a — `core/templates/core/home.html`

```html
{% extends 'base.html' %}
{% block title %}LuxStay — Premium Hotel & Event Booking{% endblock %}

{% block content %}

<!-- HERO -->
<section class="hero-section">
    <div class="container hero-content py-5">
        <div class="row align-items-center min-vh-100">
            <div class="col-lg-6">
                <div class="hero-badge">⭐ #1 Luxury Hotel Platform</div>
                <h1 class="hero-title">
                    Experience <span class="gold-text">Luxury</span><br>
                    Like Never Before
                </h1>
                <p class="hero-subtitle">
                    Discover handpicked premium rooms and exclusive events.
                    From business stays to dream getaways — LuxStay delivers
                    extraordinary experiences every time.
                </p>
                <div class="d-flex gap-3 flex-wrap">
                    <a href="/rooms/" class="btn-gold btn btn-lg px-4">
                        <i class="bi bi-door-open me-2"></i>Browse Rooms
                    </a>
                    <a href="/events/" class="btn btn-outline-light btn-lg px-4">
                        <i class="bi bi-calendar-event me-2"></i>View Events
                    </a>
                </div>
            </div>
            <div class="col-lg-6 text-center d-none d-lg-block">
                <div class="p-4">
                    <div class="bg-white bg-opacity-10 rounded-3 p-4 text-white border border-white border-opacity-25">
                        <i class="bi bi-building display-1 text-warning"></i>
                        <h3 class="mt-3">LuxStay Hotel</h3>
                        <p class="text-white-50">Lagos • Abuja • Port Harcourt</p>
                        <div class="row text-center mt-3">
                            <div class="col-4">
                                <div class="text-warning fw-bold fs-4">50+</div>
                                <small class="text-white-50">Rooms</small>
                            </div>
                            <div class="col-4">
                                <div class="text-warning fw-bold fs-4">4.9</div>
                                <small class="text-white-50">Rating</small>
                            </div>
                            <div class="col-4">
                                <div class="text-warning fw-bold fs-4">24/7</div>
                                <small class="text-white-50">Service</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- STATS -->
<section class="stats-section">
    <div class="container">
        <div class="row">
            <div class="col-6 col-md-3">
                <div class="stat-item">
                    <div class="stat-number">500+</div>
                    <div class="stat-label">Happy Guests</div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="stat-item">
                    <div class="stat-number">50+</div>
                    <div class="stat-label">Luxury Rooms</div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="stat-item">
                    <div class="stat-number">30+</div>
                    <div class="stat-label">Events Hosted</div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="stat-item">
                    <div class="stat-number">4.9★</div>
                    <div class="stat-label">Average Rating</div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- FEATURES -->
<section class="py-5 bg-light-gold">
    <div class="container">
        <div class="text-center mb-5">
            <h2 class="section-title">Why Choose LuxStay?</h2>
            <div class="gold-divider"></div>
            <p class="section-subtitle">Everything you need for a perfect stay</p>
        </div>
        <div class="row g-4">
            <div class="col-md-4">
                <div class="feature-card">
                    <div class="feature-icon"><i class="bi bi-shield-check"></i></div>
                    <h5 class="fw-bold mb-2">Secure Booking</h5>
                    <p class="text-muted mb-0">Your reservations are protected with industry-standard security and instant confirmation.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-card">
                    <div class="feature-icon"><i class="bi bi-star"></i></div>
                    <h5 class="fw-bold mb-2">Premium Rooms</h5>
                    <p class="text-muted mb-0">Carefully curated luxury rooms from standard suites to presidential penthouse experiences.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-card">
                    <div class="feature-icon"><i class="bi bi-headset"></i></div>
                    <h5 class="fw-bold mb-2">24/7 Support</h5>
                    <p class="text-muted mb-0">Our dedicated concierge team is available around the clock to make your stay perfect.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-card">
                    <div class="feature-icon"><i class="bi bi-calendar-event"></i></div>
                    <h5 class="fw-bold mb-2">Exclusive Events</h5>
                    <p class="text-muted mb-0">From corporate conferences to dream weddings — we host it all with elegance.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-card">
                    <div class="feature-icon"><i class="bi bi-phone"></i></div>
                    <h5 class="fw-bold mb-2">Easy Booking</h5>
                    <p class="text-muted mb-0">Book in minutes from any device. Our REST API powers lightning-fast availability checks.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-card">
                    <div class="feature-icon"><i class="bi bi-geo-alt"></i></div>
                    <h5 class="fw-bold mb-2">Prime Locations</h5>
                    <p class="text-muted mb-0">Properties in Lagos, Abuja, and Port Harcourt — in the heart of where things happen.</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- CTA -->
<section class="py-5" style="background: linear-gradient(135deg, #1a1a2e, #16213e);">
    <div class="container text-center py-3">
        <h2 class="text-white mb-3" style="font-family: 'Playfair Display', serif;">
            Ready for an Extraordinary Stay?
        </h2>
        <p class="text-white-50 mb-4">Join hundreds of satisfied guests. Sign up free today.</p>
        <a href="/accounts/register/" class="btn-gold btn btn-lg px-5">
            Get Started — It's Free
        </a>
    </div>
</section>

{% endblock %}
```

### 8b — `core/templates/core/about.html`

```html
{% extends 'base.html' %}
{% block title %}About Us — LuxStay{% endblock %}

{% block content %}

<section class="page-hero">
    <div class="container text-center">
        <h1>About <span style="color: #c9a84c;">LuxStay</span></h1>
        <div class="gold-divider"></div>
        <p>Our story, our mission, and the team behind the luxury</p>
    </div>
</section>

<section class="py-5">
    <div class="container">
        <div class="row align-items-center g-5">
            <div class="col-lg-6">
                <h2 class="section-title">Our Story</h2>
                <div class="gold-divider" style="margin: 1rem 0 1.5rem;"></div>
                <p class="text-muted lead">
                    LuxStay was founded in 2020 with a simple mission: to make luxury
                    accommodation accessible, seamless, and memorable for every guest.
                </p>
                <p class="text-muted">
                    What started as a small boutique hotel in Lagos has grown into a
                    premier platform offering premium rooms and exclusive events across
                    Nigeria's major cities.
                </p>
                <p class="text-muted">
                    Today, LuxStay serves over 500 guests monthly and has hosted more
                    than 30 major events — from international conferences to destination weddings.
                </p>
            </div>
            <div class="col-lg-6">
                <div class="row g-3">
                    <div class="col-6">
                        <div class="feature-card text-center">
                            <div class="feature-icon mx-auto"><i class="bi bi-buildings"></i></div>
                            <h4 class="text-gold">2020</h4>
                            <p class="text-muted mb-0 small">Year Founded</p>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="feature-card text-center">
                            <div class="feature-icon mx-auto"><i class="bi bi-people"></i></div>
                            <h4 class="text-gold">500+</h4>
                            <p class="text-muted mb-0 small">Guests Served</p>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="feature-card text-center">
                            <div class="feature-icon mx-auto"><i class="bi bi-geo-alt"></i></div>
                            <h4 class="text-gold">3</h4>
                            <p class="text-muted mb-0 small">Cities</p>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="feature-card text-center">
                            <div class="feature-icon mx-auto"><i class="bi bi-trophy"></i></div>
                            <h4 class="text-gold">4.9★</h4>
                            <p class="text-muted mb-0 small">Guest Rating</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="py-5 bg-light-gold">
    <div class="container">
        <div class="text-center mb-5">
            <h2 class="section-title">Our Values</h2>
            <div class="gold-divider"></div>
        </div>
        <div class="row g-4">
            <div class="col-md-4">
                <div class="feature-card">
                    <div class="feature-icon"><i class="bi bi-heart"></i></div>
                    <h5 class="fw-bold">Guest First</h5>
                    <p class="text-muted">Every decision we make starts with: "Is this the best for our guest?"</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-card">
                    <div class="feature-icon"><i class="bi bi-gem"></i></div>
                    <h5 class="fw-bold">Excellence</h5>
                    <p class="text-muted">We never settle for ordinary. From room design to customer service, we pursue excellence.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-card">
                    <div class="feature-icon"><i class="bi bi-eye"></i></div>
                    <h5 class="fw-bold">Transparency</h5>
                    <p class="text-muted">No hidden fees, no surprises. What you see is exactly what you get — and more.</p>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="py-5">
    <div class="container">
        <div class="text-center mb-5">
            <h2 class="section-title">Meet Our Team</h2>
            <div class="gold-divider"></div>
        </div>
        <div class="row g-4 justify-content-center">
            <div class="col-md-3">
                <div class="team-card">
                    <div class="team-avatar"><i class="bi bi-person"></i></div>
                    <h6 class="fw-bold mt-2">Emeka Okafor</h6>
                    <small class="text-muted">CEO & Founder</small>
                </div>
            </div>
            <div class="col-md-3">
                <div class="team-card">
                    <div class="team-avatar"><i class="bi bi-person"></i></div>
                    <h6 class="fw-bold mt-2">Amina Bello</h6>
                    <small class="text-muted">Head of Operations</small>
                </div>
            </div>
            <div class="col-md-3">
                <div class="team-card">
                    <div class="team-avatar"><i class="bi bi-person"></i></div>
                    <h6 class="fw-bold mt-2">Tunde Adeyemi</h6>
                    <small class="text-muted">Lead Developer</small>
                </div>
            </div>
            <div class="col-md-3">
                <div class="team-card">
                    <div class="team-avatar"><i class="bi bi-person"></i></div>
                    <h6 class="fw-bold mt-2">Ngozi Eze</h6>
                    <small class="text-muted">Guest Relations</small>
                </div>
            </div>
        </div>
    </div>
</section>

{% endblock %}
```

### 8c — `core/templates/core/contact.html`

```html
{% extends 'base.html' %}
{% block title %}Contact Us — LuxStay{% endblock %}

{% block content %}

<section class="page-hero">
    <div class="container text-center">
        <h1>Get In <span style="color: #c9a84c;">Touch</span></h1>
        <div class="gold-divider"></div>
        <p>We'd love to hear from you. Our team responds within 24 hours.</p>
    </div>
</section>

<section class="py-5">
    <div class="container">
        <div class="row g-5">
            <div class="col-lg-4">
                <div class="contact-info-card">
                    <h4 class="text-white mb-4">Contact Information</h4>
                    <div class="contact-info-item">
                        <div class="contact-info-icon"><i class="bi bi-geo-alt-fill"></i></div>
                        <div>
                            <p class="text-white mb-1 fw-semibold">Address</p>
                            <p class="text-muted mb-0">123 Luxury Avenue<br>Victoria Island, Lagos</p>
                        </div>
                    </div>
                    <div class="contact-info-item">
                        <div class="contact-info-icon"><i class="bi bi-telephone-fill"></i></div>
                        <div>
                            <p class="text-white mb-1 fw-semibold">Phone</p>
                            <p class="text-muted mb-0">+234 800 000 0000</p>
                        </div>
                    </div>
                    <div class="contact-info-item">
                        <div class="contact-info-icon"><i class="bi bi-envelope-fill"></i></div>
                        <div>
                            <p class="text-white mb-1 fw-semibold">Email</p>
                            <p class="text-muted mb-0">hello@luxstay.com</p>
                        </div>
                    </div>
                    <div class="contact-info-item mb-0">
                        <div class="contact-info-icon"><i class="bi bi-clock-fill"></i></div>
                        <div>
                            <p class="text-white mb-1 fw-semibold">Hours</p>
                            <p class="text-muted mb-0">Mon–Fri: 8am – 8pm<br>Sat–Sun: 10am – 6pm</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-8">
                <div class="p-4 bg-white rounded-3 shadow-sm">
                    <h4 class="mb-4 fw-bold">Send Us a Message</h4>
                    <form method="POST">
                        {% csrf_token %}
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Your Name</label>
                                <input type="text" name="name" class="form-control form-control-lg"
                                       placeholder="John Doe" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Email Address</label>
                                <input type="email" name="email" class="form-control form-control-lg"
                                       placeholder="john@example.com" required>
                            </div>
                            <div class="col-12">
                                <label class="form-label fw-semibold">Subject</label>
                                <input type="text" name="subject" class="form-control form-control-lg"
                                       placeholder="Booking enquiry, event planning..." required>
                            </div>
                            <div class="col-12">
                                <label class="form-label fw-semibold">Message</label>
                                <textarea name="message" class="form-control" rows="6"
                                          placeholder="Tell us how we can help..." required></textarea>
                            </div>
                            <div class="col-12">
                                <button type="submit" class="btn-gold btn btn-lg px-5">
                                    <i class="bi bi-send me-2"></i>Send Message
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>

{% endblock %}
```

---

## Step 9 — Run & Test

```bash
python manage.py migrate
python manage.py runserver
```

Visit in browser:
- `http://127.0.0.1:8000/` — Landing page
- `http://127.0.0.1:8000/about/` — About page
- `http://127.0.0.1:8000/contact/` — Contact page (test the form — should show success message)

---

## Common Errors & Fixes

| Error | Cause | Fix |
|---|---|---|
| `TemplateDoesNotExist: base.html` | Wrong DIRS in settings | Set `'DIRS': [BASE_DIR / 'templates']` |
| `No module named 'rest_framework'` | Not installed | `pip install djangorestframework` |
| Static files not loading | Missing STATICFILES_DIRS | Add `STATICFILES_DIRS = [BASE_DIR / 'static']` |
| Nav overlaps page content | No padding on first section | Add `min-vh-100` class to hero section |
| `{% load static %}` error | Missing staticfiles in INSTALLED_APPS | Check INSTALLED_APPS has `django.contrib.staticfiles` |

---

## Session Recap

By the end of this session, students have:
- A Django 5 project with proper settings
- Bootstrap 5 navigation that works on all screen sizes
- Landing page with hero, stats, and features sections
- About page with team and values
- Contact page with a working form and flash message
- Custom CSS with a gold/dark luxury theme

**Next Session:** Django models, Admin panel, Rooms listing, and Events pages.
