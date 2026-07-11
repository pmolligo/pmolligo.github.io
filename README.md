# Patrick Molligo Website

Personal academic website built with **Quarto** and hosted on **GitHub Pages**.

Website:
https://www.patrickmolligo.com

---

## Preview locally

Open a terminal in the project directory.

```bash
quarto preview
```

Stop the preview with

```text
Ctrl + C
```

---

## Publish

Simply push to GitHub.

```bash
git add .
git commit -m "Describe changes"
git push
```

GitHub Actions automatically builds and deploys the website.

---

## Project structure

```
research/
    index.qmd
    papers/

teaching/
    index.qmd
    courses/

blog/
    posts/

files/
    molligo-cv.pdf
    papers/

images/

templates/
```

---

## Adding a new paper

1. Copy

```
templates/paper-template.qmd
```

into

```
research/papers/
```

2. Rename the file.

3. Update

- title
- status
- description
- abstract
- PDF link

4. Copy the PDF into

```
files/papers/
```

5. Render

```bash
quarto preview
```

The paper automatically appears on the Research page.

---

## Adding a new course

Copy

```
templates/course-template.qmd
```

into

```
teaching/courses/
```

Update the metadata and add links to slides, syllabus, and materials.

---

## Adding a blog post

Copy

```
templates/post-template.qmd
```

into

```
blog/posts/
```

Update the title, date, categories, and content.

The post automatically appears on the Blog page.

---

## Important files

| File | Purpose |
|------|---------|
| `_quarto.yml` | Site configuration |
| `styles.css` | Site styling |
| `script.js` | Small JavaScript tweaks |
| `README.md` | Project documentation |

---

## Future improvements

- Better publication metadata
- Presentation page
- Software & Data page
- Google Scholar integration
- ORCID
- Search
