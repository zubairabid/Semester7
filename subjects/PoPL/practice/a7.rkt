#lang racket
(require eopl)
(require rackunit)
(require racket/match)
(provide (all-defined-out))

;; BEGIN FBIND
(define-datatype fbind fbind?
  [make-fbind (fb-id id?)
              (fb-formals (list-of id?))
              (fb-body ast?)])

;;; fbind-id : fbind? -> id?
(define fbind-id
  (lambda (b)
    (cases fbind b
      [make-fbind (fb-id fb-formals fb-body) fb-id])))

;;; fbind-formals : fbind? -> (list-of id?)
(define fbind-formals
  (lambda (b)
    (cases fbind b
      [make-fbind (fb-id fb-formals fb-body) fb-formals])))

;;; fbind-body : fbind? -> ast?
(define fbind-body
  (lambda (b)
    (cases fbind b
      [make-fbind (fb-id fb-formals fb-body) fb-body])))
;; END FBIND

;; BEGIN AST
(define-datatype ast ast?
  [num (datum number?)]
  [bool (datum boolean?)]
  [ifte (test ast?) (then ast?) (else-ast ast?)]
  [function
   (formals (list-of id?))
   (body ast?)]
  [recursive (fbinds (list-of fbind?)) (body ast?)]
  [app (rator ast?) (rands (list-of ast?))]
  [id-ref (sym id?)]
  [assume (binds  (list-of bind?)) (body ast?)])

(define-datatype bind bind?
  [make-bind (b-id id?) (b-ast ast?)])

;;; bind-id : bind? -> id?
(define bind-id
  (lambda (b)
    (cases bind b
      [make-bind (b-id b-ast) b-id])))

;;; bind-ast : bind? -> ast?
(define bind-ast
  (lambda (b)
    (cases bind b
      [make-bind (b-id b-ast) b-ast])))
;; END AST

