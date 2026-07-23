$base_dir = "c:\Projects\Aptech\Django"

$videos = @{
    "Week_01\Session_01_Introduction_and_MVT\course_material.md" = @(
        "UmljXZIypDc", "rHux0gMZ3Eg", "z5vYxU3N4Q0", "llbtoQTt4qw"
    )
    "Week_01\Session_02_Creating_a_Website\course_material.md" = @(
        "a48xeeo5Vnk", "n-FTlQ7DTzE", "F5mRW0jo-U4", "llbtoQTt4qw"
    )
    "Week_01\Session_03_Practice\course_material.md" = @(
        "w8oQQhiwVQU", "vUqCPOgEIfA", "UmljXZIypDc", "rHux0gMZ3Eg"
    )
    "Week_01\Session_04_Admin_Panel\course_material.md" = @(
        "aHcO4OexY8Y", "9B2mK8SjW7Y", "z5vYxU3N4Q0", "llbtoQTt4qw"
    )
    "Week_02\Session_05_View_Creation\course_material.md" = @(
        "a48xeeo5Vnk", "t4DXXoE-a9M", "OQJ0K1_K2fE", "llbtoQTt4qw"
    )
    "Week_02\Session_06_Practice\course_material.md" = @(
        "z5vYxU3N4Q0", "Z4ikXG1NAqc", "rHux0gMZ3Eg", "a48xeeo5Vnk"
    )
    "Week_02\Session_07_Forms\course_material.md" = @(
        "qLRx9b1OOxo", "SMHn1yE14s4", "yD3zYkFzQyE", "llbtoQTt4qw"
    )
    "Week_02\Session_08_Templates\course_material.md" = @(
        "qDwdMDQ8oX4", "SMHn1yE14s4", "OQJ0K1_K2fE", "llbtoQTt4qw"
    )
    "Week_03\Session_09_Practice\course_material.md" = @(
        "qLRx9b1OOxo", "rHux0gMZ3Eg", "F5mRW0jo-U4", "llbtoQTt4qw"
    )
    "Week_03\Session_10_Serializers\course_material.md" = @(
        "pt7Zk0ZusA8", "cjqAtr_X4-w", "xI1Yq5N5ZcM", "z5vYxU3N4Q0"
    )
    "Week_03\Session_11_REST_Framework\course_material.md" = @(
        "pt7Zk0ZusA8", "rHux0gMZ3Eg", "OQJ0K1_K2fE", "c708Nf0q8Ds"
    )
    "Week_03\Session_12_Practice\course_material.md" = @(
        "pt7Zk0ZusA8", "-s7e_Fy6GQg", "c708Nf0q8Ds", "cjqAtr_X4-w"
    )
}

foreach ($key in $videos.Keys) {
    $filepath = Join-Path $base_dir $key
    if (Test-Path $filepath) {
        $content = "`n`n## Recommended Video Tutorials`n"
        $content += "Supplement this session with these excellent YouTube tutorials:`n`n"
        
        $i = 1
        foreach ($id in $videos[$key]) {
            $content += "$i. [![Video $i](https://img.youtube.com/vi/$id/0.jpg)](https://www.youtube.com/watch?v=$id)`n"
            $i++
        }
        
        Add-Content -Path $filepath -Value $content
        Write-Host "Updated $filepath"
    } else {
        Write-Host "File not found: $filepath"
    }
}
