#lang racket

#|
268. Missing Number (Easy)

122 / 122 test cases passed.
Runtime: 488 ms (beats 100% of Racket submission)
Memory Usage: 128.6 MB (beats 100% of Racket submission)
|#

{define/contract (missing-number nums)
  (-> (listof exact-integer?) exact-integer?)
  
    {define n (length nums)}
    {define whole-sum [/ (* (add1 n) 
                            n) 
                         2]}
    {define actual-sum [foldr + 0 nums]}
    
    (- whole-sum actual-sum)
  }