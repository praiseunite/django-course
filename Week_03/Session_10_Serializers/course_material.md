# Session 10: Django Serializers

Up until now, our web applications have returned HTML pages intended for humans to read. But what if we want to build a mobile app? Or let another website talk to our database? Machines don't want to read HTML; they want pure data. This is where **Serializers** and **APIs (Application Programming Interfaces)** come in.

---

## 1. What are Serializers and Deserializers?

To allow machines to talk to our Django app, we need a universal language. The most popular language for this is JSON (JavaScript Object Notation).

*   **Serialization:** The process of translating a complex Django database Model (which is a Python object) into a simple JSON text string that can be sent over the internet.
*   **Deserialization:** The reverse process. Taking a JSON text string sent from a user's mobile app, validating it, and converting it back into a Django Python object to save in the database.

![Serialization Concept](../../assets/serialization_concept_1782301545751.png)

## 2. Installing the Django REST Framework (DRF)
Django does not come with robust serialization built-in. We use an incredibly popular third-party package called the **Django REST Framework (DRF)**.

**Step 1: Install it via terminal**
```bash
pip install djangorestframework
```

**Step 2: Add it to your project settings**
Open `settings.py` and add `rest_framework` to your `INSTALLED_APPS`:
```python
INSTALLED_APPS = [
    # ... other apps
    'rest_framework',
]
```

## 3. Creating and Importing a Serializer
Just like we create `forms.py` for HTML forms, we conventionally create `serializers.py` in our app folder for serializers.

```python
# serializers.py
from rest_framework import serializers
from .models import Book

# This is a ModelSerializer
class BookSerializer(serializers.ModelSerializer):
    class Meta:
        model = Book
        fields = ['id', 'title', 'author', 'published_year']
```
*Why? Notice how similar this is to a `ModelForm`! It acts exactly like a form, but instead of generating HTML, it generates JSON data.*

## 4. Different Types of Serializers
DRF provides two main types of serializers:
1.  **Serializer (`serializers.Serializer`):** Similar to a standard Django Form. You have to manually define every field and manually write the `create()` and `update()` logic. Use this for complex data that doesn't map directly to a database model.
2.  **ModelSerializer (`serializers.ModelSerializer`):** Similar to a Django ModelForm. It automatically generates fields based on the Model, and automatically implements `create()` and `update()`. This is used 95% of the time.

## 5. Defining Fields and Arguments
Just like forms, you can add custom fields or arguments to your serializers that don't exist in the database.

```python
class BookSerializer(serializers.ModelSerializer):
    # A custom field that just returns the length of the title
    title_length = serializers.SerializerMethodField()
    
    # Making a field read-only (a user can't update it via API)
    author = serializers.CharField(read_only=True)

    class Meta:
        model = Book
        fields = ['id', 'title', 'author', 'title_length']

    def get_title_length(self, obj):
        return len(obj.title)
```

## 6. ViewSets and URLs with Serializers
To actually serve this JSON data to the internet, we need a View and a URL. DRF introduces **ViewSets** which are super-powered Class-Based Views that handle everything (Create, Read, Update, Delete) automatically!

**In `views.py`:**
```python
from rest_framework import viewsets
from .models import Book
from .serializers import BookSerializer

class BookViewSet(viewsets.ModelViewSet):
    queryset = Book.objects.all()
    serializer_class = BookSerializer
```
*Why? `ModelViewSet` automatically provides `.list()`, `.retrieve()`, `.create()`, `.update()`, and `.destroy()` actions. It takes our database query (`queryset`) and pushes it through our `BookSerializer`.*

**In `urls.py`:**
Because ViewSets handle multiple URLs automatically, we use a `Router` to wire them.
```python
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import BookViewSet

router = DefaultRouter()
router.register(r'books', BookViewSet)

urlpatterns = [
    path('api/', include(router.urls)),
]
```
*Why? The Router automatically generates URLs for us. If a user visits `http://127.0.0.1:8000/api/books/`, they will see the JSON list of books!*
