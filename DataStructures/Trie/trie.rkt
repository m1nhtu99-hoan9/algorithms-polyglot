#lang racket

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
    
    ; find : string? -> boolean?
    (define/public (find word)
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

    ; delete : string? -> void?
    (define/public (delete word)
      (error "To Be Implemented!")))}