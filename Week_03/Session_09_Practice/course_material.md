# Session 9: Practice & "Try It Yourself" Lab

Welcome to Week 3! Today is our final dedicated practice session before we dive into APIs. The goal today is to master the interaction between **Forms** and **Templates** — specifically, making forms that actually write to the database.

---

## Student Quick Reference

Use this as a cheat sheet while you work through the tasks.

### The Complete Form Flow

Every form view follows this exact two-step pattern:

```python
# views.py
from django.shortcuts import render, redirect
from .forms import BookForm

def add_book(request):
    if request.method == 'POST':          # user clicked Submit
        form = BookForm(request.POST)     # bind their data to the form
        if form.is_valid():               # validate all the rules
            form.save()                   # write to the database
            return redirect('book_list')  # ALWAYS redirect after saving
    else:                                 # user just visited the page
        form = BookForm()                 # show an empty form

    return render(request, 'catalog/add_book.html', {'form': form})
```

### The Form Template Block

Every form template needs exactly this structure:

```html
<form method="POST">
    {% csrf_token %}
    {{ form.as_p }}
    <button type="submit">Save</button>
</form>
```

| Part | Why it's needed |
| :--- | :--- |
| `method="POST"` | Sends data securely in the request body |
| `{% csrf_token %}` | Security token — without it Django returns 403 Forbidden |
| `{{ form.as_p }}` | Renders all fields AND any validation errors automatically |
| `<button type="submit">` | Triggers the POST request |

### Creating a ModelForm

```python
# forms.py  (create this file in your app folder)
from django import forms
from .models import Book

class BookForm(forms.ModelForm):
    class Meta:
        model = Book
        fields = ['title', 'author', 'published_year']
        # or use fields = '__all__' to include every field
```

### Common Errors and Fixes

| Error | Cause | Fix |
| :--- | :--- | :--- |
| 403 Forbidden on submit | Missing `{% csrf_token %}` in template | Add `{% csrf_token %}` inside `<form>` |
| Form renders blank | Forgot to pass form in context | Change `render(...)` to include `{'form': form}` |
| Data not saving | Missing `form.save()` | Add `form.save()` inside the `if form.is_valid():` block |
| Data duplicates on refresh | Using `render()` after save instead of `redirect()` | Replace `render()` with `return redirect('view_name')` |
| Form shows no errors | Rendering form outside the `else` | Make sure `return render(...)` is OUTSIDE and AFTER the `if/else` block |

---

## Presenter's Guide

This lab session focuses on user interaction. Students will be building forms that actually write to the database.

### 1. The Core Concept to Review
Before letting students loose on the task, review this diagram on the projector:

![Form Submission Flow](../../assets/form_submission_flow_1782301433993.png)

Remind them of the "Two-Step" view process:
1.  **GET Request:** The view must instantiate an *empty* form and render it in the template.
2.  **POST Request:** The view must instantiate the form *with the user's data* (`request.POST`), validate it, save it, and redirect.

Emphasise the redirect: "If you render instead of redirect after saving, refreshing the browser re-sends the form. Your students will see duplicate data and wonder why."

### 2. Structure of the Session
*   **First 15 Minutes:** Review the `request.method == 'POST'` logic loop and `form.save()` + `redirect()` pattern using the Quick Reference above.
*   **Next 90 Minutes:** Students complete the `class_task.md` challenge.
*   **Last 15 Minutes:** Code review. Have a student explain how they used `{% csrf_token %}` and what happens when it's missing.

### 3. Common Pitfalls to Watch Out For
*   **Missing CSRF Token:** If a student complains they are getting a "403 Forbidden" error when they click submit, they forgot the `{% csrf_token %}` in their HTML.
*   **Forgetting to pass the form to the context:** If the template is blank, they likely forgot the `{'form': form}` dictionary in their `render()` function.
*   **The "Save loop":** If data isn't saving, check if they forgot the `form.save()` line, or if they accidentally put it outside the `form.is_valid()` check.
*   **Duplicate records on refresh:** They used `render()` instead of `redirect()` after `form.save()`.


## Recommended Video Tutorials
Students can search for the following excellent YouTube tutorials on their own to supplement this session:

1. Corey Schafer - Django Tutorial Part 6: Form Practice
2. Programming with Mosh - Django Models and Forms
3. FreeCodeCamp - Django Forms & Templates Practice
4. Dennis Ivy - Django Forms Review
