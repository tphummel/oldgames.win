---
title: Convert CSV Rows to Markdown files
date: 2022-04-09T09:40:00.000-08:00
toc: false
---

# Intro

This is a one time script to generate an md file for each row in my source csv file.

## Goals:

- add the puzzle date in the title
- move `puzzle` param field to `puzzles` taxonomy
- move the file from `/content/w/168.md` to `/content/w/2021-12-04.md`
- add `aliases` param with the original path to redirect to the new one. `/w/168`

## Pseudocode:

- start
  - read input file
  - split lines
  - for each line
    - split on comma
    - build js object keyed on headers

- end

# Usage

```
# run a single file
zx content/m/001-move-puzzle-to-date.md $(pwd)/content/w/251.md

# test a single file
find content/w -name "*.md" | grep -v "_index" | head -n1 | xargs -I {} sh -c "zx content/m/001-move-puzzle-to-date.md {}"

# test all files
find content/w -name "*.md" | grep -v "_index" | xargs -I {} sh -c "zx content/m/001-move-puzzle-to-date.md {}"
```

- The process will exit 0 on success
- The process will exit 1 on failure with failure info written to stdout

# Code

```js

// https://gist.github.com/mathewbyrne/1280286
function slugify(text) {
  return text.toString().toLowerCase()
    .replace(/\s+/g, '-')           // Replace spaces with -
    .replace(/[^\w\-]+/g, '')       // Remove all non-word chars
    .replace(/\-\-+/g, '-')         // Replace multiple - with single -
    .replace(/^-+/, '')             // Trim - from start of text
    .replace(/-+$/, '')             // Trim - from end of text
}

const inputFile = './all-metacritic-export.csv'

// https://stackoverflow.com/questions/28543821/convert-csv-lines-into-javascript-objects
const inputContent = await fs.readFile(inputFile, 'utf-8')
const lines = inputContent.split('\n')
const headers = lines[0].split(',')

for(var i = 1; i < lines.length; i++) {
  var data = lines[i].split(',')
  var obj = {}
  for(var j = 0; j <= 5; j++) {
    obj[headers[j].trim()] = data[j].trim()
  }

  const slug = `${obj.platform}-${slugify(obj.Title)}`
  const publishDate = new Date().toISOString()
  const outputFile = `content/g/${slug}.md`
  const outputContent = `
---
title: "${obj.Title}"
date: "${publishDate}"
releaseDate: "${obj.releaseDate}"
platforms: ["${obj.platform}"]
score: ${obj.score}
metacriticLink: "${obj.link}"
---
`
  // console.log(outputContent)
  await fs.writeFile(outputFile, outputContent)
}
// await $`rm ${inputFile}`


```
