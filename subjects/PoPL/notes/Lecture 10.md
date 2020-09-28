---
title: PoPL Lecture 10
author: Zubair Abid
date: 2020-09-11
layout: page
---

- Till now, we studied syntax
- Now, semantics or dynamics/evaluations of expressions
- Again, defining syntax formally in terms of trees

Overview of what we will cover:

- Addition language
- Syntax and interactive semantics

Syntax:

- Consider the syntax for the addition language 
  
  ![image](./10_addsynt.png) ![image2](./10_addindsynt.png)
- Hereon, "term" = inductive term unless otherwise specified
- How to evaluate: say `2() + (3() + 4()) → 2() + 7() → 9()`
- Defining a transition system: 
  
  ![image](./10_transdef.png)
- Defining something? TODO 
  
  ![image](./10_defsofsomething.png)
  
  Along those lines, *what is a Run* 
  
  ![image](./10_runs.png)
- Term graph as a system 
  
  ![image](./10_tgsys.png) 
  
  Useful for lots of things, including data structures, can look at *what* as  
  transitions and navigate around.
- TODO Subterms, replacements
- Addition and rewrite rules 
  
  ![image](./10_addrewr.png)
- TODO this well. Addition as a system
