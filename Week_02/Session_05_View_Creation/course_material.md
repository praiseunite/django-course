# Session 5: Django View Creation

**Goal:** By the end of this session you will be able to write both a Function-Based View and a Class-Based View, wire them to URLs, and understand when to use each one.

Welcome to Week 2! We've already seen simple Views in action, but today we will dive deep into the "V" of our MVT architecture. Views are the brain of your application. They receive the user's web request, decide what to do with it, and return a web response.

---

## 1. The `request` Object

Every view function receives one argument: `request`. You have been writing `def view(request):` since Session 1, but let's understand what `request` actually contains.

| Attribute | What it gives you | Example |
| :--- | :--- | :--- |
| `request.method` | How the browser sent the request | `'GET'` or `'POST'` |
| `request.GET` | Data sent in the URL query string | `?search=cats` → `request.GET['search']` |
| `request.POST` | Data submitted from an HTML form | `request.POST['username']` |
| `request.user` | The currently logged-in user | `request.user.username` |

You will use `request.method` in Session 7 (Forms) to decide whether to show an empty form or to process submitted data.

---

## 2. Defining and Creating Views
A view is simply a Python function or a Python class that takes a web request and returns a web response. This response can be HTML content, a redirect, a 404 error, an XML document, or an image.

*Why do we need views?* Without a view, Django doesn't know *what* logic to execute when a user visits a URL. The view is where you put your "business logic" (e.g., "If the user is logged in, show their profile; if not, show the login page.").

---

## 3. Types of Views in Django
Django provides two main ways to write views:
1.  **Function-Based Views (FBVs):** Views written as standard Python functions.
2.  **Class-Based Views (CBVs):** Views written as Python classes that inherit from Django's built-in view classes.

---

## 4. Function-Based Views (FBVs) vs. Class-Based Views (CBVs)
![FBV vs CBV Diagram](../../assets/fbv_vs_cbv_1782301024879.png)

| Feature | Function-Based Views | Class-Based Views |
| :--- | :--- | :--- |
| **Structure** | Standard Python `def` | Python `class` |
| **Readability** | Very easy to read top-to-bottom | Can be hard to read due to hidden inherited code |
| **Code Reuse** | Low (requires writing helper functions) | High (can use object-oriented inheritance and mixins) |
| **Boilerplate** | High (you write the same `if request.method == 'POST':` repeatedly) | Low (Django handles standard HTTP methods behind the scenes) |

---

## 5. Pros and Cons

### Function-Based Views
*   **Pros:** Very straightforward. Excellent for beginners. You can see exactly what the code is doing line-by-line. Great for highly custom logic that doesn't fit a standard mold.
*   **Cons:** You end up repeating a lot of code for common tasks (like fetching a list of objects from the database).

### Class-Based Views
*   **Pros:** Django provides "Generic CBVs" for common tasks (like displaying a list, creating a form, showing details). You can build complex pages with just 3 lines of code! Excellent for code reuse.
*   **Cons:** Steeper learning curve. Because Django hides the complex logic inside the parent class, it can feel like "magic." If it breaks, it is harder to debug for beginners.

---

## 6. Creating a Function-Based View

For these examples, we will use the `Book` model from the `catalog` app. It looks like this:

```python
# catalog/models.py
from django.db import models

class Book(models.Model):
    title = models.CharField(max_length=200)
    author = models.CharField(max_length=100)
    published_year = models.IntegerField()

    def __str__(self):
        return self.title
```

Now let's write an FBV that fetches all books and sends them to a template:

```python
# catalog/views.py
from django.shortcuts import render
from .models import Book

def book_list_fbv(request):
    # 1. Logic: Fetch all books from the database
    books = Book.objects.all()
    
    # 2. Response: Render the template with the data
    return render(request, 'catalog/book_list.html', {'books': books})
```
*Why? We define a function taking `request` as an argument. It queries the database, puts the results in a dictionary `{'books': books}`, and uses `render` to combine the data with an HTML file.*

---

## 7. Redirecting the User

Sometimes a view doesn't render a page — it just sends the user somewhere else. This is called a redirect and is commonly used after saving a form.

```python
from django.shortcuts import render, redirect

def create_book(request):
    # ... form processing logic (covered in Session 7) ...
    if form_was_saved:
        return redirect('book_list_fbv')  # send user to the list page by name
```
*Why? `redirect()` takes the name of a URL pattern (the `name=` argument from `urls.py`) and sends the browser there. Using the name rather than a hardcoded URL (`/books/`) means the redirect won't break if you ever change the URL path.*

---

## 8. Describing the Operation of a Class-Based View

Now let's do the exact same thing as the FBV above, using a generic Class-Based View:

```python
# catalog/views.py
from django.views.generic import ListView
from .models import Book

class BookListCBV(ListView):
    model = Book
    template_name = 'catalog/book_list.html'
    context_object_name = 'books'
```
*Why? Instead of writing the fetch logic and the render function, we inherit from `ListView`. `ListView` already knows how to fetch all objects and render a template. We simply give it variables (`model`, `template_name`). Django does the rest behind the scenes!*

> **Default template name:** If you do NOT set `template_name`, Django will look for a file named `<modelname>_list.html` — in this case `book_list.html` — inside your app's `templates/catalog/` folder. If your file has a different name, you MUST set `template_name` explicitly or you will get a `TemplateDoesNotExist` error.

### TemplateView — For Pages With No Database Data

If you just want to render an HTML file (like an "About Us" page) without fetching anything from the database, use `TemplateView`:

```python
from django.views.generic import TemplateView

class AboutView(TemplateView):
    template_name = 'catalog/about.html'
```

---

## 9. Configuring URLs for Different Kinds of Views

Because FBVs and CBVs are structurally different (one is a function, one is a class), we must configure them differently in `urls.py`.

```python
from django.urls import path
from . import views

urlpatterns = [
    # Routing a Function-Based View — pass the function directly
    path('fbv-books/', views.book_list_fbv, name='book_list_fbv'),

    # Routing a Class-Based View — must call .as_view() on the class
    path('cbv-books/', views.BookListCBV.as_view(), name='cbv_list'),

    # Routing a TemplateView
    path('about/', views.AboutView.as_view(), name='about'),
]
```
*Why? The URL dispatcher requires a callable function. Since `book_list_fbv` is already a function, we pass it directly. But `BookListCBV` is a class. We must call `.as_view()` on it, which is a built-in Django method that converts the class into a usable function for the URL router. Forgetting `.as_view()` causes a `TypeError`.*

---

## Recommended Video Tutorials
Students can search for the following excellent YouTube tutorials on their own to supplement this session:

1. Corey Schafer - Django Tutorial Part 2: Views
2. JustDjango - Class Based Views Tutorial
3. Very Academy - Django Class Based Views
4. Dennis Ivy - Views and Routing
