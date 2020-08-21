---
title: PoPL Lecture 4
author: Zubair Abid
date: 2020-08-21
layout: page
---

- Contents
{:toc}

[Link to racket file](./4.rkt)

- the program itself is a data structure
- We will describe the structure with a grammar (CFG)

We will start with the concept of a "datum" (also called an S-expression):

# Datum

- Use it to describe the heirarchical structure of lists and list expressions.
- Examples of datums: `(x y)` `45` `(x . 5)` `((5 3) 7)`

```
<datum> ::= <list-exp> | <non-list-exp>
```

## Non-list expression

```
<non-list-exp> ::= <atom> | <vector>
```

### Atoms

```
<atom> ::= <boolean> | <number> | <character> | <symbol> | <string> | <procedure>
```

In racket, each atomic type comes with a predicate.

```scheme
> (integer? 5)
#t
> (number? 2+3i)
#t
> (rational? 3/2)
#t
> #b100
4
> (boolean? #f)
#t
```

Some sort of an aside on characters and symbols.

- Characters can be `display`ed as unicode fonts.
- Characters integer value can be displayed.
- Symbols can have spaces if wrapped with vertical bars.
- Strings can be converted to list of characters

```scheme
> (display #\u0905)
अ
> (char->integer #\A)
65
> '|A B C|
'|A B C|
> (symbol? '|A B C|)
#t
> (string->list "Hello")
'(#\H #\e #\l #\l #\o)
```

### Vectors

```
<vector> ::= #(<datum> ...)
```

`<thing> ...` represents `*`, 0 or more of `<thing>`

```scheme
> #(3 4)
'#(3 4)
> #()
'#()
```


## List expressions

```
<list-expression> ::= (<datum> ...) | (<datum> <datum> ... . <datum>)
```

`<thing> . <thing>` represents a `pair`.

A list-expression can have:

- 0 or more `<datum>`
- 1 or more `<datum>` . exactly one `<datum>`

### Types of list expressions:

- Pairs:
    - Nested pairs

### List expression conversion rules

#### Nest elimination / Nest introduction

`(<d1> <d2> ... . (<d3> . <d4>)) => (<d1> <d2> ... <d3> . <d4>)`

```scheme
> '(3 . (2 . 1))
'(3 2 . 1)
> '((3 . 4) . (2 . 1))
'((3 . 4) 2 . 1)
> '((3 . (4 . 5)) . (2 . 1))
'((3 4 . 5) 2 . 1)
> (cdr '(3 4 . (5 . 6)))
'(4 5 . 6)
```

#### Empty elimination / Empty introduction

`(<d1> <d2> ... . ()) => (<d1> <d2> ...)`

```scheme
> '(3 4 . ())
'(3 4)
> '(3 . (2 . (1 . ())))
'(3 2 1)
> '((3 . (4 . ())) . (2 . 1))
'((3 4) 2 . 1)
```

#### Systematic application of these rules

```scheme
'(3 . (2 . (1 . ()))) --nest-->
'(3 2 . (1 . ())) --nest-->
'(3 2 1 . ()) --empty-->
'(3 2 1)
```

The place matching the LHS of a transformation rule is called a `REDEX`

```scheme
'(3 . ((2 . ()) . 4)) --empty-->
'(3 . ((2) . 4)) --nest-->
'(3 (2) . 4)
```

#### Redexes

`REDEX`

: A subexpression that matches the LHS of a rewrite rule

### Lists

Lists are a subcategory of List expressions

```
<list> ::= (<datum> ...) | (<datum> <datum> ... . <non-list-exp>)
```

| Examples            | Non-examples   |
|---------------------|----------------|
| `(3 4 5)`           | `(3 . (4 . 5)` |
| `((3 . 4) (5 . 6))` | `(3 . ())`     |
| `(3 4 5 . 6)`       |                |

A list is either proper or improper

Proper List

: `(<datum> ...)`

Improper List

: `(<datum> <datum> ... . <non-list-exp>)`

`list?` tests if the argument is a proper list
