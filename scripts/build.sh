#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"
mkdir -p output

usage() {
  cat <<'EOF'
Usage: scripts/build.sh [build|clean]

Commands:
  build   Build cv.tex and cover-letter.tex (default)
  clean   Remove LaTeX intermediate files in root and output/
EOF
}

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

clean_intermediate_files() {
  # Remove common LaTeX auxiliary files while preserving generated PDFs.
  find . -maxdepth 1 -type f \( \
    -name '*.aux' -o \
    -name '*.fdb_latexmk' -o \
    -name '*.fls' -o \
    -name '*.log' -o \
    -name '*.out' -o \
    -name '*.toc' -o \
    -name '*.xdv' -o \
    -name '*.dvi' -o \
    -name '*.synctex.gz' \
  \) -delete

  find output -type f \( \
    -name '*.aux' -o \
    -name '*.fdb_latexmk' -o \
    -name '*.fls' -o \
    -name '*.log' -o \
    -name '*.out' -o \
    -name '*.toc' -o \
    -name '*.xdv' -o \
    -name '*.dvi' -o \
    -name '*.synctex.gz' \
  \) -delete

  echo "Clean completed. Intermediate files removed."
}

COMMAND="${1:-build}"

case "$COMMAND" in
  build)
    build_doc cv.tex
    build_doc cover-letter.tex

    echo
    echo "Build completed. PDFs are available in output/."
    ;;
  clean)
    clean_intermediate_files
    ;;
  -h|--help|help)
    usage
    ;;
  *)
    echo "Unknown command: $COMMAND" >&2
    echo
    usage
    exit 1
    ;;
esac
