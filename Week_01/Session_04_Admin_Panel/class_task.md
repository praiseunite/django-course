# Class Task: Managing the Library Catalog

**Objective:** In our last session, we created the `city_library` project and the `catalog` app. Today, we will create a superuser and manage a database model via the Django Admin interface.

### Step 1: Create a Book Model
1. Open your `city_library` project from Session 3.
2. Inside the `catalog` app, open `models.py`.
3. Create a model for a Book:
```python
from django.db import models

class Book(models.Model):
    title = models.CharField(max_length=200)
    author = models.CharField(max_length=100)
    published_year = models.IntegerField()

    def __str__(self):
        return self.title
```
*Why? We need some data to manage in our admin panel. This tells the database to prepare a table for books.*

### Step 2: Make and Run Migrations
Whenever you modify `models.py`, you must update the database.
```bash
python manage.py makemigrations
python manage.py migrate
```
*Why? `makemigrations` creates a blueprint of your changes. `migrate` actually applies those blueprints to the database.*

### Step 3: Create the Administrator
Let's create the head librarian.
```bash
python manage.py createsuperuser
```
Follow the prompts to create an account (e.g., username: `admin`, password: `password123`).

### Step 4: Register the Book Model
Open `catalog/admin.py` and register the `Book` model so it shows up in the dashboard.
```python
from django.contrib import admin
from .models import Book

admin.site.register(Book)
```

### Step 5: Test and Add Data
1. Run the server (`python manage.py runserver`).
2. Go to `http://127.0.0.1:8000/admin/` and log in.
3. Click "Add" next to Books.
4. Create 3 different books using the web interface.

### Step 6: Customize the Interface (Bonus)
Update your `admin.py` file to include a customized display. Replace everything you wrote in Step 4 with this:

```python
from django.contrib import admin
from .models import Book

class BookAdmin(admin.ModelAdmin):
    list_display = ('title', 'author', 'published_year')
    search_fields = ('title', 'author')

# Pass BookAdmin as the second argument — one register() call is all you need
admin.site.register(Book, BookAdmin)
```

Refresh your admin page to see the new columns and search bar!

**What changed:** Instead of the plain list showing "Book object (1)", you now see three columns: Title, Author, and Published Year. There is also a search bar at the top that searches across both title and author fields.
