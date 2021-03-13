#lang racket

#|
199. Binary Tree Right Side View (Medium)

215 / 215 test cases passed.
Runtime: 216 ms (beats 100% of racket solutions)
Memory Usage: 98.4 MB (beats 100% of racket solutions)
|#

; Definition for a binary tree node.
; val : integer?
; left : (or/c tree-node? #f)
; right : (or/c tree-node? #f)
(struct tree-node
  (val left right) #:mutable #:transparent)

; constructor
(define (make-tree-node [val 0])
  (tree-node val #f #f))

{define (nil-node? node)
  [(or not null?) node]}

{define/contract (right-side-view root)
  (-> (or/c tree-node? #f) (listof exact-integer?))

  {define temp_ (list)}
  
  {define (helper node level)
    (unless [nil-node? node]
      ; "remember" right-view-side entry for at this level
      (when [< (length temp_)
               level]
        [set! temp_
              (cons [tree-node-val node]
                    temp_)])
      ; reverse in-order traverse
      (helper (tree-node-right node) (add1 level))
      (helper (tree-node-left node) (add1 level)))}

  (helper root 1)
  
  (reverse temp_)}