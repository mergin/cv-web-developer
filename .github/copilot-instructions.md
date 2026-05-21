# Copilot Instructions for This Project

This repository contains a modular LaTeX CV and cover letter template for a web developer profile.

## Project Structure

- `cv.tex` and `cover-letter.tex` are the only document entry points.
- `sections/` contains the editable content blocks for profile, skills, work experience, projects, education, and languages.
- `styles/moderncvweb.sty` contains shared layout, typography, color, and macro definitions.
- `scripts/build.ps1` and `scripts/build.sh` are the supported build entry points.
- `output/` contains generated build artifacts and should be treated as derived output.

## Editing Rules

- Prefer editing files in `sections/` when the request is about resume or cover-letter content.
- Keep shared personal data centralized in `sections/profile.tex` using the existing `\Profile...` macros.
- Prefer reusing or extending macros in `styles/moderncvweb.sty` instead of duplicating formatting inline in `cv.tex`, `cover-letter.tex`, or section files.
- Keep the CV and cover letter modular. Do not collapse section content back into the top-level `.tex` entry files unless the change is explicitly about document structure.
- Preserve the minimalist visual style already established in `styles/moderncvweb.sty`.
- Keep skill groups ordered from highest rating to lowest within each category unless the user explicitly asks for a different ordering.
- Use ASCII by default in edits unless the file already requires LaTeX escapes or non-ASCII content.

## Build and Validation

- After LaTeX changes, validate with the existing build scripts instead of inventing new commands.
- On Windows, prefer `./scripts/build.ps1`.
- On Bash-compatible environments, prefer `bash ./scripts/build.sh`.
- Assume `latexmk` with `xelatex` is the preferred path when available, with `xelatex` or `pdflatex` as fallbacks as already implemented by the scripts.
- Do not edit files under `output/` manually unless the user explicitly asks to inspect generated artifacts.

## Style Guidance

- Keep spacing and typography changes localized and intentional.
- Favor existing helper macros such as `\cventry`, `\projectentry`, `\cvskill`, `\smallmuted`, and `\caps` before introducing new formatting patterns.
- If a new visual pattern is needed, add it to `styles/moderncvweb.sty` so it can be reused consistently.
- Preserve compatibility with environments that may not have optional packages like `fontawesome5`.

## When Responding to Requests

- For content updates, optimize for concise, credible resume language with measurable impact when possible.
- For visual or layout updates, explain any tradeoff that affects spacing, page fit, or LaTeX package compatibility.
- Keep changes focused. Avoid broad rewrites of unrelated sections.