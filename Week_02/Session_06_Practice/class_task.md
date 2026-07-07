# Class Task: Build the "AptechHub Course Catalog" App

**Objective:** You just built the Student Portal together with your instructor. Now it is YOUR turn to build an almost identical application independently — using everything you have learned from Sessions 1 to 5.

---

## Part 1 — Guided Recap (5 Minutes)
Before you start, complete this checklist in your head. If you can answer all of these, you are ready:

- [ ] I know how to create a virtual environment and activate it
- [ ] I know how to run `startproject` and `startapp`
- [ ] I know how to register an app in `settings.py`
- [ ] I know how to write a `Model` and run `makemigrations` + `migrate`
- [ ] I know how to write a `Function-Based View` and connect it in `urls.py`
- [ ] I know how to write a `Class-Based View (ListView)` and use `.as_view()`
- [ ] I know how to create the correct template folder structure
- [ ] I know how to register a model in `admin.py` with `list_display` and `search_fields`
- [ ] I know how to create a superuser

If you are unsure about any point, refer to the session's `course_material.md` before starting.

---

## Part 2 — Independent Build: "AptechHub Course Catalog"

You will build a Course Catalog app that lets an administrator manage courses offered at AptechHub, and lets visitors browse those courses on the website.

### Task 1 — Project & App Setup (Session 1 & 2 Skills)
1. Create a new virtual environment called `catalog_env` and activate it.
2. Install Django.
3. Create a new Django project called `course_portal`.
4. Inside `course_portal`, create an app called `catalog`.
5. Register `catalog` in `course_portal/settings.py` under `INSTALLED_APPS`.

### Task 2 — Create the Model (Session 2 Skills)
In `catalog/models.py`, create a model called `Course` with these fields:

| Field name | Field type | Notes |
|---|---|---|
| `name` | `CharField` | max_length=200 |
| `instructor` | `CharField` | max_length=100 |
| `duration_weeks` | `IntegerField` | |
| `difficulty` | `CharField` | max_length=50 (e.g., Beginner, Intermediate, Advanced) |
| `description` | `TextField` | optional (blank=True) |

Write a `__str__` method that returns the course name.

Run `makemigrations` and `migrate` after creating the model.

### Task 3 — Admin Panel Setup (Session 4 Skills)
1. Run `python manage.py createsuperuser` and create your admin account.
2. Open `catalog/admin.py` and register the `Course` model.
3. Create a `CourseAdmin` class that:
   - Displays `name`, `instructor`, `duration_weeks`, and `difficulty` in the list view (`list_display`)
   - Adds a search bar for `name` and `instructor` (`search_fields`)
   - Adds a filter sidebar for `difficulty` (`list_filter`)
4. Log into `http://127.0.0.1:8000/admin/` and add at least **5 courses** with different instructors and difficulty levels.

### Task 4 — Function-Based View (Session 5 Skills)
1. In `catalog/views.py`, write a function-based view called `course_list_fbv`.
2. It must fetch all `Course` objects from the database.
3. Pass the data to a template at `catalog/templates/catalog/course_list.html` under the context key `'courses'`.
4. The template must display all courses in a styled HTML table (using a `{% for %}` loop).

### Task 5 — App URL Routing (Session 2 & 5 Skills)
1. Create `catalog/urls.py`.
2. Add a path `'fbv/'` pointing to `course_list_fbv`.
3. Open `course_portal/urls.py` and use `include()` to connect `catalog/urls.py` under the prefix `'catalog/'`.
4. Test by visiting `http://127.0.0.1:8000/catalog/fbv/` — you should see your course list.

### Task 6 — Class-Based View (Session 5 Skills)
1. In `catalog/views.py`, import `ListView` and create a class called `CourseListCBV`.
2. Set `model = Course`, `template_name = 'catalog/course_list.html'`, and `context_object_name = 'courses'`.
3. In `catalog/urls.py`, add a path `'cbv/'` pointing to `CourseListCBV.as_view()`.
4. Test by visiting `http://127.0.0.1:8000/catalog/cbv/` — same data, different view type.

### Task 7 — Home Page (Session 5 TemplateView)
1. Create a `HomeView` using `TemplateView` that renders `catalog/templates/catalog/home.html`.
2. The home page should display a welcome message and have two links — one to the FBV page and one to the CBV page using the `{% url %}` tag.
3. Wire it to the path `''` (empty string) in `catalog/urls.py` so that `http://127.0.0.1:8000/catalog/` shows the home page.

