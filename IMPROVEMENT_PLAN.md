# Course Improvement Plan: Django Module (Sessions 2–12)

**Reviewer:** Claude Code  
**Date:** 2026-06-29  
**Reference:** Official Aptech Presenter's Manual — Web Framework for Python (Django) v1.0  

---

## How the Sessions Map to the Official Syllabus

The generated files match the official Aptech structure exactly:

| Your Session | Official Label | Official Book Session | Topic |
|---|---|---|---|
| Session 2 | DJANG-TL2 | Book Session 3 | Creating a Website |
| Session 3 | DJANG-TL3 | Try It Yourself S1–3 | Practice Lab |
| Session 4 | DJANG-TL4 | Book Session 4 | Admin Panel |
| Session 5 | DJANG-TL5 | Book Session 5 | View Creation |
| Session 6 | DJANG-TL6 | Try It Yourself S4–5 | Practice Lab |
| Session 7 | DJANG-TL7 | Book Session 6 | Forms Creation |
| Session 8 | DJANG-TL8 | Book Session 7 | Templates |
| Session 9 | DJANG-TL9 | Try It Yourself S6–7 | Practice Lab |
| Session 10 | DJANG-TL10 | Book Session 8 | Serializers |
| Session 11 | DJANG-TL11 | Book Session 9 | REST Framework |
| Session 12 | DJANG-TL12 | Try It Yourself S8–9 | Practice Lab |

**Structure verdict: Correct.** The structure and topic ordering match the official curriculum.

---

## What Changed After Seeing the Official Manual

Two things I flagged in my first review were **wrong**:

1. **ViewSets in Session 10 is correct.** The official syllabus explicitly lists "Describe View Set and URLs with Serializer" under Book Session 8 (your Session 10). Do not move it.
2. **Template Inheritance, `{% url %}`, and static files are outside the official scope.** The official Session 8 topic list does not include them. They are listed as bonus additions at the end of this plan, not required fixes.

Everything else in the original review stands.

---

## Issues by Priority

Issues are marked **[MUST FIX]** (within official scope, causes student failure) or **[BONUS]** (beyond official scope, improves the course).

---

### GLOBAL ISSUES — Affect Every Session

| # | Issue | Type | Fix |
|---|-------|------|-----|
| G1 | **Practice sessions (3, 6, 9, 12) have no student-facing content.** `course_material.md` is a presenter-only guide. A student reviewing at home finds nothing to read. | MUST FIX | Add a "Student Quick Reference" section at the top of each practice session's `course_material.md` — a one-page cheat sheet of commands and patterns from the preceding sessions. |
| G2 | **No "By the end of this session you will have built X" opener on any session.** Students don't know the goal before they start. | MUST FIX | Add one sentence at the top of every teaching session: "**Goal:** By the end of this session, you will have [built X / configured Y / understood Z]." |
| G3 | **No single running project across sessions.** Each session invents a new project. Students never build on yesterday's work. | MUST FIX | Establish one project used from Session 2 through 9 (e.g., the `city_library`). Make each session explicitly add to it. The API sessions (10–12) can introduce a new project if needed. |
| G4 | **Django's error page is never explained.** Students see a red error screen and panic. | MUST FIX | Add a one-time "How to Read a Django Error" box in Session 2. Explain: look at the last line (the error type), look at the bottom of the traceback (the file and line number). |

---

### SESSION 2 — Creating a Website
**File:** `Week_01/Session_02_Creating_a_Website/course_material.md`

#### [MUST FIX] Migrations are a footnote, not a step
The model is defined in Step 4A but `makemigrations` + `migrate` appear only in a parenthetical note. Students will hit `OperationalError: no such table` and not know why.

**Fix:** Promote migrations to their own **Step 4A.5**, placed between the model definition and the view, with a warning:
```
⚠️ You MUST do this before the next step or the server will crash.
python manage.py makemigrations
python manage.py migrate
```

#### [MUST FIX] Students can't see any output — the database is empty
The view fetches `Student.objects.all()` but no students exist yet. Students will see a blank page and think they did something wrong.

**Fix:** After migrations, add a short step showing how to add dummy data using the Django shell:
```python
python manage.py shell
>>> from students.models import Student
>>> Student.objects.create(first_name="Alice", last_name="Smith")
>>> Student.objects.create(first_name="Bob", last_name="Jones")
>>> exit()
```
Then run the server and visit the page to see actual results. Forward-reference: "In Session 4, we will use the Admin Panel to add data — no more terminal needed."

