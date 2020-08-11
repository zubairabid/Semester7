---
title: PoPL Lecture 1
author: Zubair Abid
date: 2020-08-11
layout: page
---

### Checking the course pages

[Link to course pages]

- Might switch to Zoom at some point
- Mrityunjay is the official TA, Ojas is unofficial
- Office hours: Monday 4-4:30 PM
- Encouraged to post questions on the discussion groups
- Last day of lectures: 17th November
- Final project due: 23rd November
- **Get Book:** Essentials of Programming Languages. Other books too:
    - How to Design Programs
    - Structure and Interpretation of Programs
- Homework assignments will be given (reading)

### Class structure and Evaluation

- Most lectures will be prerecorded: 1.5-2 hours
- Tuesday 4-5:30 : live class, *only if announced*
- Quizzes: 2 a week, 5-5:10 Tuesday, 5-5:20 Friday
- Friday: live discussion, we come with questions
- Grading scheme announced
- Most assignments will be programming
- Standard plagiarism rules
- Announce collaborators if collaborated

### More on Evals

- Assignments:
    - Reading
    - Programming (Racket, Elm)
- Project:
    - Programming

### Course objectives

(read from the [objectives page])

- asked to take the compilers course for another perspective
- Specifications of programming languages:
    - denotational
    - operational
    - axiomatic

### Misc

- Need to fill out a form for gitlab access
- Not entirely sure how the quiz will be taken

### Languages as human meta-technology

- Some relation between natural and human languages
- Both natural and programmng languages need communities, to communicate.
- Difference from other techs: evolution is much slower than other tech 
  evolution rate.
- Programming languages survive hardware changes as well

#### Evolution of programming languages

- **Block Structure and scoping**: 
  
  Also includes free and bound statements, etc.
- **Object Orientation**:  
  
  Lot of impetus has gone into this paradigm of programming.
      - Simula (1969)
      - Smalltalk (1972)
      - CLisp (1984)
      - ...
- **Logic Programming**
- **Functional Programming**:
    - Lisp (1950s)
    - Scheme (1977)
- **Static Typing**:
    - ?ML
    - Haskell (1990)

Other paradigms:

- **Web Interaction**: JS, Elm (assignments will be in this)
- **Concurrency**: Java
- **Events and Education**: Scratch
- **Aspects, Actors**

Future:

- **Security**: will need verification, proofs, etc
- **Quantum computing**: Comes with its own models of computing
- **Data Science**: Abstractions of statistical concepts built in
- **Biological Networks**: Processing of large networks with feedback 
  and control
- **Natural Languages**: For literate programming, specifically

### Questions addressed in POPL

1. What is a program
2. What is a programming language
3. What is an abstract machine
4. ??

#### Approach taken

- Express programs as trees (abstract syntax trees)
- Define small languages: 
  
  Start with a small one that just does arithmetic and then keep building
  on top of that.
- Build interpreters: 
  
  As part of the assignments. They will act like abstract machines.
- Implement the features in the interpreters: 
  
  To add new operations and syntax features, modify the interpreters
- Formal study of semantics done alongside. Will be using something 
  called transition systems
  
### Basics of Functional Programming 

#### What is functional programming

- It is a way of **writing programs. By writing functions**. Only functions.
- You're encouraged to think of the **programs as algebraic expressions**. 
  Think of programs as formulas, and be able to simplify the program
  like you would an expression. Essentially, **Equational Reasoning**
- **They have higher order functions**: functions that take or return other 
  functions
- Very heavy use of **Recursion** is used, even for iterations. Exploit 
  data structures.
  
#### Why functional Programming

- **FP notation is very convenient for expressing programs**, much like in 
  math notation lets you express things well. Shorter programs. It's very
  good? for examining non-functional programs.
- **Programs are shorter**
- **Higher order mathematical ideas as leveraged**: higher order functions, 
  composition, algebraic data types, etc
- **Controlled expression of effects**: no side-effects
- **Type safety**: is well covered by some of these languages.

### A very short tour of racket

Website: [racketlang]. Also the *reading assignment* for this week.

Function for max:

```racket
(define (max x y)
    (if (> x y) ;; test
        x       ;; then
        y     ;; else
    )
}
```

Factorial: 

```racket
(define (! n)
    (if (= n 0)
        1
        (* n (! (- n 1)))
    )    
)
```

Another Factorial:

```racket
(define (!/acc n)
    (!-helper n 1)
)

(define (!-helper i a)
    (if (= i 0)
        a
        (!-helper (- i 1) (* a i))
    )
)
```


[racketlang]: https://docs.racket-lang.org/guide/index.html
[Link to course pages]: https://faculty.iiit.ac.in/~venkatesh.choppella/popl/
[objectives page]: https://faculty.iiit.ac.in/~venkatesh.choppella/popl/objective.html
