# Class Task: The Dynamic Report Card

**Objective:** Practice using context dictionaries, if statements, loops, and filters to build a dynamic report card page.

### Step 1: The Setup
1. Open the `school_project` and the `directory` app.
2. In `directory/views.py`, create a new view called `report_card`.

### Step 2: The Context Dictionary
Inside your `report_card` view, create a complex context dictionary (pretend this came from a database):
```python
def report_card(request):
    student_data = {
        'name': 'johnathan doe',
        'gpa': 3.8,
        'is_honors': True,
        'classes': ['Math', 'Science', 'History', 'Art']
    }
    return render(request, 'directory/report.html', student_data)
```

### Step 3: The Template Folder Setup
Ensure you have the correct namespaced folder structure:
`school_project/directory/templates/directory/report.html`

### Step 4: Building the Template
Open `report.html` and write the DTL to achieve the following:
1. Display the student's name, but use a template filter to capitalize every word (`title` filter).
2. Display their GPA.
3. Use an `{% if %}` statement: If `is_honors` is True, show a golden star emoji (🌟) or a "Congratulations!" message.
4. Use a `{% for %}` loop to list out all the items in the `classes` list as an unordered list (`<ul>`).

### Step 5: Test
Route your view in `urls.py` and run your server to view the final, dynamic HTML!
