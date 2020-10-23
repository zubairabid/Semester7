#lang racket
(require eopl)
(require rackunit)
(require racket/match)
(provide (all-defined-out))

(define *keywords*
  '(ifte function assume))

(define id?
  (lambda (x)
    (and
     (symbol? x)
     (not (memq x *keywords*)))))

;;; parse :: any/c -> ast?  Raises exception exn?
;;; Fill in the function parse here
(define (parse exp)
  (define bindparse             ;; helper function, parses assumes
    (lambda (expr)
      (if (empty? expr)
          '()
          (let (
                [var (first (first expr))]
                [ex (parse (second (first expr)))])
            (cons 
              (make-bind var ex) 
              (bindparse (rest expr)))))))
  (define astlistparse
    (lambda (listexp)
      (if (null? listexp)
          '()
          (cons (parse (first listexp)) (astlistparse (rest listexp))))))
  (cond [(number? exp) (num exp)]       ;; number parser
        [(boolean? exp) (bool exp)]     ;; boolean parser
        [(id? exp) (id-ref exp)]        ;; symbol parser
        [(and (list? exp)               ;; ifte parser
              (= (length exp) 4)
              (eq? (first exp) 'if))
         (ifte (parse (second exp))
               (parse (third exp))
               (parse (fourth exp)))]
        [(and (list? exp)
              (= (length exp) 3)
              (eq? (first exp) 'assume))
         (assume                        ;; generic assume parser
           (bindparse (second exp))
           (parse (third exp)))]
        [(and (list? exp)
              (= (length exp) 3)
              (eq? (first exp) 'function))
         (function
           (second exp)
           (parse (third exp)))]
        [(list? exp)
         (app
           (parse (first exp))
           (astlistparse (rest exp)))]) ;; add an else
  )


(define *init-env*
  (extended-env
   '(+ - * / < <= eq? 0? !)
   (list +p -p *p /p <p <=p eq?p 0?p !p)
   (empty-env)))


;;; implement all procedures in the list
(define +p
    (prim-proc + (list number? number? number?)))

(define -p
    (prim-proc - (list number? number? number?)))

(define *p
    (prim-proc * (list number? number? number?)))

(define /p
    (prim-proc / (list number? number? number?)))

(define <p
    (prim-proc < (list boolean? number? number?)))

(define <=p
    (prim-proc <= (list boolean? number? number?)))

(define eq?p
    (prim-proc eq? (list boolean? number? number?)))

(define 0?p
    (prim-proc zero? (list boolean? number?)))

(define !p
    (prim-proc not (list boolean? boolean?)))

(define eval-ast
  (lambda (a e)
    (define (envfrombind binds)
      (if (= (length binds) 1)
          (extended-env
            (list (bind-id (first binds)))
            (list (eval-ast (bind-ast (first binds)) e))
            e)
          (extended-env
            (list (bind-id (first binds)))
            (list (eval-ast (bind-ast (first binds)) e))
            (envfrombind (rest binds)))))
    (define (numred args)
      (if (null? args)
          '()
          (cons (eval-ast (first args) e) (numred (rest args)))))
    (cases ast a
           [num (n) n]
           [bool (b) b]
           [id-ref (sym) (lookup-env e sym)]
           [function (formals body) 
                     (closure
                       formals
                       body
                       e)]
           [app (func args) ;; When tasked with applying a function, we need
                ;; to check if rator is prim or closure. If it is a prim, we
                ;; need to execute that. rands is the list of arguments. If it
                ;; is 2 long, or 1 long, we act accordingly
                (let [(finfunc (eval-ast func e))]
                    (cases proc finfunc
                           [prim-proc (prim sig) 
                                      (if (= (length args) 1)
                                          (prim (eval-ast (first args) e))
                                          (prim 
                                            (eval-ast (first args) e)
                                            (eval-ast (second args) e)))]
                ;; The closures, on the other hand:
                ;; The closure has formals, body, env.
                ;; The arguments passed to the formals will become the new
                ;;   environment, appending the old one on top. This is then
                ;;   passed to the eval-ast again, with the body for execution
                           [closure (formals body env) 
                                    (let [(newenv 
                                            (extended-env
                                              formals
                                              (numred args)
                                              e))]
                                      (eval-ast body newenv))]))] ;; filler)
           [ifte (c th el)
                 (if (boolean? (eval-ast c e))
                     (eval-ast th e)
                     (eval-ast el e))]
           [assume (binds expr)
                   (eval-ast expr (envfrombind binds))]
           [else 5])))
