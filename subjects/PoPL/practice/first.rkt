#lang racket

(define (extract str)
  (substring str 1 4))

(define (piece str)
  (substring str 0 pi))

(define (! n)
  (if (= n 0)
      1
      (* n (! (- n 1)))))

(define (reply-more s)
  (cond
   [(equal? "hello" (substring s 0 5))
    "hi!"]
   [(equal? "goodbye" (substring s 0 7))
    "bye!"]
   [(equal? "?" (substring s (- (string-length s) 1)))
    "I don't know"]
   [else "huh?"]))

(define (add numbers)
    (if (null? numbers)
        0
        (+ (car numbers) (add (cdr numbers)))))

;; function that takes a function and a param and operates the function 
;; twice on said parameter

(define (twice func var)
  (func (func var)))
