# Assignment: Session 9

**Submission Guidelines:** Submit a ZIP file of your `my_blog` project folder (excluding the virtual environment folder).

### The "Personal Blog" Project - Part 3

Our blog can display posts, but right now, you have to log into the Admin panel to create them. Let's fix that! We will build a public "Create Post" page.

**Requirements:**
1. Open your `my_blog` project.
2. **Form:** Create a `forms.py` file in your `posts` app. Create a `PostForm` (ModelForm) connected to your `Post` model.
3. **View:** Create a view called `create_post(request)`. Implement the standard GET/POST logic. If the form saves successfully, use `return redirect('home')` to send the user back to the blog homepage (you will need to `from django.shortcuts import redirect`).
4. **Template:** Create `posts/create.html`. Render the form with a CSRF token.
5. **URL:** Route this new view to `http://127.0.0.1:8000/create/`.
6. **Homepage Link:** Open your `posts/home.html` template. Use a standard HTML `<a>` tag to add a link at the top of the page that says "Write a new post", which takes the user to `/create/`.

**Deliverable:**
Zip your `my_blog` folder (without the `venv`) and submit it. The instructor should be able to click "Write a new post", fill out a form, and see it instantly appear on the homepage.
