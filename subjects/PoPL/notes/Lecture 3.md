---
title: PoPL Lecture 3: Lexical Scoping and Higher order functions
author: Zubair Abid
date: 2020-08-18
layout: page
---

# Lexical Scope

When an identifier is referred to, it will look for a definition within a local
scope. So, in a program like:

```scheme
(define demo_scope
  (lambda () 
    (let ([y 5])
      (let ([y 9][z (sub1 y)])
        (+ y z)))))
```

The first `y` is a definition, where it is defined as 5. The next line contains
a `let` with two assignments, one redefining `y` and the other using it. The
second instance of `y` is referring to the first definition still, aka `y=5`
when it is used to set `z` to `(sub1 y)`.

# Recursion

In racket, recursion is encouraged. Basic iteration tasks are simplified as 
recursion, and there is no `while` construct at all.

```scheme
(define occurs-in?
  (lambda (x ls)
    (if (null? ls)
        #f
        (if (= x (car ls))
            #t
            (occurs-in? x (cdr ls))))))
```

Output: 
```scheme
"3.rkt"> occurs-in?
#<procedure:occurs-in?>
"3.rkt"> (occurs-in? 5 '(1 2 3 4))
#f
"3.rkt"> (occurs-in? 5 '(1 2 3 4 5))
#t
```

**Note to self:** Revise the section from 19:41 in order to understand the finer
details of recursion and something else that I have not initially caught.

So what I get from that is:

Recursion
: There is some surrounding context around the recursive call. For
  example, `(+ 1 (a (sub1 p)))`, where the `a` is the function, and the
  recursive callback has the `+ 1` around it.

Iteration 
: Not that.

# Higher order functions

Functions are also passed and returned, not just values (primitives).

## What are first order functions?

When the arguments, or the returns, are primitives. 

Example:
```scheme
(define add2
          (lambda (x)
            (+ x 2)))

(define mul-by-3
          (lambda (x)
            (* 3 x)))

(define composeaddmul
          (lambda (f g)
            (lambda (x) ;; function being returned by the function composeaddmul
              (g (f x)))))
```

Output 

```scheme
"3.rkt"> (add2 5)
7
"3.rkt"> (mul-by-3 (add2 5))
21
"3.rkt"> (composeaddmul add2 mul-by-3)
#<procedure:...PoPL/notes/3.rkt:27:12>
"3.rkt"> ((composeaddmul add2 mul-by-3) 5)
21
```

As we see:

1. The function `composeaddmul` takes two functions `f` and `g`, and returns a
   function (through defining a lambda function) that will take a single
   variable `x` and compose the two, applying `f` first and then `g` to `x`.
2. That's it, idk why I have a part 2.
