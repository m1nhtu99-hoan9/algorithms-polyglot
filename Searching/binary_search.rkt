#lang racket

;; Also my code submission for LeetCode problem 704
;; 46 / 46 test cases passed.
;; Runtime: 400 ms
;; Memory Usage: 128.7 MB

{define/contract (search nums target)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  {define (lookup lowerBound upperBound)
    (cond 
      [(<= lowerBound upperBound)
       {define midpoint (quotient (+ lowerBound upperBound) 2)}
       {define valueAtMidpoint (list-ref nums midpoint)}
       (cond [(= target valueAtMidpoint)
              midpoint] ;; base case
             [(< target valueAtMidpoint)
              (lookup lowerBound (- midpoint 1))]
             [else
              (lookup (+ midpoint 1) upperBound)]
             )]
      [else
       -1]
      )
    }
  (lookup 0 (- (length nums) 1))
  }