#lang racket

-|
287. Find Duplicate Number (Medium)

53 / 53 test cases passed.
Runtime: 280 ms (beats 100% of racket submissions)
Memory Usage: 128.6 MB (beats 100% of racket submissions)
|-

{define/contract (find-duplicate nums)
  (-> (listof exact-integer?) exact-integer?)

  ; use a hash table for caching
  {define cache (make-hash)}
  {define L (length nums)}

  {define (cached? item)
   (if [not (hash-has-key? cache item)]
       [(const #f) {hash-set! cache item #t}]
       item)}

  (for/first ([x nums]
              #:when (cached? x))
    x)
  }