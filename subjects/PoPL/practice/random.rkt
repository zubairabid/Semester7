#lang racket

(define test
  "How does this go")

(define isEven?
  (lambda (num)
    (cond
      [(= num 0) #t]
      [(= num 1) #f]
      [else (isOdd? (- num 1))])))

(define isOdd?
  (lambda (num)
    (cond
      [(= num 0) #f]
      [(= num 1) #t]
      [else (isEven? (- num 1))])))

