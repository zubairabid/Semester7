---
title: PoPL Lecture 11
author: Zubair Abid
date: 2020-09-18
layout: page
---

- Abstract Reduction Systems
- Basically a set and a relation
- Relation composition 
  
  ![image](./11_relcomp.png)
- Derived Abstract Reduction systems
- Essential idea is the simplification of programs like in high school algebra.
- Normal form: not reducible
- `y` is normal form of `x` if `x → .. → y`
- `y` is simplified of `x` if `x → .. → y`
- `y` is direct successor of `x` if `x → y`
- `y` is successor of `x` if `x → .. → y`
- `x` and `y` are *joinable* if `x → .. → z` and `y → .. → z`
- Properties of abstraction systems:
    - *Church Rosser*: ∀ a, b, if a <-> b, a and b joinable 
      
      Example of not: ![image](./11_arsnocr.png)
    - If system has *Church rosser* property, then LHS <-> RHS is possible.
      Simplification possible