;; BEGIN PARSER
(define *keywords*
  '(ifte assume function recursive))

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
  (define reclistparse 
    (lambda (listexp)
      (if (null? listexp)
          '()
          (cons
            (make-fbind
              (first (first listexp))
              (second (first listexp))
              (parse (third (first listexp))))
            (reclistparse (rest listexp))))))  ;; cons on reclist the rest
  (cond [(number? exp) (num exp)]       ;; number parser
        [(boolean? exp) (bool exp)]     ;; boolean parser
        [(id? exp) (id-ref exp)]        ;; symbol parser
        [(and (list? exp)               ;; ifte parser
              (= (length exp) 4)
              (eq? (first exp) 'ifte))
         (ifte (parse (second exp))
               (parse (third exp))
               (parse (fourth exp)))]
        [(and (list? exp)
              (= (length exp) 3)
              (eq? (first exp) 'assume))
         (assume                        ;; generic assume parser
           (bindparse (second exp))
           (parse (third exp)))]
        [(and (list? exp)               ;; function parser
              (= (length exp) 3)
              (eq? (first exp) 'function))
         (function
           (second exp)
           (parse (third exp)))]
        ;; For recursive parsing, it's a three-part list that contains:
        ;;   1. 'recursive
        ;;   2. A list of ((essentially functions)) - expressions with 
        ;;      <symbol>* as params, referred to by the first <symbol>.
        ;;      Each of these becomes one `fbind`
        ;;      > this needs a function to parse over the list option
        ;;   3. An expression. This will be evaluated later.
        [(and (list? exp)               ;; recursive parser
              (= (length exp) 3)
              (eq? (first exp) 'recursive))
         (recursive
           (reclistparse (second exp))  ;; The second needs to be listed
           (parse (third exp)))]        ;; The third is just parsed normally
        [(list? exp)                    ;; application parser
         (app
           (parse (first exp))
           (astlistparse (rest exp)))]) ;; add an else
  )

;; BEGIN ENV
(define-datatype env env?
  [empty-env]
  [extended-env
    (syms (list-of symbol?))
    (vals (list-of denotable-value?))
    (outer-env env?)]
  [extended-rec-env
    (fsyms (list-of symbol?))
    (lformals (list-of (list-of symbol?)))
    (bodies (list-of ast?))
    (outer-env env?)])
;; END ENV

;; BEGIN ENV PREDICATES
;;; empty-env? : env? -> boolean?
(define empty-env?
  (lambda (e)
    (cases env e
      [empty-env () #t]
      [else #f])))

;;; extended-env? : env? -> boolean?
(define extended-env?
  (lambda (e)
    (cases env e
      [extended-env (syms vals outer-env) #t]
      [else #f])))

;;; extended-rec-env? : env? -> boolean?
(define extended-rec-env?
  (lambda (e)
    (cases env e
      [extended-rec-env (fsyms lformals bodies outer-env) #t]
      [else #f])))
;; END ENV PREDICATES

;; BEGIN LOOKUP ENV
(define lookup-env
  (lambda (e x) 
    (define (getv syms vals)
      (if (empty? syms)
          #f
          (if (eq? (first syms) x)
              (first vals)
              (getv (rest syms) (rest vals)))))
    (define (extgetv fsyms lformals bodies outer-env current-env)
      (if (empty? fsyms)
          #f
          (if (eq? (first fsyms) x)
              (closure
                (first lformals)
                (first bodies)
                current-env)
              (extgetv
                (rest fsyms) 
                (rest lformals) 
                (rest bodies) 
                outer-env
                current-env))))
    (cases env e
           [extended-env 
             (syms vals outer-env)
             (let ([result (getv syms vals)])
               (if (boolean? result)    ;; aka, if nothing found.
                   (lookup-env outer-env x) ;; we then move on to outer-env
                   result))]
           ;; The extended-rec-env only happens with functions - closures. 
           ;; So we need to take the fsyms[i], lformals[i], bodies[i], and 
           ;; outer-env, and create a closure with:
           ;;   1. lformals[i] as the formal
           ;;   2. bodies[i] as the function body reference
           ;;   3. current-env as the external environment.
           ;; In summary, it's returning a closure. Else it's returning from
           ;; its environment.
           [extended-rec-env
             (fsyms lformals bodies outer-env)
             (let (                 ;; First, we reconstruct the current env
                   [current-env
                     (extended-rec-env
                       fsyms
                       lformals
                       bodies
                       outer-env)])
               (let ([result (extgetv 
                               fsyms lformals bodies outer-env current-env)])
                 (if (boolean? result)
                     (lookup-env outer-env x)
                     result))
               )]
           [else 0]))) ;; TODO add something
;; END LOOKUP ENV

;; BEGIN SEMANTIC PROCEDURE
(define-datatype proc proc?
  [prim-proc
    ;; prim refers to a scheme procedure
    (prim procedure?)
    ;; sig is the signature
    (sig (list-of procedure?))] 
  [closure
    (formals (list-of symbol?))
    (body ast?)
    (env env?)])

;;; prim? : proc? -> boolean?
(define prim-proc?
  (lambda (p)
    (cases proc p
      [prim-proc (prim sig) #t]
      [else #f])))

(define closure? 
  (lambda (p)
    (cases proc p
      [prim-proc (prim sig) #f]
      [else #t])))
;; END PROCEDURE

;; BEGIN INIT ENV
(define *init-env*
  (extended-env
   '(+ - * / < <= eq? 0? !)
   (list +p -p *p /p <p <=p eq?p 0?p !p)
   (empty-env)))
;; END INIT ENV

;; BEGIN PROCEDURES
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
;; END PROCEDURES

;; BEGIN STUFF
;;; expressible-value? : any/c -> boolean?
(define expressible-value?
  (or/c number? boolean? proc?))

;;; denotable-value? :any/c -> boolean?
(define denotable-value?
  (or/c number? boolean? proc?))
;; END STUFF



;; (define eval-ast
;;   (lambda (a e)
;;     (define (envfrombind binds)
;;       (if (= (length binds) 1)
;;           (extended-env
;;             (list (bind-id (first binds)))
;;             (list (eval-ast (bind-ast (first binds)) e))
;;             e)
;;           (extended-env
;;             (list (bind-id (first binds)))
;;             (list (eval-ast (bind-ast (first binds)) e))
;;             (envfrombind (rest binds)))))
;;     (define (numred args)
;;       (if (null? args)
;;           '()
;;           (cons (eval-ast (first args) e) (numred (rest args)))))
;;     (cases ast a
;;            [num (n) n]
;;            [bool (b) b]
;;            [id-ref (sym) (lookup-env e sym)]
;;            [function (formals body) 
;;                      (closure
;;                        formals
;;                        body
;;                        e)]
;;            [app (func args) ;; When tasked with applying a function, we need
;;                 ;; to check if rator is prim or closure. If it is a prim, we
;;                 ;; need to execute that. rands is the list of arguments. If it
;;                 ;; is 2 long, or 1 long, we act accordingly
;;                 (let [(finfunc (eval-ast func e))]
;;                     (cases proc finfunc
;;                            [prim-proc (prim sig) 
;;                                       (if (= (length args) 1)
;;                                           (prim (eval-ast (first args) e))
;;                                           (prim 
;;                                             (eval-ast (first args) e)
;;                                             (eval-ast (second args) e)))]
;;                 ;; The closures, on the other hand:
;;                 ;; The closure has formals, body, env.
;;                 ;; The arguments passed to the formals will become the new
;;                 ;;   environment, appending the old one on top. This is then
;;                 ;;   passed to the eval-ast again, with the body for execution
;;                            [closure (formals body env) 
;;                                     (let [(newenv 
;;                                             (extended-env
;;                                               formals
;;                                               (numred args)
;;                                               e))]
;;                                       (eval-ast body newenv))]))] ;; filler)
;;            [ifte (c th el)
;;                  (if (boolean? (eval-ast c e))
;;                      (eval-ast th e)
;;                      (eval-ast el e))]
;;            [assume (binds expr)
;;                    (eval-ast expr (envfrombind binds))]
;;            [else 5])))
;; 
