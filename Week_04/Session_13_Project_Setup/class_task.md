# Session 13 — Lab Task: Build Your First LuxStay Pages

**Time:** 90 minutes | **Work alone**

---

## Your Mission

Build the LuxStay project from scratch. By the end you must have:
- [ ] Django project running without errors
- [ ] Landing page visible at `http://127.0.0.1:8000/`
- [ ] About page at `/about/`
- [ ] Contact page at `/contact/` — form must show a success message when submitted
- [ ] Navigation bar links working on all three pages

---

## Step 1 — Setup (15 min)

1. Create a folder called `LuxStay` in your course folder
2. Open terminal and navigate into it
3. Install packages:
   ```bash
   pip install django djangorestframework djangorestframework-simplejwt django-filter Pillow
   ```
4. Create project:
   ```bash
   django-admin startproject luxstay .
   python manage.py startapp core
   ```

---

## Step 2 — Settings (10 min)

Update `luxstay/settings.py`:
- Add `'rest_framework'` and `'core'` to `INSTALLED_APPS`
- Set `'DIRS': [BASE_DIR / 'templates']` in TEMPLATES
- Add `STATICFILES_DIRS = [BASE_DIR / 'static']` after STATIC_URL

---

## Step 3 — Build Folders and Files (15 min)

Create these folders:
```
templates/
static/css/
core/templates/core/
```

Create these empty files:
```
templates/base.html
static/css/custom.css
core/templates/core/home.html
core/templates/core/about.html
core/templates/core/contact.html
core/urls.py
```

---

## Step 4 — Write the Code (45 min)

Copy code from `course_material.md` in this order:
1. `static/css/custom.css`
2. `templates/base.html`
3. `core/views.py`
4. `core/urls.py`
5. `luxstay/urls.py`
6. `core/templates/core/home.html`
7. `core/templates/core/about.html`
8. `core/templates/core/contact.html`

---

## Step 5 — Run & Test (5 min)

```bash
python manage.py migrate
python manage.py runserver
```

---

## Checklist Before You Finish

- [ ] No error page on any URL
- [ ] Navbar shows correctly on all pages
- [ ] Contact form shows success message on submit
- [ ] Active nav link is highlighted (e.g. "Home" when on `/`)
- [ ] Browser tab title changes per page

---

## Challenge (Advanced Students)

1. Add a **Gallery page** at `/gallery/` with a Bootstrap image grid
2. **Change the colour theme** — swap `#c9a84c` gold to a different luxury colour in `custom.css`
3. Add **social media icons** to the footer: `bi-instagram`, `bi-twitter`, `bi-facebook`
