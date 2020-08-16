#lang racket/base

(require eopl)
 
(define-datatype full-binary-tree full-binary-tree?
  (internal-node (value integer?)
                 (left-child full-binary-tree?)
                 (right-child full-binary-tree?))
  (leaf-node (value integer?)))


(define inode
  (lambda (v l r)(internal-node v l r)))

(define lnode
  (lambda (v)(leaf-node v)))

(provide full-binary-tree)
(provide full-binary-tree?)
(provide inode)
(provide lnode)

(provide internal-node)
(provide leaf-node)
