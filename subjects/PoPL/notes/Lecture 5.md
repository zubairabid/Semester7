---
title: PoPL Lecture 5
author: Zubair Abid
date: 2020-08-25
layout: page
---

# Summary

- ASTs are abstract representation of a program
- There is way to theoretically define the abstract syntax by looking at the
  concrete syntax
- Now, we are defining a language with *only addition*. So, we also show how to
  define this AST in racket (using `define-datatype`), and then write an
  `unparser` to go from AST to concrete syntax and then a `parser` to go from
  concrete syntax to AST

**Agenda**: Introducing ASTs by defining what they are, and how to show them in
racket. 

We will be defining our first (very trivial) language

# Abstract Syntax Trees

A few questions about program:

1. What is a program? How is it represented? `<-- will tackle this today`
2. What does it mean? How does it run?

## What is a program

Say you have a python program:

```python
def f(x):
    return x+2
```

- A sequence of characters 
- A sequence of tokens
  
### Looking at a more abstract representation: 

**Abstract Representation** of a program

: Trees

We start with a simple language: addition

Concrete syntax: `(+ 2 3)`, `2 + 3`

Abstract syntax:
```
        +
       / \
      2   3
```

```
 concrete syntax              AST
-------------------> PARSER --------> EVALUATOR
                                          |
                                          |
                                          V
                                        ANSWER

```

## From concrete to abstract

Say we have this concrete syntax: 

```
PREFIX:
<exp> ::= <num> |
        '(+_ '<exp>' _ '<exp>')'
```

Abstract syntax:

```
grammar of /|   <exp> ::= <num> |
    trees  \|             + <exp> <exp>
    
    
|---------------|
| _______ n є N |
| => n AST      |
|               |
| e1 AST e2 AST |
| ------------- |
| + e1 e2 AST   |
|---------------|

    2 + 3       AST
    2           AST
    2 +      x  AST
           _________
Judgement: | e AST |
           ---------
```

Rest of class: we will implement regularisation of ASTs, and write two
functions: `parse`, `unparse`

Derivation of `3+2` AST

1. 3 AST using num & 3 є N
2. 2 AST using num & 2 є N
3. 3 + 2 AST using PLUS with 1, 2

## Implementing ASTs in Racket

Other way to define

```
<ast> ::= <num> | + <ast> <ast>
          ---------------------
                   V
             Variant (sum) type
      base case | Inductive case
```

Yet another aside:

```scheme
;; Aside: Thing in racket: Type predicate

> (number? 5)
#t
> symbol?
> procedure? 
```

Implementing it in racket:

```scheme
> (define-datatype ast ast? ;; the second ast? is the type predicate
    [num (n number?)]
    [plus (left ast?) (right ast?)])
```

`num` and `plus` get autodefined as *constructor functions* with the following
signatures: 

- num ::= number? --> ast?
- plus ::= [ast?, ast?] --> ast?

Eg:

```scheme
> (num 5); --> an AST

;; ecample:                                plus
> (ast? (plus (num 5)              ;      /     \
              (num 6)))            ;     5       6
#t

; example of more complex????                     +
> (let ([e1 (plus (num 5) (num 6))]  ;           / \
        [e2 (plus (num 3) (num 3))]) ;          +   +
       (plus e1 e2))                 ;         / \ / \
                                     ;        5  6 2  3
```


Now something something looking at abstract to conrete syntax

Abstract syntax ---unparser--> concrete syntax
                <---parser----
                
                
## Unparser implementation in RACKET            

```scheme
;;; unparse : ast? ----> any/c
> (define (unparse a)
    (cases ast a
      [num (n) n]
      [plus (left right)
        (list '+
              (unparse left)
              (unparse right))]))
> (unparse (num 5))
5
> (unparse (plus (num 5) (num 4)))
'(+ 5 4)
```

## Parser implementation in RACKET            

```scheme
;;; parse : any/c ---> ast? || error

> (define (parse d)
    (cond [(number? d) (num d)]
          [(and (list? d)
                (= (length d) 3)
                (eq? (first d) '+))
           (plus (parse (second d))
                 (parse (second )))
           ???
           ???
           ???
           ???
           ??
           
```
