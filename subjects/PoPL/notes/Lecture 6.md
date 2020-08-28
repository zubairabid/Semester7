---
title: PoPL Lecture 6
author: Zubair Abid
date: 2020-08-25
layout: page
---

**Agenda**: Syntax (Co-inductive Terms)

- Last time, defined in terms of induction and expressions:
    - Defining sets naturally.
    - A set of all expressions in ADDITION
    - Example from last class
      ``` 

      ```
- Structural Induction: on trees, instead of n
- Now, we generalise
- Look at Inductive terms:
    - assume there is an alphabet $\sigma$ of constructor symbols
    - Eg: $\sigma = {f, g, h}$
    - Now, there are arity functions: $\alpha(f) = 2$ for example
        - Means you can write calls like this `f(a(), b())`, `f(f(a()), b())`
        - Defining *Inductive Terms*:
            - there is only 1 rule - suppose I have $t_1, ... t_n$ as terms, and
              $\alpha(f) = n$, then you get $f(t_1, ..., t_n)$ term
              
              ^ This is the **Constructor Rule**
              ![What is an inductive proof](./6_inductive.png)
            - Effectively:
                - If $t_1, ... t_n$ are terms
                - and $f \in \sigma$ s.t. $\alpha(f) = n$, then
                - $f(t_1, ..., t_n)$ is a Term
            - ^ The set of all inductive terms over $\sigma, T_{ind}(\sigma)$ is
              the *least* set that satisfies the above properties. 
              
              ![Example of an inductive proof](./6_demo_ind.png)
    - What is a set $X = \sigma(X)$. We need the least solution, as there
      are many. 
      
      $T_{ind}$ is the least solution.
      
      Saying that this is the least solution and giving the definition of it
      is identical.
    - Is it possible to have 'infinite' terms? 
      
      ```
      We have                  Can we have
                  +                          g
                 / \                        / 
                a   b                      g'    or  g<-\
                                          /          |__| 
                                         g''
                
      ```
    - Any proof is a finite structure
    - The set itself is infinite
    - But every element in the set if finitely constructed
    - $T_{ind} = \sigma(T_{ind}) \subset T_{ind}$