#### [MUST FIX] Template folder structure needs a visual tree
The path `students/templates/students/student_list.html` written in prose confuses beginners. The most common mistake is creating `students/templates/student_list.html` (missing one level).

**Fix:** Add a plain-text folder tree immediately after the folder structure is described:
```
students/
├── templates/
│   └── students/        ← repeat the app name here
│       └── student_list.html
├── views.py
├── models.py
└── urls.py
```

#### [MUST FIX] `HttpResponse` appears in the class task but isn't taught in course material
The class task uses `from django.http import HttpResponse` but the course material only shows `render()`.

**Fix:** Before introducing `render()`, add a "Simplest Possible View" example:
```python
from django.http import HttpResponse

def simple_view(request):
    return HttpResponse("<h1>Hello!</h1>")
```
Explain: "`HttpResponse` sends raw text or HTML directly. `render()` is the smarter version that loads an HTML file for you."

#### [MUST FIX] Class task never tells students to run the server and test
The class task ends at Step 6 (wiring URLs) without a final "now run it and check" step.

**Fix:** Add Step 7: "Run `python manage.py runserver` and visit `http://127.0.0.1:8000/dir/welcome/`. You should see your welcome message."

---

### SESSION 3 — Practice Lab
**File:** `Week_01/Session_03_Practice/course_material.md`

#### [MUST FIX] No student-facing content
A student reviewing at home finds only instructor notes.

**Fix:** Add a **Student Quick Reference** section at the top of this file containing:
- The full list of terminal commands covered so far (create project, create app, run server, migrations)
- The MVT wiring checklist (Model → makemigrations/migrate → View → Template → App urls.py → Project urls.py)
- Common error messages and what they mean (the ones listed in the instructor pitfalls)

Keep the instructor guide section below it.

#### [MUST FIX] Class task has no hints for stuck students
The "Local Library" task is a good challenge but has no safety net for students who get stuck.

**Fix:** After each task step, add a collapsible hint in italics: *Hint: Remember the terminal must be inside the folder that contains `manage.py`.*

---

### SESSION 4 — Admin Panel
**File:** `Week_01/Session_04_Admin_Panel/course_material.md`

#### [MUST FIX] Bug in class task Bonus Step 6
The bonus step calls `admin.site.unregister(Book)` then `admin.site.register(Book, BookAdmin)`. Since students ran `admin.site.register(Book)` in Step 4, `unregister()` works in that specific sequence. But the pattern is confusing — beginners think they always need to unregister before customizing.

**Fix:** Replace the two-call pattern with a single clean version:
```python
# In admin.py — just do this from the start:
class BookAdmin(admin.ModelAdmin):
    list_display = ('title', 'author', 'published_year')
    search_fields = ('title', 'author')

admin.site.register(Book, BookAdmin)
```
Add a note: "You only need ONE `register()` call. Pass the `ModelAdmin` class as the second argument."

#### [MUST FIX] Admin panel navigation isn't walked through
The material says "Refresh your admin page, and 'Students' will appear!" but first-time users don't know where to click next.

**Fix:** Add a numbered walkthrough after the register step:
1. Refresh the admin page at `http://127.0.0.1:8000/admin/`
2. You'll see "Students" listed under your app name
3. Click "Students" to see the list (empty for now)
4. Click the "+ Add" button to create a new student
5. Fill in the first and last name fields and click "Save"
6. You'll see your new student in the list

#### [MUST FIX] No migration warning before admin registration
If a student created the `Student` model in Session 2 but never ran migrations and tries to add data through admin, they get `OperationalError: no such table`. This is the #1 error in admin sessions.

**Fix:** Add a warning box at the top of Section 3: "⚠️ Before creating the superuser, make sure you have already run `python manage.py migrate`. This creates the Users table that the superuser will be saved into."

---

### SESSION 5 — View Creation
**File:** `Week_02/Session_05_View_Creation/course_material.md`

#### [MUST FIX] The `Book` model used in examples is never defined
Students see `Book.objects.all()` with no explanation of where `Book` comes from.

**Fix:** Add 5 lines at the top of Section 5 defining the model used in the examples, or explicitly say: "For these examples, we'll use the `Book` model from the `catalog` app we worked on in Session 4."

#### [MUST FIX] Default CBV template name convention is never taught
When using `ListView`, Django auto-looks for `<modelname>_list.html`. This is mentioned as a pitfall in Session 6 but never explained in Session 5 — students encounter the error without having been taught what causes it.

**Fix:** Add a note directly under the CBV code example:
> "By default, Django will look for a template named `book_list.html` (lowercase model name + `_list`). If your file has a different name, you MUST set `template_name = 'your_file.html'` explicitly or you'll get a `TemplateDoesNotExist` error."

