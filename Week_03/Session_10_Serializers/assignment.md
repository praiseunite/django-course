# Assignment: Session 10

**Submission Guidelines:** Submit screenshots in a Word document or PDF.

### Task: The Headless Blog API
Let's imagine you want to build an iOS app for your personal blog. The iOS app needs to download your blog posts in JSON format.

1. Open your `my_blog` project.
2. Install and configure `djangorestframework`.
3. In the `posts` app, create `serializers.py` and build a `ModelSerializer` for your `Post` model. Include the `id`, `title`, and `content` fields.
4. In `posts/views.py`, create a `PostViewSet` (using `ModelViewSet`).
5. In `posts/urls.py`, set up a `DefaultRouter` and register your viewset to the path `api/posts/`.
6. Run your server and visit the API URL in your browser.

**Proof:**
1. Take a screenshot of your code for `serializers.py` and `views.py`.
2. Take a screenshot of your browser displaying the DRF Browsable API interface showing your blog posts in JSON format.
