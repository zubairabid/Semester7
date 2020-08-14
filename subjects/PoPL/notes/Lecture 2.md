---
title: PoPL Lecture 2
author: Zubair Abid
date: 2020-08-14
layout: page
---

**Agenda**: Tutorial on `org-mode`

A demonstration of emacs.

# What is emacs?

- It's a text editor
- Emacs is said to be versatile. It has programming environments called 
  modes. There are also modes for other things like directory browsing or 
  web browsing.
- It has UIs:
    - Mouse based
    - Keystroke based
    - Command based
    - Programming Interface

# Key Principles of Emacs

- **Buffers**: Can be used for editing files, etc, think vim buffers.
  
- **Modes**: There is always a mode for every buffer. A buffer can have 
  multiple modes.
  
- You can associate buffers with files
- There's a shell in emacs
- You can cut-past across buffers

# Org-mode

## Key idea: structured note taking

- There is markup
- There is 

## Examples of literate programming

You can write source code

```org-mode
#+BEGIN_SRC scheme :tangle hw1-soln.rkt
#lang racket
(define x 5)
(define y 10)
#+END_SRC
```

