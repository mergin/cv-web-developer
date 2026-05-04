# Modern LaTeX CV Template for a Web Developer

A minimalist CV and cover letter template inspired by modern portfolio-style resume layouts, tailored for web developers.

## Features

- Modern, clean LaTeX design with strong typography and spacing
- Generates both a CV PDF and a cover letter PDF
- Modular structure with separate section files
- Skill matrix divided into:
  - Frameworks
  - Programming languages
  - Libraries
  - Tools
- Skill ratings from 1 to 5 using a minimalist visual scale
- Contact details with icon-style labels and clickable links
- Easy to customize placeholder content

## Project structure

```text
cv-web-developer/
├── README.md
├── cv.tex
├── cover-letter.tex
├── output/
│   └── .gitkeep
├── scripts/
│   ├── build.ps1
│   └── build.sh
├── sections/
│   ├── profile.tex
│   ├── skills.tex
│   ├── work-experience.tex
│   ├── projects.tex
│   ├── education.tex
│   └── languages.tex
└── styles/
    └── moderncvweb.sty
```

## Requirements

Install one of the following LaTeX distributions:

- **MiKTeX** (recommended on Windows)
- **TeX Live**

Useful packages used by the template include common modern LaTeX dependencies such as geometry, xcolor, hyperref, tikz, tabularx, enumitem, titlesec, and optionally fontawesome5.

> If fontawesome5 is not available, the template falls back to plain text markers so compilation still works.

The build scripts support latexmk, xelatex, and pdflatex, with xelatex being a great default for modern setups.

## How to compile

### Option 1: PowerShell on Windows

```powershell
./scripts/build.ps1
```

To build and clean intermediate files when using `latexmk`:

```powershell
./scripts/build.ps1 -Clean
```

### Option 2: Bash

```bash
bash ./scripts/build.sh
```

To clean intermediate files (keeps generated PDFs):

```bash
bash ./scripts/build.sh clean
```

To see available commands:

```bash
bash ./scripts/build.sh --help
```

### Option 3: Manual commands

If you prefer compiling manually:

```bash
pdflatex -output-directory=output cv.tex
pdflatex -output-directory=output cv.tex
pdflatex -output-directory=output cover-letter.tex
pdflatex -output-directory=output cover-letter.tex
```

Generated PDFs will be placed in the `output/` folder.

## Customization guide

Update the content in these files:

- Personal profile and contact data: `sections/profile.tex`
- Skills and ratings: `sections/skills.tex`
- Work history: `sections/work-experience.tex`
- Projects: `sections/projects.tex`
- Education: `sections/education.tex`
- Spoken languages: `sections/languages.tex`

## Notes about skills ordering

Each skill section is already arranged from highest rating to lowest rating, so the final PDF reflects the requested ranking clearly.

## Output

After a successful build, you should see:

- `output/cv.pdf`
- `output/cover-letter.pdf`

## Recommended editing workflow

1. Replace the placeholder identity in `sections/profile.tex`
2. Tailor the experience bullets to your real impact and metrics
3. Adjust skill ratings from 1 to 5
4. Rebuild the PDFs
5. Review spacing and wording, then export the final version
