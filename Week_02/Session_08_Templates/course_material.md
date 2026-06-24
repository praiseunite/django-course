# Session 8: Django Templates

We've been returning raw HTML strings or extremely simple HTML files from our views so far. Today, we focus heavily on the "T" in MVT. Django's Template Engine allows us to dynamically inject Python data into static HTML files, making our websites truly dynamic.

---

## 1. What are Django Templates?
A Django Template is basically an HTML file that has been supercharged with a special "Django Template Language" (DTL). DTL allows you to write loops, `if` statements, and inject variables directly into your HTML.

![Django Template Engine](../../assets/django_template_engine_1782301165343.png)

*Why? Standard HTML is completely static. If you have 100 students, writing 100 `<li>` tags in HTML is impossible. A template allows you to write one `<li>` tag inside a loop, and Django generates the 100 tags for you before sending the page to the user.*

## 2. Designing Template Folders
Django is very strict about where it looks for template files. 
Inside your app folder, you must create a folder called `templates`. But if multiple apps have a file named `index.html`, Django might get confused.

**Best Practice Folder Structure:**
```text
my_app/
    templates/
        my_app/           <-- Notice we repeat the app name!
            index.html
            about.html
```
*Why? By nesting an extra folder with the app's name inside the `templates` folder, we create a "namespace". Now Django looks for `my_app/index.html` instead of just `index.html`, preventing conflicts with other apps.*

## 3. Creating HTML Files Inside Template Folders
Once the folder structure is set, you simply create standard `.html` files. You can write normal HTML, CSS, and JavaScript in these files.

## 4. Rendering Context in a Template
How does the data actually get from the database to the HTML file? Through a "Context Dictionary".

In your `views.py`:
```python
def student_profile(request):
    # This dictionary is the "Context"
    context = {
        'student_name': 'Alice Smith',
        'grade': 'A',
        'is_graduating': True
    }
    return render(request, 'my_app/profile.html', context)
```
*Why? The `render` function takes the `context` dictionary and securely hands it over to the template engine.*

## 5. Outline Tags in Templates (`{% %}`)
Tags provide logic in the rendering process. If it looks like Python code (loops, imports, logic), it goes inside `{% %}`.

```html
<!-- Example of a For Loop Tag -->
<ul>
{% for student in student_list %}
    <li>{{ student.name }}</li>
{% endfor %}
</ul>
```

## 6. List the Conditions in Templates (`{% if %}`)
You can use `if`, `elif`, and `else` tags to dynamically show or hide parts of the webpage based on the context data.

```html
{% if is_graduating %}
    <h1>Congratulations Graduate!</h1>
{% elif grade == 'A' %}
    <h1>Great job this year!</h1>
{% else %}
    <h1>Keep studying!</h1>
{% endif %}
```
*Why? This allows you to serve a completely personalized webpage to different users using the exact same HTML file.*

## 7. Outline Template Filters (`|`)
Filters transform the values of variables *before* they are displayed. You apply a filter using a pipe character `|`.

```html
<!-- If student_name is 'alice smith', this displays 'Alice smith' -->
<p>{{ student_name|capfirst }}</p>

<!-- Displays the length of a list -->
<p>Total Students: {{ student_list|length }}</p>

<!-- Formats a date -->
<p>Joined on: {{ join_date|date:"F j, Y" }}</p>
```

## 8. Define Form in Template
We covered this briefly in Session 7, but it's important to remember that forms are injected via context just like any other variable.

```html
<form method="POST">
    {% csrf_token %}
    
    <!-- Render the form as a table -->
    <table>
        {{ my_form.as_table }}
    </table>
    
    <button type="submit">Save</button>
</form>
```
*Why? The CSRF tag is mandatory for POST forms to prevent malicious cross-site attacks. `as_table`, `as_p`, and `as_ul` are built-in shortcuts to render the form fields quickly.*


## Recommended Video Tutorials
Supplement this session with these excellent YouTube tutorials:

1. [![Video 1](https://img.youtube.com/vi/qDwdMDQ8oX4/0.jpg)](https://www.youtube.com/watch?v=qDwdMDQ8oX4)
2. [![Video 2](https://img.youtube.com/vi/SMHn1yE14s4/0.jpg)](https://www.youtube.com/watch?v=SMHn1yE14s4)
3. [![Video 3](https://img.youtube.com/vi/OQJ0K1_K2fE/0.jpg)](https://www.youtube.com/watch?v=OQJ0K1_K2fE)
4. [![Video 4](https://img.youtube.com/vi/llbtoQTt4qw/0.jpg)](https://www.youtube.com/watch?v=llbtoQTt4qw)

