# Class Task: Your First API

**Objective:** Install the Django REST Framework, build a Serializer, and expose your database data as a JSON API using a ViewSet.

### Step 1: Install and Configure
1. Open your terminal in your `school_project` workspace.
2. Install DRF: `pip install djangorestframework`
3. Open `school_project/settings.py` and add `'rest_framework',` to your `INSTALLED_APPS`.

### Step 2: Create the Serializer
We will serialize the `Student` model you created back in Session 7.
1. Create a new file: `directory/serializers.py`.
2. Write a `ModelSerializer` for the `Student` model.
```python
from rest_framework import serializers
from .models import Student

class StudentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Student
        fields = '__all__' # Shortcut to include all fields
```

### Step 3: Create the ViewSet
1. Open `directory/views.py`.
2. Import `viewsets` from `rest_framework`.
3. Import your `Student` model and `StudentSerializer`.
4. Create a `StudentViewSet` that inherits from `viewsets.ModelViewSet`.
5. Set the `queryset` to `Student.objects.all()`.
6. Set the `serializer_class` to `StudentSerializer`.

### Step 4: Wire the URLs
1. Open `directory/urls.py`.
2. Import `DefaultRouter` from `rest_framework.routers`.
3. Instantiate the router: `router = DefaultRouter()`
4. Register your viewset: `router.register(r'api-students', views.StudentViewSet)`
5. Add `path('', include(router.urls))` to your `urlpatterns`.

### Step 5: Test Your API!
1. Run your server.
2. Visit `http://127.0.0.1:8000/dir/api-students/` in your web browser.
3. Because DRF is amazing, you won't just see raw JSON text. You will see a beautiful "Browsable API" interface where you can read data and even submit new students via a web form that acts like an API client!
