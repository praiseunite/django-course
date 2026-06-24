# Class Task: "Try It Yourself" Challenge - The Product Catalog API

**Objective:** Build a robust JSON API for an E-commerce Product Catalog from scratch.

### Task 1: Project & App Setup
1. Create a brand new Django project called `ecommerce`.
2. Inside it, create an app called `catalog`.
3. Install the Django REST Framework via your terminal.
4. Add both `catalog` and `rest_framework` to `INSTALLED_APPS`.

### Task 2: The Model
1. Create a `Product` model in `catalog/models.py` with the following fields:
   * `name` (CharField)
   * `description` (TextField)
   * `price` (DecimalField - look up how to use `max_digits` and `decimal_places`!)
   * `in_stock` (BooleanField)
2. Make migrations and migrate.

### Task 3: The API Layer
This is the core challenge! Wire up the API without looking at previous session notes if possible.
1. **Serializer:** Create `catalog/serializers.py` and write a `ProductSerializer`.
2. **ViewSet:** Open `catalog/views.py` and write a `ProductViewSet`.
3. **Routing:** Create `catalog/urls.py`, set up a router, and register your ViewSet to the path `products`. Connect this to your main project `urls.py`.

### Task 4: Testing & Data Entry
1. Run your server.
2. Go to the API endpoint.
3. Use the DRF Browsable API to add at least 3 distinct products to your database.
4. Try to update the price of one product using a PUT request.
