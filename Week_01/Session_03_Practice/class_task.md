# Class Task: "Try It Yourself" Challenge

**Objective:** Build a complete, working Django application from scratch without relying heavily on the previous notes.

### Scenario: The Local Library
Your local town library needs a very basic web page to show that they exist and to display their address. 

### Task 1: Environment & Project Setup
1. Open a new terminal window.
2. Create a new folder named `library_workspace`.
3. Inside it, create a virtual environment named `lib_env`.
4. Activate `lib_env`.
5. Install Django.
6. Create a new Django project named `city_library`.

### Task 2: App Creation & Registration
1. Navigate into the `city_library` folder.
2. Create an app named `catalog`.
3. Open the project in your code editor.
4. Register the `catalog` app in your project's `settings.py` file.

### Task 3: The View (Logic)
1. Open `catalog/views.py`.
2. Write a function called `home_page`.
3. The function should return an `HttpResponse` containing the following HTML string:
   `"<h1>Welcome to the City Library</h1><p>We are located at 123 Main St.</p>"`

### Task 4: The URLs (Routing)
1. In the `catalog` folder, create a `urls.py` file.
2. Write the code to route the empty path `''` to your `home_page` view. Name the path `'home'`.
3. Open the main `city_library/urls.py` file.
4. Include the `catalog` app's URLs. Make it so that navigating to `http://127.0.0.1:8000/` immediately shows the library home page. *(Hint: use `path('', include('catalog.urls'))`)*

### Task 5: Server Test
1. Run the development server.
2. Check `http://127.0.0.1:8000/` in your browser.

**Bonus Challenge (If you finish early):**
Create a second view in the `catalog` app called `opening_hours` that returns the hours of operation. Map it to the URL `http://127.0.0.1:8000/hours/`.
