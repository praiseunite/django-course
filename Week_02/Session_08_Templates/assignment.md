# Assignment: Session 8

**Submission Guidelines:** Submit a screenshot of your working webpage and copy/paste your HTML code.

### Task: The Blog Homepage Makeover
Open your `my_blog` project. It's time to make it look like a real blog!

1. Open your `posts/home.html` file (from Session 6).
2. Currently, you have a simple loop showing the title and content. We are going to upgrade this using Template Tags and Filters.
3. **If Statement:** Add an `{% if %}` statement that checks if the `all_posts` list is empty. If it is empty, display a message saying "No posts published yet." If it is not empty, display the loop.
4. **Filters:**
   * Use the `upper` filter to make all Blog Titles uppercase.
   * Use the `truncatewords:20` filter on the blog content. This means if your blog post is 100 words long, the homepage will only show the first 20 words, acting as a "preview" snippet!

**Proof:** Write a very long blog post in your Admin panel to test the truncate filter. Take a screenshot of your homepage showing the uppercase titles and truncated snippets. Submit the screenshot and the `home.html` code.
