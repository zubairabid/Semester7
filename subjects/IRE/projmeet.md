---
title: Information Retrieval and Extraction: Major Project meeting notes
author: Zubair Abid
layout: page
---

## 2020-10-09

Meeting with: Abhigyan, Zubair

Basics of what we need:

- preprocessing line:
    - (OUTPUT FORMAT I1)
    - Looking at the eval data and figuring how to preprocess that.
- Setup the QA generation tool:
    - Look at how it inputs data (INPUT FORMAT I1)
    - For that reason this needs to be done first
- Text-summariser:
    - INPUT FORMAT I1: Converter from I1 to whatever the summariser needs
    - OUTPUT FORMAT I1
- BERT-Extractive summariser:
    - INPUT FORMAT I1: Converter from I1 to whatever the summariser needs
    - OUTPUT FORMAT I1

Own summariser:

- Collect Data:
    - NCERT:
        - Informative: Bio texts
        - Narrative: English Literature
- SVM
- Decision Trees
- Spacy

Splitting the tasks in order:

- QA tool
- preprocessing
- two summarizers
- data collection
