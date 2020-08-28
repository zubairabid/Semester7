#lang racket

(define res '((dan S1) (sam S2) (bob S3) (jim S4)))

(define neigh '((S1 S2) (S2 S3) (S2 S4) (S3 S4)))

(define neighbor?
  (lambda (person1 person2 res_list nei_list) 
    (define get-house ;; get the residence from the person and list
      (lambda (person res_list)
        (cond
          [(null? res_list) 0]
          [(equal? person (car (car res_list))) (cdr (car res_list))]
          [else (get-house person (car res_list))])))
    (define nextdoor? ;; actually checks
      (lambda (res1 res2 nei_list)
        (cond 
          [(null? nei_list) #f]
          [(or 
             (equal? (cons res1 (cons res2 '())) (car nei_list))
             (equal? (cons res2 (cons res1 '())) (car nei_list))) #t]
          [else (nextdoor? res1 res2 (cdr nei_list))])))
    (let ([res1 (get-house person1 res_list)])
      (let ([res2 (get-house person2 res_list)])
        (if (nextdoor? res1 res2 nei_list)
            #t
            #f)))))


(define income-tax
  (lambda (rate)
    (lambda (income)
      (* rate income))))
