#lang racket
(require eopl)
(require rackunit)
(require racket/match)
(provide (all-defined-out))

;;; parse :: any/c -> ast?  Raises exception exn:parse-error?
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
        [(and (list? exp)               ;; math (binop) parser
              (= (length exp) 3))
         (match (first exp)
                ['+ (binop 'add (parse (second exp)) (parse (third exp)))]
                ['- (binop 'sub (parse (second exp)) (parse (third exp)))]
                ['* (binop 'mul (parse (second exp)) (parse (third exp)))]
                ['/ (binop 'div (parse (second exp)) (parse (third exp)))]
                ['< (binop 'lt? (parse (second exp)) (parse (third exp)))]
                ['== (binop 'eq? (parse (second exp)) (parse (third exp)))]
                [_ (raise-parse-error "Parse error")])]
        [(and (list? exp)               ;; unaryop parser
              (= (length exp) 2)
              (eq? (first exp) `!))
         (unaryop 'neg (parse (second exp)))]
        [else (raise-parse-error "Parse error")]) ;; add an else
  )


;;; lookup-env: [env?  symbol?] -> any/c || exn:lookup-err?
(define lookup-env
  (lambda (e x)
    (define (getv syms vals)            ;; From the list of syms and vals, 
      (if (empty? syms)                 ;; Return val if x in sym, else false
          #f
          (if (eq? (first syms) x)
              (first vals)
              (getv (rest syms) (rest vals)))))
    (cases env e
           [extended-env (syms vals outer-env) 
                         (let ([result (getv syms vals)]) 
                           (if (boolean? result) 
                               (lookup-env outer-env x)
                               result))]
           ;;[empty-env (raise-lookup-error "Lookup Error")]
           [else (raise-lookup-error)])))


;;; eval-ast :: [ast? env?] -> expressible-value? 
;;;                         || (or/c exn:exec-div-by-zero  exn:exec-type-mismatch exn:lookup-error)
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
    (cases ast a
           [num (n) n]
           [bool (b) b]
           [id-ref (sym) (lookup-env e sym)]
           [unaryop (op rand1)
                    (
                     (op-interpretation op)
                     (typecheck-bool (eval-ast rand1 e)))]
           [binop (op rand1 rand2) 
                  (if (eq? op 'div)
                      (
                       (op-interpretation op)
                       (typecheck-num (eval-ast rand1 e))
                       (check-non-zero (typecheck-num (eval-ast rand2 e))))
                      (
                       (op-interpretation op)
                       (typecheck-num (eval-ast rand1 e))
                       (typecheck-num (eval-ast rand2 e))))]
           [ifte (c th el)
                 (if (typecheck-bool (eval-ast c e))
                     (eval-ast th e)
                     (eval-ast el e))]
           [assume (binds expr)
                   (eval-ast expr (envfrombind binds))]
           [else 5])))

