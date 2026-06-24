# Session 1: Basics of Python

Welcome to **Application Based Programming in Python**! In this course, we won't just be learning theory—we will be building practical, real-world projects. By the end of this module, you will have built web apps, scraped data from the internet, and even trained a machine learning model.

But first, we need to build our foundation. 

---

## 1. What is Python?

**Python** is a high-level, interpreted programming language known for its simplicity and readability. 
Imagine Python as plain English; it focuses on *what* you want to do rather than the complex syntax of *how* to do it.

**Why Python?**
- **Beginner-Friendly:** Its syntax is clean and easy to understand.
- **Versatile:** Used for Web Development (Django, Flask), Data Science (Pandas), AI/Machine Learning, and Automation.
- **Huge Community:** If you get stuck, there is an answer online!

---

## 2. Keywords, Identifiers, and Naming Rules

### Keywords
Keywords are reserved words in Python that have special meanings. You cannot use them as names for your own data.
*Examples:* `True`, `False`, `if`, `else`, `for`, `while`, `def`, `return`.

### Identifiers
An **identifier** is a name you give to entities like variables, functions, or classes. It's how you identify them.

**Rules for Naming Identifiers:**
1. Can only contain letters (a-z, A-Z), numbers (0-9), and underscores (`_`).
2. **Cannot start with a number.** (`1name` is invalid, `name1` is valid).
3. **Case-Sensitive:** `Age`, `age`, and `AGE` are three different identifiers.
4. Cannot be a Python keyword.

> **Pro Tip:** Use descriptive names! Instead of naming a variable `x`, name it `student_age`.

---

## 3. Statements, Comments, and Indentation

### Statements
A statement is an instruction that the Python interpreter can execute.
```python
# This is a print statement
print("Hello, World!")
```

### Comments
Comments are notes written in the code for humans to read. Python completely ignores them. They are crucial for explaining *why* your code does what it does.
- **Single-line comment:** Starts with a hash symbol `#`.
- **Multi-line comment:** Enclosed in triple quotes `'''` or `"""`.

```python
# This prints a welcome message
print("Welcome to Python!") 

"""
This is a multi-line comment.
We use it to write longer explanations or document our code.
"""
```

### Indentation: Python's Superpower
Unlike other languages (like C++ or Java) that use curly braces `{}` to group code, Python uses **indentation** (spaces at the beginning of a line). 
*Standard practice is to use 4 spaces per indentation level.*

```python
# Correct Indentation
if True:
    print("This line is indented!")
    print("This belongs to the if block.")
print("This is outside the block.")
```

---

## 4. Variables and Assigning Values

Think of a **variable** as a labeled storage box. You can put data inside the box, and whenever you need that data, you just call the label on the box.

Python is dynamically typed, meaning you don't need to declare what type of data the box will hold. Python figures it out automatically!

### Creating a Variable
Use the assignment operator `=` to store a value in a variable.

```python
# Assigning values to variables
player_name = "Alice"  # Storing text (String)
score = 150            # Storing a whole number (Integer)
health = 99.5          # Storing a decimal (Float)
is_active = True       # Storing a True/False value (Boolean)

# Let's print our variables
print("Player:", player_name)
print("Score:", score)
```

### Multiple Assignment
You can assign values to multiple variables in a single line!

```python
x, y, z = 10, 20, 30
print(x) # Output: 10
print(y) # Output: 20
```

---

## 🏋️ Class Task: Try It Yourself

Now it's your turn! Open your Python environment (IDLE or VS Code) and write a script that does the following:
1. Create a variable called `course_name` and assign it the value `"Python Programming"`.
2. Create a variable called `duration_weeks` and assign it the value `5`.
3. Create a variable called `is_hard` and assign it the boolean value `False`.
4. Use `print()` statements to display all three variables with a descriptive message for each.

*Example Output:*
```text
Welcome to Python Programming
This course lasts for 5 weeks.
Is it hard? False
```

---

## 🚀 Assignment: Mini-Project 1 Kickoff (The Profile Card)

We are going to build an interactive CLI (Command Line Interface) application over the next few sessions. 
For your first assignment, create a Python script named `profile_setup.py`:

1. Write a multi-line comment at the top of the file describing what the script does (e.g., "This script stores and prints my application profile.").
2. Create **four** properly named variables storing the following information about yourself or a fictional character:
   - First Name
   - Age
   - Favorite Color
   - Are you a programmer? (True/False)
3. Print these variables out in a formatted, easy-to-read way. Ensure your code is well-commented.
