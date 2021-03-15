#lang racket

{require rackunit}

#|

DFS Algorithm Implementation
borrowed from https://danielgplaza.com/posts/2020/functional-dfs/


procedure DFS(G, v, dest) is
    if vertex is discovered
	    return false
    if there are no neighbors
	    return false
    if v is equal to dest
	    return true
    label v as discovered
    for all directed edges from v to w that are in G.adjacentEdges(v) do
        if vertex w is not labeled as discovered then
            recursively call DFS(G, w)
|#

{define (adjacent-vertices vertex
                           graph)
  (hash-ref graph
            vertex)}

{define (depth-first-search* start-vertices
                             dest
                             graph
                             acc)
  (and [(negate empty?) start-vertices]
       (let ([route {depth-first-search (first start-vertices)
                                        dest
                                        graph
                                        acc}])
         {if [not route]
             [depth-first-search* (rest start-vertices)
                                  dest
                                  graph
                                  acc]
             route}))}

{define (depth-first-search start
                            dest
                            graph
                            acc)
  (cond [(equal? start
                 dest)
         (list dest)]
        [(set-member? acc
                      start)
         #f]
        [else
         (let ([route {depth-first-search* (adjacent-vertices start
                                                              graph)
                                           dest
                                           graph
                                           (set-add acc
                                                    start)}])
           (and route
                [cons start
                      route]))])}

{define (main)
  ;;  B ---> C
  ;;  ^\     |
  ;;  | \    v
  ;;  |  \-->F 
  ;;  |      |
  ;;  A<------
  ;;  |
  ;;  v
  ;;  E----->D
  (let [{sample-graph (hash 'A '(B E)
                            'B '(F C)
                            'C '(F)
                            'D empty
                            'E '(D)
                            'F '(A))}]
    
    [check-equal? [depth-first-search 'A
                                      'C
                                      sample-graph
                                      (set empty)]
                  '(A B C)
                  "Failed test case #1"]
    [check-equal? [depth-first-search 'B
                                      'D
                                      sample-graph
                                      (set empty)]
                  '(B F A E D)
                  "Failed test case #2"])}

(main)