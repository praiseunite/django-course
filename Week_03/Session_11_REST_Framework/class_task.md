# Class Task: Full CRUD API

**Objective:** Build an API for a Library system and test all four CRUD operations using the DRF Browsable API interface.

### Step 1: Model Setup
1. In your `school_project`, create a new app called `library`.
2. Add it to `INSTALLED_APPS` (ensure `rest_framework` is also there).
3. Create a `Book` model with `title` (CharField), `author` (CharField), and `isbn` (CharField).
4. Run your migrations!

### Step 2: The Serializer
1. In the `library` app, create `serializers.py`.
2. Write a `BookSerializer` that inherits from `serializers.ModelSerializer`.
3. Include all fields.

### Step 3: The ViewSet & Router
1. In `views.py`, create a `BookViewSet` using `viewsets.ModelViewSet`.
2. In `urls.py`, set up a `DefaultRouter`. Register the prefix `api-books` to your `BookViewSet`.

### Step 4: Testing CRUD Operations
Run your server and go to `http://127.0.0.1:8000/api-books/`.

1. **Create (POST):** Scroll to the bottom of the Browsable API page. Use the HTML form to add two new books. Click "POST".
2. **Read (GET List):** Look at the top of the page; you should see your two books returned as JSON.
3. **Read (GET Detail):** Add `/1/` to the end of your URL (e.g., `api-books/1/`). You are now viewing just the first book.
4. **Update (PUT):** While viewing book 1, scroll down, change the Author's name, and click "PUT". Look at the JSON response to confirm the update.
5. **Delete (DELETE):** Click the red "DELETE" button at the top right of the page. Confirm the deletion. Go back to the main list and verify it is gone.
