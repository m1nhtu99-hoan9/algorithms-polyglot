#lang racket

#|
1038. Binary Search Tree to Greater Sum Tree (Medium)

28 / 28 test cases passed.
Runtime: 200 ms (beats 100% of racket submissions)
Memory Usage: 98.1 MB (beats 100% of racket submissions)
|#

; val : integer?
; left : (or/c tree-node? #f)
; right : (or/c tree-node? #f)
{struct tree-node
  (val left right) #:mutable #:transparent}

; constructor
{define (make-tree-node [val 0])
  (tree-node val #f #f)}

;; Reverse-inorder traversal with `proc` applied to each node visited
{define (traverse-reverse-inorder-bst root proc)
  [define (helper_ root)
    [unless ((or not null?) root)        ; when not in the last level
      (helper_ (tree-node-right root))
      (proc root)
      (helper_ (tree-node-left root))]
    ]
  
  (helper_ root)                        ; initial recursive call
  }

{define/contract (bst-to-gst root)
  (-> (or/c tree-node? #f) (or/c tree-node? #f))
  
  [define sum_ 0]
  [define (acc-sum! node)
    (set! sum_
          (+ sum_
             (tree-node-val node)))
    (set-tree-node-val! node sum_)  
    ]

  [traverse-reverse-inorder-bst root acc-sum!]

  root
  }