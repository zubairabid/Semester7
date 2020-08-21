#lang racket

(define (flatten-list dlst)
  (cond
    [(null? dlst) '()]
    [(not (list? dlst)) (list dlst)]
    [else (append (flatten-list (car dlst)) (flatten-list (cdr dlst)))]))

(define (letter-grade slist)
  (define (calc student)
    (let ([average (/ (apply + (car (cdr student))) (length (car (cdr student))))])
      (cond
        [(> average 89) (cons (car student) (cons "A" '()))]
        [(> average 70) (cons (car student) (cons "B" '()))]
        [else (cons (car student) (cons "C" '()))])))
  (if (null? slist)
      '();what
      (append (calc (car slist)) (letter-grade (cdr slist)))))

; function to take a number n and generate array [n --> 1]
(define (tailrec_append n)
  (if (= n 1)
      (cons 1 '())
      (cons n (tailrec_append (- n 1)))))
