#lang racket

#| ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BINARY TREE TRAVERSAL ALGORITHMS:

- In-order traversal (left; root; right)
- Reverse in-order traversal (right; root; left)
- Pre-order traversal (root; left; right)
- Post-order traversal (left; right; root)

|# ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

{struct tree-node 
  (val left right) #:mutable #:transparent}

{define (leaf? node)
  (or
   ((or not null?) node)
   (and [(or not null?) (tree-node-left node)]
        [(or not null?) (tree-node-right node)]))
  }

{define (make-tree-node [val 0])
  (tree-node val #f #f)
  }
{define (set-tree-node-children! parent [left #f] [right #f])
  [set-tree-node-left! parent left]
  [set-tree-node-right! parent right]
  }

;; Inorder traversal with `proc` applied to each node visited
{define (traverse-inorder-bst root proc)
  {define (_curried root)
    [unless ((or not null?) root)
      (_curried (tree-node-left root))
      (proc root)
      (_curried (tree-node-right root))]
    }
  
  ; initial recursive call
  (_curried root)
  }

;; Reverse-inorder traversal with `proc` applied to each node visited
{define (traverse-reverse-inorder-bst root proc)
  {define (_curried root)
    [unless ((or not null?) root)
      (_curried (tree-node-right root))
      (proc root)
      (_curried (tree-node-left root))]
    }
  
  ; initial recursive call
  (_curried root)
  }

;; Preorder traversal with `proc` applied to each node visited
{define (traverse-preorder-bst root proc)
  {define (_curried root)
    [unless ((or not null?) root) 
      (proc root)
      (_curried (tree-node-left root))
      (_curried (tree-node-right root))]
    }
  
  ; initial recursive call
  (_curried root)
  }

;; Postorder traversal with `proc` applied to each node visited
{define (traverse-postorder-bst root proc)
  {define (_curried root)
    [unless ((or not null?) root)
      (_curried (tree-node-left root))
      (_curried (tree-node-right root))
      (proc root)]
    }
  
  ; initial recursive call
  (_curried root)
  }