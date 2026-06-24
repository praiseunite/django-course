# Assignment: Session 4

**Submission Guidelines:** Submit screenshots in a Word document or PDF.

### Task 1: The Personal Blog Dashboard
We are continuing the `my_blog` project from Session 3's homework.

1. Open your `my_blog` project.
2. In the `posts` app, create a model called `Post`. It should have two fields: `title` (CharField) and `content` (TextField). Don't forget the `__str__` method!
3. Run migrations (`makemigrations` and `migrate`) to create the database table.
4. Create a superuser account for yourself.
5. Register the `Post` model in `posts/admin.py`.
6. Log into the admin panel and create 2 blog posts.

**Proof:** 
1. Take a screenshot of the Django Admin panel showing your `Posts` table.
2. Take a screenshot of the form inside the admin panel where you are typing out one of your blog posts.

### Task 2: Admin Customization
Modify your `posts/admin.py` to use a `ModelAdmin` class. 
1. Make it so that the list view displays both the `title` and the `content`.
2. Add a search bar that allows you to search by `title`.

**Proof:** Take a screenshot of your customized Admin interface showing the multi-column table and the search bar.