---

## Verification Checklist
Before calling your instructor over, verify these ALL work:

| URL | Expected result |
|---|---|
| `http://127.0.0.1:8000/catalog/` | Home page with 2 links |
| `http://127.0.0.1:8000/catalog/fbv/` | Course list from FBV |
| `http://127.0.0.1:8000/catalog/cbv/` | Same course list from CBV |
| `http://127.0.0.1:8000/admin/` | Admin panel with Courses section visible |
| Admin → Courses | Shows columns: name, instructor, duration_weeks, difficulty |
| Admin search bar | Can search by course name or instructor |
| Admin sidebar | Can filter by difficulty level |

---

## Bonus Challenge (For Fast Finishers)
Add an `ordering` attribute to `CourseAdmin`:
```python
ordering = ('-duration_weeks',)  # sorts longest courses first in admin
```

And add `.order_by('name')` to the queryset in your FBV so courses are displayed alphabetically on the website.

---

## Task 8 — Authorization Levels: Who Can Do What?

You are now going to add user roles and permissions to your **Course Catalog** project, simulating a real school management system.

### The Scenario
| Role | What they can do |
|---|---|
| **Superadmin** (Principal) | Everything — add, edit, delete courses, manage all accounts |
| **Course Manager** | Can edit course details only — cannot delete or add courses |
| **Staff Viewer** | Can only view courses — read-only access |

### Task 8A — Create the Groups in Admin
1. Log into `http://127.0.0.1:8000/admin/` as your superuser.
2. Go to **Authentication and Authorization → Groups**.
3. Create a group called `Course Managers` with these permissions:
   - ✅ `catalog | course | Can view course`
   - ✅ `catalog | course | Can change course`
   - ❌ No add permission
   - ❌ No delete permission
4. Create a second group called `Staff Viewers` with ONLY:
   - ✅ `catalog | course | Can view course`
5. Click **Save** for both groups.

### Task 8B — Create Two New User Accounts
1. Go to **Users → + Add User**
2. Create user `ms_adaeze` — add to `Course Managers`, Staff status ✅, Superuser ❌
3. Create user `mr_emeka` — add to `Staff Viewers`, Staff status ✅, Superuser ❌

### Task 8C — Test the Permission Difference
1. Open a **private/incognito browser window**.
2. Log in as `ms_adaeze` and go to Admin → Courses:
   - ✅ She should see courses and be able to edit them
   - ❌ She should NOT see a delete button on any course
3. Open a **second incognito window** and log in as `mr_emeka`:
   - ✅ He can view courses
   - ❌ No edit or delete buttons visible
4. Log back into your **original browser** as the superuser — you see everything.

### Task 8D — Add Permission Decorators to Your Views
Open `catalog/views.py` and add these imports and decorators:

```python
from django.contrib.auth.decorators import login_required, permission_required

# Protect the FBV — user must be logged in
@login_required
def course_list_fbv(request):
    courses = Course.objects.all().order_by('name')
    return render(request, 'catalog/course_list.html', {
        'courses': courses,
        'view_type': 'Function-Based View'
    })
```

Test: log out of the admin panel and try to visit `http://127.0.0.1:8000/catalog/fbv/` — you should be redirected to a login page.

### Task 8E — Conditional Buttons in the Template
Open `catalog/templates/catalog/course_list.html` and add action buttons inside your `{% for course in courses %}` loop:

```html
<td>
    {% if request.user.has_perm('catalog.change_course') %}
        <button style="background:#3498db; color:white; padding:4px 8px; border:none;">Edit</button>
    {% endif %}

    {% if request.user.has_perm('catalog.delete_course') %}
        <button style="background:red; color:white; padding:4px 8px; border:none;">Delete</button>
    {% endif %}
</td>
```

### Task 8F — Verification
Log in as each user on the website and verify:

| User | Edit button visible? | Delete button visible? |
|---|---|---|
| `ms_adaeze` (Course Manager) | ✅ Yes | ❌ No |
| `mr_emeka` (Staff Viewer) | ❌ No | ❌ No |
| Superuser | ✅ Yes | ✅ Yes |

Call your instructor over to demonstrate all three logins working correctly!
