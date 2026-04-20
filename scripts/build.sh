#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"
mkdir -p output

build_doc() {
  local file="$1"

  if command -v latexmk >/dev/null 2>&1; then
    latexmk -xelatex -interaction=nonstopmode -halt-on-error -output-directory=output "$file"
  elif command -v xelatex >/dev/null 2>&1; then
    xelatex -interaction=nonstopmode -halt-on-error -output-directory=output "$file"
    xelatex -interaction=nonstopmode -halt-on-error -output-directory=output "$file"
  elif command -v pdflatex >/dev/null 2>&1; then
    pdflatex -interaction=nonstopmode -halt-on-error -output-directory=output "$file"
    pdflatex -interaction=nonstopmode -halt-on-error -output-directory=output "$file"
  else
    echo "No LaTeX compiler found. Install TeX Live or MiKTeX." >&2
    exit 1
  fi
}

build_doc cv.tex
build_doc cover-letter.tex

echo
echo "Build completed. PDFs are available in output/."
