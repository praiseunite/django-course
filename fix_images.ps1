$brain_dir = "C:\Users\DELL\.gemini\antigravity\brain\eb6d6fd2-4b74-49fc-953e-f80c9e1cf3a5"
$project_dir = "c:\Projects\Aptech\Django"
$assets_dir = "$project_dir\assets"

New-Item -ItemType Directory -Force -Path $assets_dir

Copy-Item -Path "$brain_dir\*.png" -Destination $assets_dir

Get-ChildItem -Path $project_dir -Filter "*.md" -Recurse | ForEach-Object {
    $content = Get-Content $_.FullName
    $new_content = $content -replace [regex]::Escape($brain_dir + "\"), "../../assets/"
    Set-Content -Path $_.FullName -Value $new_content
}