#### [MUST FIX] The `request` object has never been explained
Students have written `def view(request):` since Session 1 but have never been told what `request` is.

**Fix:** Add a "The `request` Object" section with a small reference table:

| Attribute | What it gives you |
|---|---|
| `request.method` | `'GET'` or `'POST'` — how the browser sent the request |
| `request.GET` | Data from the URL (`?search=cats`) |
| `request.POST` | Data submitted from a form |
| `request.user` | The currently logged-in user |

#### [MUST FIX] `redirect()` is never shown
Views frequently need to send the user to a different page (especially after a form save). This function is used in Session 7 implicitly but never introduced.

**Fix:** Add one example at the end of the FBV section:
```python
from django.shortcuts import render, redirect

def create_book(request):
    # ... form logic ...
    if form.is_valid():
        form.save()
        return redirect('book_list')  # send user to the list page
```

---

### SESSION 6 — Practice Lab (Views)
**File:** `Week_02/Session_06_Practice/course_material.md`

#### [MUST FIX] No student-facing content
**Fix:** Same as Session 3. Add a **Student Quick Reference** section at the top summarizing:
- FBV syntax (function, `render`, return)
- CBV syntax (class, `model`, `template_name`, `context_object_name`, `.as_view()`)
- URL wiring difference for FBV vs CBV

#### [MUST FIX] Pitfalls mention `TemplateView` which was never taught in Session 5
**Fix:** Either remove `TemplateView` from the pitfalls, or add a 5-line example of `TemplateView` to Session 5's course material.

---

### SESSION 7 — Forms Creation
**File:** `Week_02/Session_07_Forms/course_material.md`

#### [MUST FIX] `forms.py` file location is never stated
The material shows code but never says where to create the file.

**Fix:** Add one sentence before the first code block: "Create a new file called `forms.py` inside your app folder (e.g., `catalog/forms.py`)."

#### [MUST FIX] ModelForm never shows `form.save()`
The view processes the form but returns `HttpResponse("Thank you...")` — it never writes to the database. For a `ModelForm`, the student needs `form.save()`.

**Fix:** Update the view example to use a `ModelForm` and add the save step:
```python
if form.is_valid():
    form.save()              # writes the data to the database
    return redirect('book_list')  # send user away to prevent re-submission
```

#### [MUST FIX] Post/Redirect/Get pattern is not shown
If a student renders a template after a successful POST instead of redirecting, refreshing the browser re-submits the form and duplicates data. Every student will hit this.

**Fix:** Add a note after the save example:
> "⚠️ Always redirect after a successful POST. If you `render()` instead of `redirect()`, the user can accidentally re-submit the form by refreshing the page."

#### [MUST FIX] Custom validator has a crash bug
`author_name.startswith('A')` throws `AttributeError: 'NoneType' object has no attribute 'startswith'` if the field is blank.

**Fix:** Change to:
```python
def clean_author(self):
    author_name = self.cleaned_data.get('author')
    if author_name and not author_name.startswith('A'):
        raise forms.ValidationError("The author's name must start with A.")
    return author_name
```

#### [MUST FIX] Students don't know that `{{ form.as_p }}` includes error messages
Students rendering forms manually won't know how errors are displayed.

**Fix:** Add a note under the template example:
> "`{{ form.as_p }}` automatically displays error messages next to each field when validation fails. You do not need to add error display code separately."

---

### SESSION 8 — Templates
**File:** `Week_02/Session_08_Templates/course_material.md`

#### [MUST FIX] Section headings don't match the official syllabus wording
The official syllabus says "Outline Tag in Template" and "List the conditions in Template". The material headings say "Outline Tags" and "List the Conditions" — they match, but the order in the file is wrong: conditions (`{% if %}`) appear before tags (`{% for %}`), while the syllabus lists tags first.

**Fix:** Reorder so the `{% for %}` tag section comes before the `{% if %}` section.

#### [MUST FIX] "Define Form in Template" section is thin
The official syllabus explicitly calls this out. The current material only shows `{{ my_form.as_table }}` which was already shown in Session 7. This section needs to add value.

**Fix:** Expand this section to cover all three rendering shortcuts side by side:
```html
{{ form.as_p }}      <!-- fields wrapped in <p> tags -->
{{ form.as_table }}  <!-- fields wrapped in <tr> tags -->
{{ form.as_ul }}     <!-- fields wrapped in <li> tags -->
```
And add: when to use each one (`.as_p` is most common, `.as_table` looks better for longer forms).

