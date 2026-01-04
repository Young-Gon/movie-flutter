$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$pubspecFiles = Get-ChildItem -Recurse -Filter "pubspec.yaml" `
                -Exclude ".dart_tool", ".git", "ios", "android"

Write-Host "--- Found $( $pubspecFiles.Count ) packages ---" -ForegroundColor Cyan

foreach ($file in $pubspecFiles)
{
    $packagePath = $file.DirectoryName
    Write-Host "`n[Processing] Path: $packagePath" -ForegroundColor Yellow

    Push-Location $packagePath
    try
    {
        Write-Host "1. Running: flutter pub get"
        flutter pub get

        Write-Host "2. Running: build_runner"
        flutter pub run build_runner build --delete-conflicting-outputs

        Write-Host "[SUCCESS] Build completed!" -ForegroundColor Green
    }
    catch
    {
        Write-Host "[ERROR] Failed at $packagePath" -ForegroundColor Red
    }
    finally
    {
        Pop-Location
    }
}
Write-Host "`n--- All tasks finished ---" -ForegroundColor Cyan