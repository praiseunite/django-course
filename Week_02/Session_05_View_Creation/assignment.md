# Assignment: Session 5

**Submission Guidelines:** Submit your python files (`views.py` and `urls.py`) or copy/paste the code into a Word document.

### Task 1: Theory
In your own words (3-4 sentences), explain when you would choose to use a Function-Based View, and when you would choose to use a Class-Based View. 

### Task 2: Refactoring to CBV (Practical)
Open your `my_blog` project from homework. In Session 3, you created a Function-Based View called `all_posts` that returned an `HttpResponse`.

1. In `posts/views.py`, keep your old `all_posts` FBV.
2. Below it, create a new Class-Based View called `PostListCBV` using Django's generic `ListView`. Connect it to your `Post` model.
3. In `posts/urls.py`, route the URL `/cbv-posts/` to your new `PostListCBV.as_view()`.

*(Note: If you run this, you will get a `TemplateDoesNotExist` error because `ListView` automatically looks for a template called `post_list.html`. That is okay! We will cover templates in detail soon. Getting the URL to trigger the View is the goal for this task.)*
