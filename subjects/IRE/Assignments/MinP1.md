---
title: Mini Project Phase I
author: Zubair Abid
layout: page
---



[Details](./Mini_Project_Phase1.pdf)

- [.] Given the wikidump file, how the thing will be indexed:
    - [X] Parse the XML: 
          
          Take out the content from XML, then move on.
          
    - [ ] Preprocessing:
        - [ ] Tokenise: 
              
              Take a word, strip wikipedia formatting.
        - [ ] Case fold it
        - [ ] Remove stop words
        - [ ] Stem and lemmatize
    - [ ] Create the inverted index
    - [ ] Compress the dictionary and the index

# Challenges

1. Need to include fields as well

Take all the text out, then split 

## Getting bits

Export the text into a raw txt.

While going line by line, extract

### Title

The `data` in a `<title>` context

### Body

### Categories

Are all on separate lines in the form `[[Category:<category>]]`

### Infobox

If line starts with `{{Infobox (}})` then enable the context, set the count at 2.

For each line, count `count({) - count(})`

If it gets to zero, disable the context

#### Within infobox

Check for citations.

### References

Inside `<ref>`, there is either a `{{[Cc]itei}}` or not. If no `cite`, pick the
value inside. Else, in between the '|', take what's after the '='

Also, `{{[Cc]ite}}` on its own

### Links

Anything under ==External Links==

[Submission portal](https://moodle.iiit.ac.in/mod/assign/view.php?id=24962)
