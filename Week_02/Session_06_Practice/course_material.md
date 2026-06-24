# Session 6: Practice & "Try It Yourself" Lab

Welcome to the second dedicated lab session! Today's focus is on reinforcing the concepts learned in Book Sessions 4 & 5 (Our Sessions 4 & 5): Creating Superusers, managing the Django Admin Interface, and building both Function-Based and Class-Based Views.

---

## Presenter's Guide

This is a facilitator-led session. Students should spend the majority of the time coding.

### 1. Structure of the Session
*   **First 15 Minutes:** Quick recap of the Django Admin panel and the structural differences between FBVs and CBVs.
*   **Next 90 Minutes:** Students work on the `class_task.md` challenges. Encourage them to help each other debug.
*   **Last 15 Minutes:** Code review. Call a student up to the projector (or share their screen) to show how they solved the Class-Based View challenge.

### 2. Common Pitfalls to Watch Out For
*   **Admin Registration:** Students often create a model but forget to register it in `admin.py`. If they complain "My table isn't in the dashboard!", remind them to check `admin.site.register()`.
*   **Migrations:** If they add a new field to a model (like adding a `price` to a `Product` model) but forget to run `makemigrations` and `migrate`, the database will crash when they try to save it in the Admin panel.
*   **CBV Template Missing:** When using `ListView` or `TemplateView`, Django expects a specific template name by default (e.g., `modelname_list.html`). If they get a `TemplateDoesNotExist` error, they need to explicitly set `template_name = 'their_file.html'` in the class.
*   **URL `.as_view()`:** Forgetting to append `.as_view()` when routing a Class-Based View in `urls.py` will result in a complex TypeError.

### 3. Reviewing the Solutions
Focus the final review on the Class-Based View syntax. Make sure students understand *why* they use `context_object_name` and *why* they inherit from `ListView`.


## Recommended Video Tutorials
Supplement this session with these excellent YouTube tutorials:

1. **Tech With Tim** - [Django Framework Tutorial](https://www.youtube.com/watch?v=z5vYxU3N4Q0)
2. **Corey Schafer** - [Django Tutorial Part 11: Pagination](https://www.youtube.com/watch?v=Z4ikXG1NAqc)
3. **Programming with Mosh** - [Django App Practice](https://www.youtube.com/watch?v=rHux0gMZ3Eg)
4. **Corey Schafer** - [Django Applications](https://www.youtube.com/watch?v=a48xeeo5Vnk)

