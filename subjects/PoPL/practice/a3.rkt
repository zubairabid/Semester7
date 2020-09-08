#lang racket
(require eopl)
(require rackunit)
(require racket/match)
(provide (all-defined-out))

;;; parse :: any/c -> ast?  Raises exception exn:parse-error?
;;; Fill in the function parse here
(define (parse exp)
  (cond [(number? exp) (num exp)]
        [(boolean? exp) (bool exp)]
        [(and (list? exp)
              (= (length exp) 4)
              (eq? (first exp) 'if))
         (ifte (parse (second exp))
               (parse (third exp))
               (parse (fourth exp)))]
        [(and (list? exp)
              (= (length exp) 3))
         (match (first exp)
                ['+ (binop 'add (parse (second exp)) (parse (third exp)))]
                ['- (binop 'sub (parse (second exp)) (parse (third exp)))]
                ['* (binop 'mul (parse (second exp)) (parse (third exp)))]
                ['/ (binop 'div (parse (second exp)) (parse (third exp)))]
                ['< (binop 'lt? (parse (second exp)) (parse (third exp)))]
                ['= (binop 'eq? (parse (second exp)) (parse (third exp)))]
                [_ (raise-parse-error "Parse error")])]
        [else (raise-parse-error "Parse error")]) ;; add an else
  )

;;; eval-ast :: ast? -> expressible? || (or/c exn:exec-div-by-zero  exn:exec-type-mismatch)
(define eval-ast
  (lambda (a)
    (cases ast a
           [num (n) n]
           [binop (op rand1 rand2) 
                  (if (eq? op 'div)
                      (
                       (op-interpretation op)
                       (typecheck-num (eval-ast rand1))
                       (check-non-zero (typecheck-num (eval-ast rand2))))
                      (
                       (op-interpretation op)
                       (typecheck-num (eval-ast rand1))
                       (typecheck-num (eval-ast rand2))))]
           [ifte (c t e)
                 (if (typecheck-bool (eval-ast c))
                     (eval-ast t)
                     (eval-ast e))]
           [bool (b) b])
    ))
