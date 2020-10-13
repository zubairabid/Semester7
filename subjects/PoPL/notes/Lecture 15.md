---
title: PoPL Lecture 15
author: Zubair Abid
date: 2020-10-02
layout: page
---

- ![evaluation of an ast with let](./14_astenv.png) 
  
  Over here, think of the expression `e` with `n+1` parts. `e₁ ... ` are the 
  "let" expression expressions. Given the bigger environment $\Gamma$, each of 
  `e₁ ...` evaluates to `v₁ ...`, and then we compose each of those on top of 
  the $\Gamma$ to get the fresh environment.$
