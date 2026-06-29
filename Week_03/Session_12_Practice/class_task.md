# Class Task: "Try It Yourself" Challenge - The Product Catalog API

**Objective:** Build a complete JSON API for an E-commerce Product Catalog from scratch — without step-by-step guidance. Use the Quick Reference in `course_material.md` if you get stuck.

---

### Task 1: Project & App Setup
1. Create a brand new Django project called `ecommerce`.
2. Inside it, create an app called `catalog`.
3. Install the Django REST Framework via your terminal.
4. Add both `catalog` and `rest_framework` to `INSTALLED_APPS` in `settings.py`.

---

### Task 2: The Model
1. Open `catalog/models.py` and create a `Product` model with these fields:
   * `name` — `CharField`
   * `description` — `TextField`
   * `price` — `DecimalField` *(Hint: look up `max_digits` and `decimal_places` — try `max_digits=8, decimal_places=2`)*
   * `in_stock` — `BooleanField`
2. Run `makemigrations` then `migrate`.

---

### Task 3: The API Layer

This is the core challenge. Wire up the full API without looking at previous session notes if possible.

**3a. Serializer**

Create `catalog/serializers.py` and write a `ProductSerializer` that:
- Inherits from `serializers.ModelSerializer`
- Is linked to the `Product` model
- Includes all fields

*Tip: Use `fields = '__all__'` to include every field automatically. Remember: two underscores on each side.*

**3b. ViewSet**

Open `catalog/views.py` and write a `ProductViewSet` that:
- Inherits from `viewsets.ModelViewSet`
- Has `queryset = Product.objects.all()`
- Points to `ProductSerializer`

**3c. Routing**

Create `catalog/urls.py`, set up a `DefaultRouter`, register your `ProductViewSet` to the prefix `products`, and include `router.urls` in the urlpatterns.

Then open your main project `urls.py` and include the catalog app's URLs under the path `api/`.

---

### Task 4: Test All CRUD Operations

Complete this checklist using the DRF Browsable API. Tick each one off as you finish it.

- [ ] **CREATE** — Visit `/api/products/`, scroll to the form at the bottom, add **3 distinct products** using POST
- [ ] **READ (list)** — Confirm all 3 products appear in the JSON response at `/api/products/`
- [ ] **READ (single)** — Visit `/api/products/1/` to retrieve just the first product
- [ ] **UPDATE (full)** — On `/api/products/1/`, use the PUT form to change the price and name of the product
- [ ] **UPDATE (partial)** — On `/api/products/2/`, use PATCH to change only the `in_stock` field (set it to `false`)
- [ ] **DELETE** — On `/api/products/3/`, click the DELETE button to remove the third product
- [ ] **VERIFY** — Go back to `/api/products/` and confirm only 2 products remain

---

### Bonus Challenge (If you finish early)

Add a `SerializerMethodField` called `price_with_tax` to your `ProductSerializer`. It should return the price multiplied by 1.075 (7.5% tax). Display it in your API response.

*Hint: Remember the naming rule — the method must be called `get_price_with_tax(self, obj)`, and you need to add `'price_with_tax'` to your `fields` list.*
