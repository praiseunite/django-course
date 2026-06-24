$base_dir = "c:\Projects\Aptech\Django"

$videos = @{
    "Week_01\Session_01_Introduction_and_MVT\course_material.md" = @(
        "Corey Schafer - Django Tutorial Part 1: Getting Started",
        "Programming with Mosh - Django Tutorial for Beginners",
        "Tech With Tim - Django Framework Tutorial - Part 1",
        "Dennis Ivy - Django Crash Course"
    )
    "Week_01\Session_02_Creating_a_Website\course_material.md" = @(
        "Corey Schafer - Django Tutorial Part 2: Applications & Routes",
        "Traversy Media - Django Crash Course",
        "FreeCodeCamp - Django Web Development Course",
        "Dennis Ivy - Django App Routing"
    )
    "Week_01\Session_03_Practice\course_material.md" = @(
        "CS50 - CS50 Web Programming - Django",
        "JustDjango - Django Beginner Course",
        "Corey Schafer - Django Tutorial Part 1",
        "Programming with Mosh - Django Tutorial for Beginners"
    )
    "Week_01\Session_04_Admin_Panel\course_material.md" = @(
        "Corey Schafer - Django Tutorial Part 4: Admin Page",
        "Very Academy - Django Admin Panel Customization",
        "Tech With Tim - Django Framework Tutorial - Admin",
        "Dennis Ivy - Django Admin Crash Course"
    )
    "Week_02\Session_05_View_Creation\course_material.md" = @(
        "Corey Schafer - Django Tutorial Part 2: Views",
        "JustDjango - Class Based Views Tutorial",
        "Very Academy - Django Class Based Views",
        "Dennis Ivy - Views and Routing"
    )
    "Week_02\Session_06_Practice\course_material.md" = @(
        "Tech With Tim - Django Framework Tutorial",
        "Corey Schafer - Django Tutorial Part 11: Pagination",
        "Programming with Mosh - Django App Practice",
        "Corey Schafer - Django Applications"
    )
    "Week_02\Session_07_Forms\course_material.md" = @(
        "Corey Schafer - Django Tutorial Part 6: Forms",
        "Tech With Tim - Django Tutorial - Forms",
        "JustDjango - Django Forms Tutorial",
        "Dennis Ivy - Django ModelForms"
    )
    "Week_02\Session_08_Templates\course_material.md" = @(
        "Corey Schafer - Django Tutorial Part 3: Templates",
        "Tech With Tim - Django Tutorial - HTML Templates",
        "Very Academy - Django Template Language",
        "Dennis Ivy - Django Templates"
    )
    "Week_03\Session_09_Practice\course_material.md" = @(
        "Corey Schafer - Django Tutorial Part 6: Form Practice",
        "Programming with Mosh - Django Models and Forms",
        "FreeCodeCamp - Django Forms & Templates Practice",
        "Dennis Ivy - Django Forms Review"
    )
    "Week_03\Session_10_Serializers\course_material.md" = @(
        "Dennis Ivy - Django REST Framework API",
        "JustDjango - Django REST Framework Basics",
        "CodingEntrepreneurs - Django REST API Series",
        "Tech With Tim - Django API Tutorial"
    )
    "Week_03\Session_11_REST_Framework\course_material.md" = @(
        "Dennis Ivy - Build a REST API",
        "Programming with Mosh - Django API Tutorial",
        "Very Academy - Django REST Framework Viewsets",
        "FreeCodeCamp - Django REST API Full Course"
    )
    "Week_03\Session_12_Practice\course_material.md" = @(
        "Dennis Ivy - Django REST API Project",
        "Corey Schafer - Django Update/Delete Operations",
        "FreeCodeCamp - REST Framework Practice",
        "JustDjango - API Building Guide"
    )
}

foreach ($key in $videos.Keys) {
    $filepath = Join-Path $base_dir $key
    if (Test-Path $filepath) {
        $content = Get-Content -Path $filepath -Raw
        $index = $content.IndexOf("## Recommended Video Tutorials")
        if ($index -ge 0) {
            $content = $content.Substring(0, $index)
        }
        
        $new_section = "## Recommended Video Tutorials`n"
        $new_section += "Students can search for the following excellent YouTube tutorials on their own to supplement this session:`n`n"
        
        $i = 1
        foreach ($text in $videos[$key]) {
            $new_section += "$i. $text`n"
            $i++
        }
        
        $content += $new_section
        Set-Content -Path $filepath -Value $content
        Write-Host "Updated $filepath"
    }
}
