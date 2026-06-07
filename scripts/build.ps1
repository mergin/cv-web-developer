param(
    [switch]$Clean
)

$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
Set-Location $root

New-Item -ItemType Directory -Force -Path output | Out-Null

function Build-Document {
    param([string]$FileName)

    if (Get-Command latexmk -ErrorAction SilentlyContinue) {
        & latexmk -xelatex -interaction=nonstopmode -halt-on-error -output-directory=output $FileName
        if ($LASTEXITCODE -ne 0) { throw "latexmk failed for $FileName" }

        if ($Clean) {
            & latexmk -c -output-directory=output $FileName | Out-Null
        }
    }
    elseif (Get-Command xelatex -ErrorAction SilentlyContinue) {
        & xelatex -interaction=nonstopmode -halt-on-error -output-directory=output $FileName
        if ($LASTEXITCODE -ne 0) { throw "xelatex failed for $FileName" }

        & xelatex -interaction=nonstopmode -halt-on-error -output-directory=output $FileName
        if ($LASTEXITCODE -ne 0) { throw "xelatex failed for $FileName on second pass" }
    }
    elseif (Get-Command pdflatex -ErrorAction SilentlyContinue) {
        & pdflatex -interaction=nonstopmode -halt-on-error -output-directory=output $FileName
        if ($LASTEXITCODE -ne 0) { throw "pdflatex failed for $FileName" }

        & pdflatex -interaction=nonstopmode -halt-on-error -output-directory=output $FileName
        if ($LASTEXITCODE -ne 0) { throw "pdflatex failed for $FileName on second pass" }
    }
    else {
        throw 'No LaTeX compiler was found. Install TeX Live or MiKTeX first.'
    }
}

Build-Document 'cv.tex'
Build-Document 'cv-ats.tex'
Build-Document 'cover-letter.tex'

Write-Host ''
Write-Host 'Build completed successfully. Generated files:' -ForegroundColor Green
Get-ChildItem -Path output -Filter *.pdf | Select-Object Name, Length
