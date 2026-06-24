# Session 2: Programming Language Construct

Welcome back! In Session 1, we learned how to store basic data in variables. Today, we're going to dive deeper into **Data Types**, see how to manipulate them using **Operators**, and learn how to make our programs make decisions using **Control Flow Statements**.

---

## 1. Data Types in Python

In Python, every value has a specific "type". This tells Python what kind of operations we can perform on that data.

### Core Data Types:
1. **Numeric Types:**
   - **Integer (`int`):** Whole numbers (e.g., `10`, `-5`, `0`).
   - **Float (`float`):** Decimal numbers (e.g., `3.14`, `-0.001`).
2. **Text Type (`str`):** Strings of characters enclosed in quotes (e.g., `"Hello"`, `'Python'`).
3. **Boolean Type (`bool`):** Represents `True` or `False` values.

### Collection Data Types (A Quick Preview!):
Later in the course, we will use these to store multiple items in a single variable:
- **List (`list`):** An ordered, changeable collection `[1, 2, "apple"]`.
- **Tuple (`tuple`):** An ordered, unchangeable collection `(1, 2, "apple")`.
- **Dictionary (`dict`):** A collection of key-value pairs `{"name": "Alice", "age": 25}`.

*You can check the type of any variable using the `type()` function!*
```python
age = 20
print(type(age))  # Output: <class 'int'>
```

---

## 2. Python Operators

Operators are special symbols used to carry out calculations or logical operations.

### Arithmetic Operators
Used for math calculations.
- `+` (Addition): `5 + 3` results in `8`
- `-` (Subtraction): `5 - 3` results in `2`
- `*` (Multiplication): `5 * 3` results in `15`
- `/` (Division): `10 / 2` results in `5.0`
- `%` (Modulus/Remainder): `10 % 3` results in `1` (because 10 divided by 3 leaves a remainder of 1)

### Comparison (Relational) Operators
Used to compare two values. They always result in a Boolean (`True` or `False`).
- `==` (Equal to): `5 == 5` is `True`
- `!=` (Not equal): `5 != 3` is `True`
- `>` (Greater than): `10 > 5` is `True`
- `<` (Less than): `2 < 1` is `False`
- `>=` and `<=` (Greater/Less than or equal to).

### Logical Operators
Used to combine conditional statements.
- `and`: Returns `True` if BOTH statements are true. (`x > 5 and x < 10`)
- `or`: Returns `True` if ONE of the statements is true. (`x == 5 or x == 10`)
- `not`: Reverses the result. (`not(True)` becomes `False`)

---

## 3. Control Flow Statements

Programs usually run from top to bottom. But what if we want to skip some code or repeat it? We use control flow!

### Conditional Statements (`if`, `elif`, `else`)
These statements allow your code to make decisions based on conditions.

```python
weather = "rainy"

if weather == "sunny":
    print("Let's go to the park!")
elif weather == "rainy":
    print("Take an umbrella!")
else:
    print("Stay inside just in case.")
```
*(Notice the indentation? Everything indented under the `if` belongs to that block!)*

### Looping Statements (`for` and `while`)
Loops allow you to execute a block of code multiple times.

**The `for` loop:** Best used when you know exactly how many times you want to iterate.
```python
# The range(5) function generates numbers from 0 to 4
for i in range(5):
    print("Iteration number:", i)
```

**The `while` loop:** Best used when you want to repeat code *as long as* a condition remains `True`.
```python
count = 3
while count > 0:
    print("Countdown:", count)
    count = count - 1  # Decrease count so the loop eventually stops!
print("Blastoff!")
```

---

## 🏋️ Class Task: Try It Yourself

Open your Python environment and write a script to build an **Age Checker**:
1. Create a variable called `user_age` and assign it a number (e.g., `16`).
2. Write an `if-elif-else` statement:
   - If the age is **18 or older**, print `"Access Granted: You are an adult."`
   - If the age is **between 13 and 17 (inclusive)**, print `"Partial Access: You are a teenager."` (Hint: use the `and` operator).
   - Else, print `"Access Denied: You are too young."`
3. Change the `user_age` variable and run the code multiple times to test all three outcomes!

---

## 🚀 Assignment: Mini-Project 1 Expansion (The Interactive Profile)

Let's make our CLI app interactive! Up until now, we hard-coded our variables. Let's ask the user for input.
*(Hint: You can use `input("Prompt message: ")` to ask the user for data in the terminal. By default, `input()` saves data as a String).*

1. Update your `profile_setup.py` script from Session 1.
2. Instead of hard-coding your variables, use `input()` to ask the user for their:
   - Name
   - Age (Convert this to an integer using the `int()` function, e.g., `age = int(input("Age: "))`)
3. Write a `for` loop using `range(3)` that asks the user: `"Name one of your favorite hobbies:"` and prints it back to them.
4. Add a control flow statement at the end: If their age is `>= 18`, print `"Profile created for an adult."` Else, print `"Profile created for a minor."`
