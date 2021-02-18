#lang racket

(define (insert x xs)
  (cond
    [(null? xs)
     (list x)]
    [(<= x (car xs))
     (cons x xs)]
    [else
     (cons (car xs) (insert x (cdr xs)))]))

(define (insertionSort xs)
  (cond
    [(null? xs)
     null]
    [else
     (insert (car xs) (insertionSort (cdr xs)))]))