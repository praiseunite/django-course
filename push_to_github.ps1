git init
git remote add origin https://github.com/praiseunite/django-course.git
git branch -M main

echo "# Django Course Curriculum" > README.md
git add README.md
git add assets
git commit -m "Initial commit with README and Assets"
git push -u origin main

$sessions = @(
    "Week_01\Session_01_Introduction_and_MVT",
    "Week_01\Session_02_Creating_a_Website",
    "Week_01\Session_03_Practice",
    "Week_01\Session_04_Admin_Panel",
    "Week_02\Session_05_View_Creation",
    "Week_02\Session_06_Practice",
    "Week_02\Session_07_Forms",
    "Week_02\Session_08_Templates",
    "Week_03\Session_09_Practice",
    "Week_03\Session_10_Serializers",
    "Week_03\Session_11_REST_Framework",
    "Week_03\Session_12_Practice"
)

$i = 1
foreach ($session in $sessions) {
    git add $session
    git commit -m "Add Session $i"
    git push origin main
    $i++
}
