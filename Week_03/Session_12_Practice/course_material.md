# Session 12: Practice & "Try It Yourself" Lab for APIs

Welcome to the final session of the core module! Today is all about cementing Serializers and the Django REST Framework (DRF) before students tackle their final projects.

---

## Student Quick Reference

Use this as your complete DRF build checklist.

### The Full DRF Setup — Step by Step

```bash
# 1. Install DRF (only once per project)
pip install djangorestframework
```

```python
# 2. settings.py — add to INSTALLED_APPS
INSTALLED_APPS = [
    # ... other apps ...
    'rest_framework',
]
```

```python
# 3. serializers.py — create this file in your app folder
from rest_framework import serializers
from .models import Book

class BookSerializer(serializers.ModelSerializer):
    class Meta:
        model = Book
        fields = ['id', 'title', 'author', 'published_year']
        # shortcut to include ALL fields:
        # fields = '__all__'
```

```python
# 4. views.py — create the ViewSet
from rest_framework import viewsets
from .models import Book
from .serializers import BookSerializer

class BookViewSet(viewsets.ModelViewSet):
    queryset = Book.objects.all()
    serializer_class = BookSerializer
```

```python
# 5. urls.py — register the ViewSet with a Router
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import BookViewSet

router = DefaultRouter()
router.register(r'books', BookViewSet)

urlpatterns = [
    path('api/', include(router.urls)),
]
```

```
6. Run the server: python manage.py runserver
7. Visit: http://127.0.0.1:8000/api/books/
```

### Testing All CRUD Operations in the Browsable API

The DRF Browsable API is a built-in web interface — no extra tools needed.

| Operation | How to do it |
| :--- | :--- |
| **Read (list)** | Visit `/api/books/` — you see all records in JSON |
| **Create** | Scroll to the bottom of `/api/books/` — fill in the HTML form and click POST |
| **Read (single)** | Visit `/api/books/1/` — you see one record by its ID |
| **Update (full)** | On `/api/books/1/`, use the PUT form at the bottom to replace all fields |
| **Delete** | On `/api/books/1/`, click the red DELETE button |

### Router — What URLs It Creates Automatically

When you do `router.register(r'books', BookViewSet)`, Django creates:

| URL | Method | Action |
| :--- | :--- | :--- |
| `/api/books/` | GET | List all books |
| `/api/books/` | POST | Create a new book |
| `/api/books/1/` | GET | Get one book (id=1) |
| `/api/books/1/` | PUT | Replace book (id=1) |
| `/api/books/1/` | PATCH | Partially update book (id=1) |
| `/api/books/1/` | DELETE | Delete book (id=1) |

### Common Errors and Fixes

| Error | Cause | Fix |
| :--- | :--- | :--- |
| 404 on `/api/books/` | Router not registered or not included | Check `router.register()` and `include(router.urls)` in `urls.py` |
| `fields = '__all__'` not working | Typo — wrong number of underscores | Use exactly two underscores on each side: `'__all__'` |
| `rest_framework` import error | Not in `INSTALLED_APPS` | Add `'rest_framework'` to `INSTALLED_APPS` in `settings.py` — check for missing comma |
| Empty JSON list `[]` | No data in the database | Add records via the Admin panel or the Browsable API POST form |

---

## Presenter's Guide

This lab session focuses on independent practice. Students will be building a complete API from scratch without step-by-step guidance.

### 1. The Core Concept to Review
Before the lab begins, bring up this architecture diagram on the projector:

![Full Stack Architecture](../../assets/full_stack_architecture_1782301762312.png)

Explain to the students *why* we spent the last two sessions learning APIs:
*   **Decoupling:** A Django API backend can serve data to a React website, an iOS app, and an Android app all at the same time.
*   **JSON is Universal:** The JSON data format is understood by virtually every programming language on earth.

### 2. Structure of the Session
*   **First 15 Minutes:** Q&A on DRF. Walk through the Quick Reference checklist above on the projector so all students have the same starting point.
*   **Next 90 Minutes:** Students complete the `class_task.md` challenge independently.
*   **Last 15 Minutes:** Code review. Have a student demonstrate all four CRUD operations live using the Browsable API — create a record, read it, update it, delete it.

### 3. Common Pitfalls to Watch Out For
*   **Forgetting to Register the Router:** If a student says "Page Not Found", check their `urls.py`. Did they register the ViewSet to the router? Did they include `router.urls` in `urlpatterns`?
*   **`fields = '__all__'` typo:** Ensure they use two underscores on each side.
*   **Missing comma in `INSTALLED_APPS`:** A classic error when adding `'rest_framework'`.


## Recommended Video Tutorials
Students can search for the following excellent YouTube tutorials on their own to supplement this session:

1. Dennis Ivy - Django REST API Project
2. Corey Schafer - Django Update/Delete Operations
3. FreeCodeCamp - REST Framework Practice
4. JustDjango - API Building Guide
