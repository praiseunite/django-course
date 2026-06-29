# Session 7: Django Forms Creation

**Goal:** By the end of this session you will have built a form that validates user input and saves data to the database.

So far, our users have only been able to *read* data from our web pages. To allow them to *send* data to the server (like signing up, sending a message, or uploading a file), we need HTML Forms. Django makes handling forms extremely secure and fast.

---

## 1. What are Django Forms?
A Django Form is a Python class that translates your form rules into HTML, validates the data the user submits, and securely converts that data into Python types.

*Why do we need them?* Writing HTML `<form>` tags manually is tedious. More importantly, validating user data manually (e.g., "Is this a real email? Is this password long enough?") is dangerous and prone to bugs. Django Forms handle this securely.

---

## 2. HTTP Methods: GET vs. POST
![HTTP GET vs POST Diagram](../../assets/get_vs_post_1782301035907.png)

When a browser talks to a server, it uses "HTTP Methods". The two most important are GET and POST.

*   **GET:** Used to *request* data. When you type `google.com` and press enter, you are making a GET request. The parameters are visible in the URL (e.g., `?search=cats`). **Never use GET for sensitive data.**
*   **POST:** Used to *submit* data to change something on the server. When you submit a login form or upload an image, you are making a POST request. The data is hidden inside the body of the request, making it secure.

---

## 3. Creating a Simple Form (Standard Form)

Create a new file called `forms.py` inside your app folder (e.g., `catalog/forms.py`). This is where all your form classes live.

```python
# catalog/forms.py
from django import forms

class ContactForm(forms.Form):
    name = forms.CharField(max_length=100)
    email = forms.EmailField()
    message = forms.CharField(widget=forms.Textarea)
```
*Why? This looks similar to a Model! But instead of `models.Model`, we inherit from `forms.Form`. Django will automatically generate the HTML `<input>` tags for these fields.*

---

## 4. Instantiating, Processing, and Rendering a Form

To show the form on a webpage and process it when the user clicks "Submit", we use a View. Every form view follows the same two-step pattern:

- **GET request** (user visits the page) → show an empty form
- **POST request** (user clicks Submit) → validate the data, then save or process it

```python
# views.py
from django.shortcuts import render, redirect
from .forms import ContactForm

def contact_view(request):
    # Step 1: Did the user submit data?
    if request.method == 'POST':
        # Step 2: Bind the submitted data to the form
        form = ContactForm(request.POST)
        
        # Step 3: Validate the data
        if form.is_valid():
            # Step 4: Process the clean data
            user_name = form.cleaned_data['name']
            # ... do something with the data here ...
            return redirect('home')  # always redirect after a successful POST
            
    else:
        # Step 5: GET request — give the user an empty form
        form = ContactForm()
        
    # Step 6: Render the template (runs for GET, and for a failed POST)
    return render(request, 'catalog/contact.html', {'form': form})
```

> ⚠️ **Always redirect after a successful POST.** If you use `render()` instead of `redirect()` after saving, the browser will re-submit the form data every time the user refreshes the page — creating duplicate records.

To render the form in the template (`contact.html`):
```html
<form method="POST">
    {% csrf_token %}
    {{ form.as_p }}
    <button type="submit">Send</button>
</form>
```
*Why? `{% csrf_token %}` is a crucial security feature that stops hackers from submitting forms on your behalf from another website. Without it, Django will reject the form with a 403 error. `{{ form.as_p }}` tells Django to render all form fields wrapped in HTML `<p>` tags — including any validation error messages automatically.*

---

## 5. ModelForms: Connecting a Form Directly to a Model

Most of the time, the data submitted in a form needs to be saved to the database. Instead of writing a Form that perfectly mirrors a Model, we can use a **ModelForm** — it reads the model and generates the form fields automatically.

```python
# forms.py
from django import forms
from .models import Book

class BookForm(forms.ModelForm):
    class Meta:
        model = Book
        fields = ['title', 'author', 'published_year']
        # Alternative: include every field from the model
        # fields = '__all__'
```
*Why? By inheriting from `forms.ModelForm` and using the `Meta` class, Django looks at the `Book` model and automatically generates the exact form fields needed. If `published_year` is an `IntegerField` in the model, Django will ensure the user can only type numbers in the form!*

### Saving a ModelForm to the Database

When using a `ModelForm`, calling `form.save()` writes the validated data directly to the database:

```python
# views.py
from django.shortcuts import render, redirect
from .forms import BookForm

def add_book(request):
    if request.method == 'POST':
        form = BookForm(request.POST)
        if form.is_valid():
            form.save()                  # writes the new Book to the database
            return redirect('book_list') # redirect so the user can't re-submit
    else:
        form = BookForm()

    return render(request, 'catalog/add_book.html', {'form': form})
```

---

## 6. Form Field Validation

What if we want custom rules? Like "The author's name must start with 'A'"? We write a `clean_<fieldname>()` method. Django automatically calls these methods during `form.is_valid()`.

```python
class BookForm(forms.ModelForm):
    class Meta:
        model = Book
        fields = ['title', 'author', 'published_year']
    
    def clean_author(self):
        author_name = self.cleaned_data.get('author')
        if author_name and not author_name.startswith('A'):
            raise forms.ValidationError("The author's name must start with the letter A.")
        return author_name
```
*Why? If the rule is violated, `ValidationError` is raised and the form is sent back to the user with the error message displayed next to the field — automatically, with no extra template code needed.*

---

## 7. Widgets and Form Arguments

Widgets determine the *HTML output* of a field. For instance, a `CharField` defaults to `<input type="text">`, but you can change it to a password field or a text area.

```python
class LoginForm(forms.Form):
    username = forms.CharField(
        max_length=50, 
        label="Your Username",          # changes the label text shown on screen
        help_text="Case sensitive!"     # shows a hint below the field
    )
    password = forms.CharField(
        widget=forms.PasswordInput(attrs={'placeholder': 'Enter Password'})
    )
```
*Why? Form Arguments (`label`, `help_text`, `required=False`) control the logic and display text. Widgets (`PasswordInput`) control the specific HTML element and its attributes (like CSS classes or placeholders), ensuring the user's keystrokes are hidden.*

---

## Recommended Video Tutorials
Students can search for the following excellent YouTube tutorials on their own to supplement this session:

1. Corey Schafer - Django Tutorial Part 6: Forms
2. Tech With Tim - Django Tutorial - Forms
3. JustDjango - Django Forms Tutorial
4. Dennis Ivy - Django ModelForms
