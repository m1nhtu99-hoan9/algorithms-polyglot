#lang racket

#|
51. N Queens (Hard)

9 / 9 test cases passed.
Runtime: 528 ms (beats 100% of Racket submission)
Memory Usage: 126 MB (beats 100% of Racket submission)
|#

{define/contract (solve-n-queens n)
  (-> exact-integer? (listof (listof string?)))

  (map solution->board (queens n))
  }

{define/contract (queens n)
  (-> exact-integer? [listof (listof pair?)])
  
  {define res null}   ; accumulator for results

  ; Equation for diagonal lines in chess board: `y = k ± x`
  ; in which gradient `k ∈ (range n)`
  ; Hence, each unique `k` represents 2 unique diagonal lines
  {define/contract (solve lst gradsTaken1 gradsTaken2 row cols)
    ; Set `gradsTaken1` "remembers" all `k` got from  `y + x`
    ; Set `gradsTaken2` "remembers" all `k` got from `-y + x`
    (-> [listof (listof pair?)] set? set? exact-nonnegative-integer? set? void)
    
    [if (= row n)
        ; base case -> accumulate a solution to `res` & return `void` 
        (set! res (cons lst res))      

        {for ((col (in-set cols))) 
          {define grad1 (+ col row)}       
          {define grad2 (- col row)}     
          (unless [or
                   (set-member? gradsTaken1 grad1)
                   (set-member? gradsTaken2 grad2)]
            ; if diagonals not yet taken by qny queens
            (solve
             (cons (cons row col) lst)     
             (set-add gradsTaken1 grad1)   
             (set-add gradsTaken2 grad2)    
             (+ row 1)                
             (set-remove cols col)) 
            )
          }]
    }

  (solve null (set) (set) 0 (apply set (range n))) ; initial call
  res
  }

{define/contract (solution->board solution)
  (-> [listof pair?] [listof string?])
  {define n (length solution)}
  {define mat (make-vector n)}

  {for [(point solution)]
    {define row (car point)}
    {define col (cdr point)}

    {define board-row
      (list->string
       (map [lambda (x) (cond [(= x col) #\Q] [else #\.])]
            (range n))
       )
      }
    
    {vector-set! mat row board-row}
    }
  
  (vector->list mat)
  }


