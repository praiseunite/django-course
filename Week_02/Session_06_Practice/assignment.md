# Assignment: Session 6

**Submission Guidelines:** Submit a ZIP file of your `my_blog` project folder (excluding the virtual environment folder).

### The "Personal Blog" Project - Part 2

We are continuing to build your personal blog! 

**Requirements:**
1. Open your `my_blog` project.
2. Ensure your `Post` model (created in Session 4) has some data in it via the Admin panel.
3. **Refactoring:** Delete the old Function-Based View that returned the "Welcome" `HttpResponse`.
4. Create a robust Class-Based View called `BlogHomeView` using `ListView`.
5. Connect it to your `Post` model.
6. Set the `template_name` to `'posts/home.html'`.
7. Set the `context_object_name` to `'all_posts'`.
8. Create the `posts/home.html` template. Use a `{% for post in all_posts %}` loop to display the `title` and `content` of each blog post you created in the Admin panel.
9. Route this view to the root URL `''` so that as soon as someone visits `http://127.0.0.1:8000/`, they see your blog posts.

**Deliverable:**
Zip your `my_blog` folder (without the `venv`) and submit it for grading.