#### [BONUS] Template Inheritance (`{% extends %}`, `{% block %}`)
Not in the official scope, but prevents massive HTML duplication in student projects.

**If time permits, add as a "Going Further" section:**
```html
<!-- base.html -->
<!DOCTYPE html>
<html>
<head><title>{% block title %}My Site{% endblock %}</title></head>
<body>
    <nav>My Navigation Bar</nav>
    {% block content %}{% endblock %}
</body>
</html>
```
```html
<!-- student_list.html -->
{% extends 'base.html' %}
{% block title %}Students{% endblock %}
{% block content %}
    <h1>Our Students</h1>
{% endblock %}
```

#### [BONUS] `{% url %}` tag
Not in the official scope, but hardcoded URLs in templates break every time a URL changes.

**If time permits, add as a "Going Further" section:**
```html
<!-- Instead of: -->
<a href="/students/list/">View Students</a>
<!-- Use: -->
<a href="{% url 'student_list' %}">View Students</a>
```

---

### SESSION 9 — Practice Lab (Forms + Templates)
**File:** `Week_03/Session_09_Practice/course_material.md`

#### [MUST FIX] No student-facing content
**Fix:** Add a **Student Quick Reference** at the top summarizing:
- The GET/POST view pattern (the two-step `if request.method == 'POST':` flow)
- The template form block (csrf_token + form rendering + submit button)
- The `form.save()` + redirect pattern

#### [MUST FIX] Session goal mentions "forms that write to the database" but Session 7 was missing `form.save()`
This only becomes a non-issue once Session 7 is fixed (see above).

---

### SESSION 10 — Serializers
**File:** `Week_03/Session_10_Serializers/course_material.md`

**Note:** ViewSets and Routers are correctly in Session 10 per the official syllabus. Do not move them.

#### [MUST FIX] Students never see what JSON output actually looks like
The concept of serialization is explained but no JSON is shown. Students don't know what they're building toward.

**Fix:** After the serializer definition, add a "What This Produces" example:
```json
[
    {
        "id": 1,
        "title": "The Hobbit",
        "author": "Tolkien",
        "published_year": 1937
    },
    {
        "id": 2,
        "title": "1984",
        "author": "Orwell",
        "published_year": 1949
    }
]
```
Explain: "This is what a browser or mobile app receives when it calls your API."

#### [MUST FIX] No instruction on how to test the API after building it
Students create a ViewSet and Router but have no idea what to do next to confirm it works.

**Fix:** Add a "Testing Your API" section at the end:
1. Run `python manage.py runserver`
2. Go to `http://127.0.0.1:8000/api/books/` in your browser
3. You will see the **DRF Browsable API** — a built-in web interface showing your JSON data
4. You can also use the form at the bottom of the page to POST new data directly from the browser
> "No special tools needed yet — the browser is enough to test everything in this session."

#### [MUST FIX] `SerializerMethodField` is introduced before the basics are solid
Students who are still absorbing what a serializer does don't need a custom computed field yet.

**Fix:** Move the `SerializerMethodField` example to Session 11 as an "advanced" example. Keep Session 10 focused on basic `ModelSerializer` and `ModelViewSet` only.

---

### SESSION 11 — REST Framework In-Depth
**File:** `Week_03/Session_11_REST_Framework/course_material.md`

#### [MUST FIX] Sections 1–4 heavily repeat Session 10 with minimal new content
The session repeats installation, serialization concept, ViewSet definition, and Router setup almost word-for-word from Session 10.

**Fix:** Compress sections 1–4 into a 3-bullet recap:
> - DRF is already installed and in `INSTALLED_APPS`
> - Our `BookSerializer` converts database records to JSON
> - Our `BookViewSet` + Router exposes them at `/api/books/`

Then use the freed-up space for genuinely new content:
- `SerializerMethodField` (moved from Session 10)
- PUT vs PATCH distinction (see below)
- HTTP status codes (see below)

#### [MUST FIX] PUT vs PATCH distinction is missing
The CRUD table maps Update to `PUT` only. But `ModelViewSet` supports both `PUT` (replace the whole record) and `PATCH` (change only some fields). Students will encounter `PATCH` in real projects.

**Fix:** Add a row to the CRUD table:

| Operation | HTTP Method | Description |
|---|---|---|
| Create | POST | Add a new record |
| Read | GET | Retrieve record(s) |
| Update (full) | PUT | Replace the entire record |
| Update (partial) | PATCH | Change only specific fields |
| Delete | DELETE | Remove a record |

