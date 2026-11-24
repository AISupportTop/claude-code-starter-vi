# Cai bo skill + cau hinh toi uu cho Claude Code (Windows)
# Chay: powershell -ExecutionPolicy Bypass -File .\cai-dat.ps1
# Them skill tuy chon: powershell -ExecutionPolicy Bypass -File .\cai-dat.ps1 -TuyChon
param([switch]$TuyChon)

$ErrorActionPreference = "Stop"
$kit      = $PSScriptRoot
$claude   = Join-Path $HOME ".claude"
$skills   = Join-Path $claude "skills"
$stamp    = Get-Date -Format "yyyyMMdd-HHmmss"
$utf8     = New-Object System.Text.UTF8Encoding($false)

New-Item -ItemType Directory -Force -Path $skills | Out-Null

# 1. Skills
$nhom = @("skills-core")
if ($TuyChon) { $nhom += "skills-tuy-chon" }
foreach ($n in $nhom) {
  Get-ChildItem -Directory (Join-Path $kit $n) | ForEach-Object {
    $dich = Join-Path $skills $_.Name
    if (Test-Path $dich) { Rename-Item $dich "$($_.Name).bak-$stamp" }
    Copy-Item $_.FullName $dich -Recurse
    Write-Host "  + skill: $($_.Name)"
  }
}

# 2. CLAUDE.md toan cuc (khong ghi de file cu)
$md = Join-Path $claude "CLAUDE.md"
if (Test-Path $md) {
  Copy-Item (Join-Path $kit "config\CLAUDE.md") (Join-Path $claude "CLAUDE.kit.md") -Force
  Write-Host "  ! Da co CLAUDE.md -> luu ban moi thanh CLAUDE.kit.md, hay tu gop 2 file."
} else {
  Copy-Item (Join-Path $kit "config\CLAUDE.md") $md
  Write-Host "  + CLAUDE.md"
}

# 3. settings.json: chi them autoCompactWindow, giu nguyen cac thiet lap khac
$st = Join-Path $claude "settings.json"
if (Test-Path $st) {
  Copy-Item $st "$st.bak-$stamp"
  $raw = [IO.File]::ReadAllText($st).Trim()
  if ($raw -eq "") { $obj = [pscustomobject]@{} } else { $obj = $raw | ConvertFrom-Json }
} else { $obj = [pscustomobject]@{} }
$obj | Add-Member -NotePropertyName "autoCompactWindow" -NotePropertyValue 400000 -Force
[IO.File]::WriteAllText($st, ($obj | ConvertTo-Json -Depth 20), $utf8)
Write-Host "  + settings.json: autoCompactWindow = 400000 (ban cu, neu co, da luu thanh settings.json.bak-$stamp)"

Write-Host "`nXong. Mo lai Claude Code, go /skills de kiem tra, /autocompact de xem nguong."
