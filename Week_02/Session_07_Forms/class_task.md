# Class Task: Creating a Student Registration Form

**Objective:** Build a ModelForm, render it in a view, accept POST data, and save it to the database.

### Step 1: The Setup
1. Open the `school_project` from earlier sessions.
2. Ensure you have the `directory` app activated.
3. In `directory/models.py`, create a `Student` model:
```python
from django.db import models

class Student(models.Model):
    name = models.CharField(max_length=100)
    age = models.IntegerField()
```
4. Run migrations!

### Step 2: Create the ModelForm
1. Create a new file: `directory/forms.py`.
2. Build a ModelForm connected to the `Student` model. Add a widget so the 'name' field has a placeholder.
```python
from django import forms
from .models import Student

class StudentForm(forms.ModelForm):
    class Meta:
        model = Student
        fields = ['name', 'age']
        widgets = {
            'name': forms.TextInput(attrs={'placeholder': 'e.g. John Doe'})
        }
```

### Step 3: Create the View
In `directory/views.py`, write the logic to handle both GET (showing the form) and POST (saving the data).
```python
from django.shortcuts import render, redirect
from django.http import HttpResponse
from .forms import StudentForm

def register_student(request):
    if request.method == 'POST':
        form = StudentForm(request.POST)
        if form.is_valid():
            form.save() # Saves directly to the database!
            return HttpResponse("Student registered successfully!")
    else:
        form = StudentForm()
        
    return render(request, 'directory/register.html', {'form': form})
```
*Why? `form.save()` is the magic of ModelForms. Because the form is tied to a Model, calling `save()` automatically runs the SQL to insert the data into the database.*

### Step 4: The Template
1. Create `directory/templates/directory/register.html`.
2. Add the HTML form tags and the CSRF token.
```html
<h1>Register Student</h1>
<form method="POST">
    {% csrf_token %}
    {{ form.as_p }}
    <button type="submit">Submit</button>
</form>
```

### Step 5: Test
1. Route the view in `urls.py`.
2. Visit the page, fill out the form, and hit submit.
3. Check your Admin panel (you may need to register the model in `admin.py`) to verify the student was actually saved in the database!
