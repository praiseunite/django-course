# Session 11: Django's REST Framework (In-Depth)

**Goal:** By the end of this session you will understand CRUD operations and HTTP status codes, and be able to test all four data operations using the DRF Browsable API.

In our previous session, we built our first Serializer, ViewSet, and Router. Today we go deeper into the REST Framework architecture, focusing on how APIs handle CRUD data operations, advanced serializer fields, and interpreting API responses.

---

## 1. Quick Recap from Session 10

Before new content, a fast recap of what we built:

- **`BookSerializer`** (in `serializers.py`) — converts `Book` database records to JSON and back
- **`BookViewSet`** (in `views.py`) — automatically handles all CRUD operations
- **`DefaultRouter`** (in `urls.py`) — generates all 6 URL patterns automatically from one `register()` call

If any of those three files don't look right, go back to Session 10's Quick Reference before continuing.

---

## 2. Serialization: The Bridge

Serialization is the core of any API.

*   **Serialization:** Database Model → Python Dictionary → JSON String *(sending data OUT)*
*   **Deserialization:** JSON String → Python Dictionary → Validated Database Model *(receiving data IN)*

If you don't serialize your data, a mobile app (which might be written in Swift or Kotlin) won't know how to read your Python objects.

---

## 3. Advanced Serializer Fields: SerializerMethodField

In Session 10 we learned the basics of `ModelSerializer`. Now let's add a custom computed field — one that doesn't exist as a column in the database but is calculated on the fly.

```python
# serializers.py
from rest_framework import serializers
from .models import Book

class BookSerializer(serializers.ModelSerializer):
    # A custom field — computed, not stored in the database
    title_length = serializers.SerializerMethodField()

    class Meta:
        model = Book
        fields = ['id', 'title', 'author', 'published_year', 'title_length']

    # Django calls this method automatically for the title_length field
    # The naming rule: get_<field_name>
    def get_title_length(self, obj):
        return len(obj.title)
```

*Why? `SerializerMethodField` is read-only and calls the `get_<fieldname>` method for each record. Here, every book in the JSON response will include a `title_length` key showing the number of characters in the title — even though that column doesn't exist in the database.*

---

## 4. Defining a ViewSet

A `ViewSet` is a class that combines the logic for multiple related views.

```python
from rest_framework import viewsets
from .models import Employee
from .serializers import EmployeeSerializer

class EmployeeViewSet(viewsets.ModelViewSet):
    queryset = Employee.objects.all()
    serializer_class = EmployeeSerializer
```
*Why? Instead of writing 5 different functions (list, retrieve, create, update, destroy), `ModelViewSet` gives us all 5 automatically. It's like a Class-Based View, but for APIs.*

---

## 5. Explaining API URLs (Routers)

Because a ViewSet handles multiple routes automatically, standard Django `path()` functions are tedious to write. DRF provides a `DefaultRouter`.

```python
from rest_framework.routers import DefaultRouter
from .views import EmployeeViewSet

router = DefaultRouter()
router.register(r'employees', EmployeeViewSet)

# This automatically generates:
# GET  /employees/          → list all
# POST /employees/          → create new
# GET  /employees/<id>/     → retrieve one
# PUT  /employees/<id>/     → full update
# PATCH /employees/<id>/    → partial update
# DELETE /employees/<id>/   → delete
```

---

## 6. CRUD Operations and HTTP Methods

CRUD is the fundamental concept behind all data storage. In REST APIs, we map CRUD operations to HTTP Methods.

![CRUD Operations in API](../../assets/crud_operations_api_1782301654243.png)

| Operation | HTTP Method | Description | Example |
| :--- | :--- | :--- | :--- |
| **C - Create** | POST | Add a new record | Signing up for an account |
| **R - Read** | GET | Retrieve record(s) | Viewing your profile |
| **U - Update (full)** | PUT | Replace the entire record | Rewriting all profile fields |
| **U - Update (partial)** | PATCH | Change only specific fields | Updating just your email |
| **D - Delete** | DELETE | Remove a record | Deleting a post |

*Why map them? By standardising these HTTP verbs, developers all over the world know exactly how to interact with your API without extensive documentation. PUT replaces everything; PATCH changes only what you send.*

---

## 7. Common API Response Codes

When your API responds, it always includes an HTTP status code. These tell the client whether the request succeeded or failed.

| Code | Name | When you see it |
| :--- | :--- | :--- |
| **200** | OK | Successful GET or PUT |
| **201** | Created | Successful POST (record was created) |
| **204** | No Content | Successful DELETE (nothing to return) |
| **400** | Bad Request | The data you sent failed validation |
| **403** | Forbidden | You don't have permission to do this |
| **404** | Not Found | The record with that ID doesn't exist |

*Why do these matter? When a student's mobile app or a Postman test shows a 400 error, they know the data they sent was invalid — not that the server crashed. Status codes are the API's way of communicating clearly.*

---

## 8. Testing All CRUD Operations with the Browsable API

Start your server (`python manage.py runserver`). When you navigate to an API URL in your browser, DRF provides the **Browsable API** — a built-in web interface that makes testing easy.

**Step-by-step CRUD test:**

**1. Read (list all records)**
- Visit `http://127.0.0.1:8000/api/employees/`
- You see a JSON array of all employees and the response code **200 OK**

**2. Create (add a new record)**
- Stay on `/api/employees/`
- Scroll to the bottom — fill in the HTML form fields
- Click the **POST** button
- You should see your new record appear and response code **201 Created**

**3. Read (retrieve one record)**
- Visit `http://127.0.0.1:8000/api/employees/1/` (use the ID of any record)
- You see only that employee's data — response code **200 OK**

**4. Update (replace a record)**
- On `/api/employees/1/`, scroll to the bottom form
- Change some fields and click **PUT**
- All fields are replaced — response code **200 OK**

**5. Delete (remove a record)**
- On `/api/employees/1/`, click the red **DELETE** button
- Confirm the deletion
- The record is gone — response code **204 No Content**

> After completing all 5 steps, go back to `/api/employees/` to confirm the deleted record is no longer in the list.

---

## Recommended Video Tutorials
Students can search for the following excellent YouTube tutorials on their own to supplement this session:

1. Dennis Ivy - Build a REST API
2. Programming with Mosh - Django API Tutorial
3. Very Academy - Django REST Framework Viewsets
4. FreeCodeCamp - Django REST API Full Course