#### [MUST FIX] HTTP status codes are never mentioned
REST APIs return `200 OK`, `201 Created`, `400 Bad Request`, `404 Not Found`. Students working with APIs need to know what these mean to debug them.

**Fix:** Add a "Common API Response Codes" section:

| Code | Meaning | When you see it |
|---|---|---|
| 200 OK | Request succeeded | Successful GET |
| 201 Created | Record was created | Successful POST |
| 400 Bad Request | Your data had errors | Failed validation |
| 404 Not Found | Record doesn't exist | Wrong ID in URL |
| 403 Forbidden | You don't have permission | Accessing a protected API |

#### [MUST FIX] The Browsable API walkthrough is too brief
"Navigate to an API URL in your browser" isn't enough. Students need to know how to actually use the interface to test all CRUD operations.

**Fix:** Expand Section 6 into a step-by-step walkthrough:
1. **GET (list):** Visit `/api/employees/` — see the JSON list
2. **POST (create):** Use the form at the bottom of the Browsable API page, fill in fields, click POST
3. **GET (single):** Visit `/api/employees/1/` — see one record
4. **PUT (update):** On `/api/employees/1/`, use the form to replace all fields
5. **DELETE:** On `/api/employees/1/`, click the red DELETE button

---

### SESSION 12 — Practice Lab (APIs)
**File:** `Week_03/Session_12_Practice/course_material.md`

#### [MUST FIX] No student-facing content
**Fix:** Add a **Student Quick Reference** at the top — the complete DRF checklist:
```
1. pip install djangorestframework
2. Add 'rest_framework' to INSTALLED_APPS in settings.py
3. Create serializers.py → define a ModelSerializer
4. Create a ModelViewSet in views.py
5. Create a Router in urls.py → register the ViewSet → include router.urls
6. Run server → test at http://127.0.0.1:8000/api/<your-endpoint>/
```

#### [MUST FIX] `fields = '__all__'` is mentioned only in pitfalls, never taught
Students don't know this shortcut exists.

**Fix:** Add it to the Session 10 serializer section as an alternative to listing fields:
```python
class Meta:
    model = Book
    fields = '__all__'   # includes every field from the model
    # OR list specific fields:
    # fields = ['id', 'title', 'author']
```

#### [MUST FIX] The practice task should explicitly cover all 4 CRUD operations
The current task is vague. Make it concrete.

**Fix:** Structure the practice task as a CRUD checklist using the Browsable API:
- [ ] Use GET to list all records
- [ ] Use POST to create a new record
- [ ] Use GET on a specific ID to retrieve one record
- [ ] Use PUT to update a record
- [ ] Use DELETE to remove a record

---

## Prioritized Implementation Order

Work through this list in order. The earlier items unblock the later ones.

| # | Priority | Session | Fix | Effort |
|---|----------|---------|-----|--------|
| 1 | 🔴 Critical | 2 | Promote migrations to numbered step + add shell data example | Low |
| 2 | 🔴 Critical | 7 | Add `form.save()` + redirect + fix validator bug | Low |
| 3 | 🔴 Critical | 3, 6, 9, 12 | Add Student Quick Reference to all 4 practice sessions | Low |
| 4 | 🔴 Critical | All | Add "Goal" opener sentence to every teaching session | Low |
| 5 | 🟡 Important | 2 | Add folder tree visual for template structure | Low |
| 6 | 🟡 Important | 2 | Introduce `HttpResponse` before `render()` | Low |
| 7 | 🟡 Important | 4 | Fix `unregister` bug in class task; add admin UI walkthrough | Low |
| 8 | 🟡 Important | 5 | Define the model used in examples; add `request` object table | Low |
| 9 | 🟡 Important | 5 | Explain default CBV template name convention | Low |
| 10 | 🟡 Important | 7 | Add `forms.py` file location; add form error display note | Low |
| 11 | 🟡 Important | 10 | Add JSON output example; add "Testing Your API" walkthrough | Low |
| 12 | 🟡 Important | 11 | Compress repeat content; add PUT/PATCH table; add status codes | Medium |
| 13 | 🟡 Important | 8 | Expand "Form in Template" section with all three shortcuts | Low |
| 14 | 🟡 Important | 5 | Add `redirect()` example | Low |
| 15 | 🟢 Polish | All | Add global "How to Read a Django Error" box (Session 2) | Low |
| 16 | 🟢 Polish | 10 | Move `SerializerMethodField` to Session 11 | Low |
| 17 | 🟢 Bonus | 8 | Add template inheritance as "Going Further" section | Medium |
| 18 | 🟢 Bonus | 8 | Add `{% url %}` tag as "Going Further" section | Low |
