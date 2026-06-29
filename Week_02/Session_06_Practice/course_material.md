# Session 6: Practice & "Try It Yourself" Lab

Welcome to the second dedicated lab session! Today's focus is on reinforcing Sessions 4 and 5: the Django Admin Panel, and building both Function-Based and Class-Based Views.

---

## Student Quick Reference

Use this as a cheat sheet while you work through the tasks.

### Admin Panel Setup Checklist
- [ ] Run `python manage.py migrate` (creates the Users table)
- [ ] Run `python manage.py createsuperuser` (follow the prompts)
- [ ] Register your model in `app/admin.py`
- [ ] Run the server and go to `http://127.0.0.1:8000/admin/`

### Registering a Model in admin.py
```python
from django.contrib import admin
from .models import Book

# Basic registration
admin.site.register(Book)

# Registration with customisation
class BookAdmin(admin.ModelAdmin):
    list_display = ('title', 'author', 'published_year')
    search_fields = ('title', 'author')

admin.site.register(Book, BookAdmin)
```

### Function-Based View (FBV)
```python
# views.py
from django.shortcuts import render
from .models import Book

def book_list(request):
    books = Book.objects.all()
    return render(request, 'catalog/book_list.html', {'books': books})
```
```python
# urls.py
from django.urls import path
from . import views

urlpatterns = [
    path('books/', views.book_list, name='book_list'),
]
```

### Class-Based View (CBV)
```python
# views.py
from django.views.generic import ListView
from .models import Book

class BookListView(ListView):
    model = Book
    template_name = 'catalog/book_list.html'   # must set this explicitly
    context_object_name = 'books'
```
```python
# urls.py — note the .as_view() call
urlpatterns = [
    path('books/', views.BookListView.as_view(), name='book_list'),
]
```

### TemplateView — for pages with no database data
```python
from django.views.generic import TemplateView

class AboutView(TemplateView):
    template_name = 'catalog/about.html'
```
```python
# urls.py
path('about/', views.AboutView.as_view(), name='about'),
```

### FBV vs CBV at a Glance

| | FBV | CBV |
|---|---|---|
| Structure | `def view(request):` | `class View(ListView):` |
| URL wiring | `views.book_list` | `views.BookListView.as_view()` |
| Best for | Custom logic | Standard list/detail/create pages |

### Common Errors and Fixes

| Error | Cause | Fix |
| :--- | :--- | :--- |
| `TemplateDoesNotExist` | CBV can't find the HTML file | Set `template_name = 'your_file.html'` explicitly on the class |
| `TypeError: view must be a callable` | Forgot `.as_view()` on a CBV | Change to `BookListView.as_view()` in `urls.py` |
| Model not in admin panel | Forgot `admin.site.register()` | Add registration in `admin.py` |
| `OperationalError` after adding a field | Forgot to migrate | Run `makemigrations` then `migrate` |

---

## Presenter's Guide

This is a facilitator-led session. Students should spend the majority of the time coding.

### 1. Structure of the Session
*   **First 15 Minutes:** Quick recap of the Django Admin panel and the structural differences between FBVs and CBVs. Point students to the Quick Reference above.
*   **Next 90 Minutes:** Students work on the `class_task.md` challenges. Encourage them to help each other debug.
*   **Last 15 Minutes:** Code review. Call a student up to the projector (or share their screen) to show how they solved the Class-Based View challenge. Also show what the error looks like when `.as_view()` is forgotten so they can recognise it in future.

### 2. Common Pitfalls to Watch Out For
*   **Admin Registration:** Students often create a model but forget to register it in `admin.py`. If they complain "My table isn't in the dashboard!", remind them to check `admin.site.register()`.
*   **Migrations:** If they add a new field to a model (like adding a `price` to a `Product` model) but forget to run `makemigrations` and `migrate`, the database will crash when they try to save it in the Admin panel.
*   **CBV Template Missing:** When using `ListView` or `TemplateView`, Django expects a specific template name by default (e.g., `modelname_list.html`). If they get a `TemplateDoesNotExist` error, they need to explicitly set `template_name = 'their_file.html'` in the class.
*   **URL `.as_view()`:** Forgetting to append `.as_view()` when routing a Class-Based View in `urls.py` will result in a `TypeError`.

### 3. Reviewing the Solutions
Focus the final review on the Class-Based View syntax. Make sure students understand *why* they use `context_object_name` and *why* they inherit from `ListView`.


## Recommended Video Tutorials
Students can search for the following excellent YouTube tutorials on their own to supplement this session:

1. Tech With Tim - Django Framework Tutorial
2. Corey Schafer - Django Tutorial Part 11: Pagination
3. Programming with Mosh - Django App Practice
4. Corey Schafer - Django Applications
