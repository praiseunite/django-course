# Class Task: Comparing FBVs and CBVs

**Objective:** Write two views that do the exact same thing—one as a function, and one as a class—to see the differences in action.

We will use the `city_library` project and the `Book` model we created in Session 4.

### Step 1: The Function-Based View
1. Open `catalog/views.py`.
2. Write a function called `library_about_fbv`.
3. It should return a rendered template called `about.html` containing a dictionary with the library name: `{'library_name': 'Central City Library'}`.

```python
# catalog/views.py
from django.shortcuts import render

def library_about_fbv(request):
    context = {'library_name': 'Central City Library'}
    return render(request, 'catalog/about.html', context)
```

### Step 2: The Class-Based View
Now let's use Django's generic `TemplateView`.
1. Still in `catalog/views.py`, import `TemplateView`:
   `from django.views.generic import TemplateView`
2. Create a class called `LibraryAboutCBV` that inherits from `TemplateView`.

```python
class LibraryAboutCBV(TemplateView):
    template_name = 'catalog/about.html'
    
    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['library_name'] = 'Central City Library'
        return context
```
*Why? Because `TemplateView` hides the logic, if we want to pass custom data (like the library name), we have to override a specific built-in method called `get_context_data`.*

### Step 3: Create the Template
1. Create the file: `catalog/templates/catalog/about.html`
2. Add this HTML:
```html
<h1>About Us</h1>
<p>Welcome to {{ library_name }}!</p>
```

### Step 4: Wire the URLs
Open `catalog/urls.py` and wire both views:
```python
from django.urls import path
from . import views

urlpatterns = [
    path('about-fbv/', views.library_about_fbv, name='about_fbv'),
    path('about-cbv/', views.LibraryAboutCBV.as_view(), name='about_cbv'),
]
```

### Step 5: Test
Run your server. 
Go to `http://127.0.0.1:8000/about-fbv/` and then go to `http://127.0.0.1:8000/about-cbv/`. 
They should look completely identical! You have just learned two different ways to build the exact same page.
