# Assignment: Session 12

**Submission Guidelines:** Submit a ZIP file of your `my_blog` project folder.

### The "Personal Blog" Project - Part 4 (Final API Touch)

Your blog API works, but let's make it more professional by controlling exactly what data gets exposed to the internet.

**Requirements:**
1. Open your `my_blog` project.
2. Open your `PostSerializer`.
3. **Customization Challenge:** We don't want the API to return the *entire* blog content string if it's super long. Add a custom field to your serializer called `summary`.
4. Use a `SerializerMethodField` to define `summary`.
5. Write the `get_summary(self, obj)` method so it only returns the first 50 characters of the `obj.content`.
6. Add `summary` to the `fields` list in the `Meta` class.
7. Run your server and verify that the JSON output now includes this custom `summary` field.

**Deliverable:**
Zip your `my_blog` folder (without the `venv`) and submit it. The instructor will check your `serializers.py` to see the custom method implementation.
