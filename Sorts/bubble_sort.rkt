#lang racket

; Find the largest element in the list & move it to the last position
{define (bubble xs)
  (cond [(null? (cdr xs))
         xs]
        [(> (car xs) (cadr xs))
         (cons (cadr xs)
               (bubble {cons (car xs) (cdr (cdr xs))}))]
        [else
         (cons (car xs) (bubble (cdr xs)))]
        )}

; Helper function with `i` is the number of elements left unsorted
{define (goBubbleSort xs i)
  (cond [(eq? i 1)
         (bubble xs)]
        [else
         (goBubbleSort (bubble xs) (- i 1))]
        )}

; Bubble Sort
{define (bubbleSort xs)
  (goBubbleSort xs (length xs)
  )}

; demo
(bubbleSort '(4 1 10 3 7 9 5 2 6 8 0))