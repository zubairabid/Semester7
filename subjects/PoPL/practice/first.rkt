#lang racket

(define (repeat n x)
  (if (= n 0)
      '()
      (cons x (repeat (- n 1) x))))

(define (invert lst)
  (if (null? lst)
      '()
      (cons (reverse (car lst)) (invert (cdr lst)))))

(define (count-occurrences s slist)
  (define (occplus s comp)
    (if (= s comp)
        1
        0))
  (if (null? slist)
      0
      (+ (occplus s (car slist)) (count-occurrences s (cdr slist)))))

(define (product sos1 sos2) 
  (cond
    [(null? sos1) sos2]
    [(null? sos2) sos1]
    [else 
      (cond
        [(> (length sos1) 1)
         (append (product (list (car sos1)) sos2) (product (cdr sos1) sos2))]
        [(> (length sos2) 1)
         (append (product sos1 (list (car sos2))) (product sos1 (cdr sos2)))]
        [else (list (append sos1 sos2))])]))


(define (every pred lst) 
  (if (null? lst)
      #t
      (and (pred (car lst)) (every pred (cdr lst)))))

(define (merge loi1 loi2)
  (cond 
    [(null? loi1) loi2]
    [(null? loi2) loi1]
    [else 
      (if (< (car loi1) (car loi2))
             (append (list (car loi1)) (merge (cdr loi1) loi2))
             (append (list (car loi2)) (merge loi1 (cdr loi2))))]))

(define (flatten dlst)
  (cond
    [(null? dlst) '()]
    [(not (list? dlst)) (list dlst)]
    [else (append (flatten (car dlst)) (flatten (cdr dlst)))]))

(require eopl)
(require "fdtypes.rkt")
 
(define (traverse/preorder tree)
  (cases full-binary-tree tree
    (leaf-node (v) (list v))
    (internal-node (v left right) 
      (append 
        (list v)
        (append 
          (traverse/preorder left) 
          (traverse/preorder right))))))

(define (traverse/inorder tree)
  (cases full-binary-tree tree
    (leaf-node (v) (list v))
    (internal-node (v left right) 
      (append 
        (traverse/inorder left) 
        (append 
          (list v)
          (traverse/inorder right))))))

(define (traverse/postorder tree)
  (cases full-binary-tree tree
    (leaf-node (v) (list v))
    (internal-node (v left right) 
      (append 
        (traverse/postorder left) 
        (append 
          (traverse/postorder right)
          (list v))))))

