---
title: Mini Project Phase II
author: Zubair Abid
layout: page
---

[Details](./Mini_Project_Phase2_doc.pdf)

1. Download [these urls]. Don't need all of them
2. Unzip the files.
3. Index each part.
4. Merge the indexes.
5. When searching, enable ranking as well.

# Technical work

1. Index creation:
    1. Adding index features for ranking ✓
    2. Indexing multiple files.          ✓
    3. Merging the multiple indexes.     ✓
2. Searching:
    1. based on the search term, load the index subfile             ✓
    2. Get the postings list                                        ✓
    3. Sort the postings list using tf-idf                          ✓
    4. Do this for each term. Merge, ranking by max intersection    ✓

```
Indexer:
- parses an article
- add title and docid to a dictionary
- for each set of words:
  - de-accent
  - delete non-english chars
  - passthrough pipeline

Merger:
- For getting correct docids  
  - Load article counts for 1-34 from titledicts
  - Load ind1...ind34 line by line
  - Load all 34 docid-title dictionaries
  - For each of 2..34 update article count, and docid-title dictionary
- Merge op. For all of 1..34, pick min
  - If outside range, save previous to pickle and start new
  - Save to dict. If dict exists, merge these 2
  
Search:
- split words. preprocess.
    - Based on prefix, load index file.
    - Fetch all articles with the criteria for said word
    - Calculate tf-idf scores for all and sort
- Merge the lists based on presence across the board
```

```
def merge:
  fps = [list]
  offsets «- from 0 to 34
  heap «- first line from each fp
  while True:
    smallest val = pop(heap)
    update smallestval article indexes with offsets.
    get next line from this into heap. if not, close.
    check prefix: new/old
      save previous dict in pickle, start new dict
      check if in dict: merge, else new
```

[these urls]: https://drive.google.com/file/d/1NA7yo6p-nbi3LjNJZSXBVMBtuMmn994p/view


