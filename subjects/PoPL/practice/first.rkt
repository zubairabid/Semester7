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

(define (count-nodes tree)
  (cases full-binary-tree tree
    (leaf-node (v) 1)
    (internal-node (v left right)
      (+ 1 (count-nodes left) (count-nodes right)))))

(define (count-leaves tree)
  (cases full-binary-tree tree
    (leaf-node (v) 1)
    (internal-node (v left right)
      (+ (count-leaves left) (count-leaves right)))))

(define (count-internal tree)
  (cases full-binary-tree tree
    (leaf-node (v) 0)
    (internal-node (v left right)
      (+ 1 (count-internal left) (count-internal right)))))

(define (tree/map fn tr)
  (cases full-binary-tree tr
    (leaf-node (v) (lnode (fn v)))
    (internal-node (v left right)
      (inode (fn v) (tree/map fn left) (tree/map fn right)))))

(define path-item (list "left" "right"))
(define (value-at-path path tree)
  (cond
    [(null? path) (cases full-binary-tree tree 
                    (leaf-node (v) v)
                    (internal-node (v left right) v))]
    [(equal? (list-ref path-item 0) (car path))
      (cases full-binary-tree tree
        (leaf-node (v) tree) ;; return the last node in the path
        (internal-node (v left right) (value-at-path (cdr path) left)))]
    [(equal? (list-ref path-item 1) (car path))
      (cases full-binary-tree tree
        (leaf-node (v) tree) ;; return the last node in the path
        (internal-node (v left right) (value-at-path (cdr path) right)))]))

(define (search val tree)
  (cases full-binary-tree tree
    (leaf-node (v)
      (if (= v val)
          '()
          #f))
    (internal-node (v left right)
      (if (= v val)
          '()
          (let ([lefts (search val left)])
            (if (list? lefts)
              (append (list (list-ref path-item 0)) lefts)
              (let ()
                (define rights (search val right))
                (if (list? rights)
                    (append (list (list-ref path-item 1)) rights)
                    #f))))))))

(define (update path fn tree)
  (cond
    [(null? path) 
      (cases full-binary-tree tree 
        (leaf-node (v) 
          (lnode (fn v)))
        (internal-node (v left right) 
          (inode (fn v) left right)))]
    [(equal? (list-ref path-item 0) (car path))
      (cases full-binary-tree tree
        (leaf-node (v) (lnode v)) ;; return unchanged
        (internal-node (v left right)
          (inode v (update (cdr path) fn left) right)))]
    [(equal? (list-ref path-item 1) (car path))
      (cases full-binary-tree tree
        (leaf-node (v) (lnode v)) ;; return unchanged
        (internal-node (v left right)
          (inode v left (update (cdr path) fn right))))]))

(define (tree/insert path left-st right-st tree)
  (cond
    [(null? path)
      (cases full-binary-tree tree
        (leaf-node (v)
          (inode v left-st right-st))
        (internal-node (v left right) ;; faulty pathfinding
          (inode v left right)))] ;; return unchanged
    [(equal? (list-ref path-item 0) (car path))
      (cases full-binary-tree tree
        (leaf-node (v) (lnode v)) ;; return unchanged
        (internal-node (v left right)
          (inode v (tree/insert (cdr path) left-st right-st tree) right)))]
    [(equal? (list-ref path-item 1) (car path))
      (cases full-binary-tree tree
        (leaf-node (v) (lnode v)) ;; return unchanged
        (internal-node (v left right)
          (inode v left (tree/insert (cdr path) left-st right-st tree))))]))
