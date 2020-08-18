#lang racket

(define demo_scope
  (lambda () 
    (let ([y 5])
      (let ([y 9][z (sub1 y)])
        (+ y z)))))

(define occurs-in?
  (lambda (x ls)
    (if (null? ls)
        #f
        (if (= x (car ls))
            #t
            (occurs-in? x (cdr ls))))))

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
