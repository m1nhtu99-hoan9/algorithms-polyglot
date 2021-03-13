#lang racket

|#
208. Implement Trie (Prefix Tree) (Medium)

15 / 15 test cases passed.
Runtime: 548 ms (beats 100% of racket submissions)
Memory Usage: 128.5 MB (beats 100% of racket submissions)
#|

{define (char-lower->index c)
  (- [char->integer c]
     [char->integer #\a])}

{define trie-node%
  (class object%
    (super-new)
    (field [children (make-vector 26 null)] ; 26 alphabet characters
           [end? #f])

    (define/public (get-child-@index index)
      [vector-ref (get-field children
                             this)
                  index])
    (define/public (set-child-@index! index val)
      (vector-set! [get-field children this]
                   index
                   val)))}

{define trie%
  (class object%
    (super-new)
    
    ; no initialisation variables
    (init-field)
    ; private fields
    {define root_ (new trie-node%)}
    
    ; insert : string? -> void?
    (define/public (insert word)
      
      {define cur-node root_}

      {for ([c word])
        (let* ([i (char-lower->index c)])
          (when [null? (send cur-node
                             get-child-@index
                             i)]
            [send cur-node
                  set-child-@index!
                  i
                  (new trie-node%)])
          (set! cur-node
                (send cur-node
                      get-child-@index
                      i)))}

      {set-field! end?
                  cur-node
                  #t})
    
    ; search : string? -> boolean?
    (define/public (search word)
      {define cur-node root_}
      
      [and {for/and ([c word])
             (let* ([i (char-lower->index c)]
                    [cur-child (send cur-node
                                     get-child-@index
                                     i)])
               (cond [(null? cur-child)
                      #f] ; for-loop "terminates" here
                     [else
                      (set! cur-node cur-child)
                      #t]))}
           {(negate null?) cur-node}
           {get-field end? cur-node}])
    
    ; starts-with : string? -> boolean?
    (define/public (startsWith prefix)
      {define cur-node root_}
      
      {for/and ([c prefix])
        (let* ([i (char-lower->index c)]
               [cur-child (send cur-node
                                get-child-@index
                                i)])
          (cond [(null? cur-child)
                 #f]
                [else
                 (set! cur-node cur-child)
                 #t]))}))}

;; Your trie% object will be instantiated and called as such:
;; (define obj (new trie%))
;; (send obj insert word)
;; (define param_2 (send obj search word))
;; (define param_3 (send obj starts-with prefix))