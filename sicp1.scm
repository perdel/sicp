#lang sicp

; 1.1 The Elements of Programming

; 1.1.1 Expressions

; primitive expression
486

; compound expression
(+ 137 349)

(- 1000 334)

(* 5 99)

(/ 10 5)

(+ 2.7 10)

; more arguments
(+ 21 35 12 7)

(* 25 4 12)

; nested combinations
(+ (* 3 5 ) (- 10 6))

(+ (* 3 (+ (* 2 4) (+ 3 5))) (+ (- 10 7) 6))

; easier reading
(+ (* 3 
      (+ (* 2 4) 
         (+ 3 5))) 
   (+ (- 10 7) 
      6))

; 1.1.2 Naming and the Environment

; associate name size with value 2
(define size 2)

; refer by name
size

(* 5 size)

(define pi 3.14159)
(define radius 10)
(* pi (* radius radius))

(define circumference (* 2 pi radius))
circumference

; 1.1.3 Evaluating Combinations

; tree accumulation
(* (+ 2 (* 4 6))
   (+ 3 5 7))

; definitions are examples for exceptions to the general evaluation rule - they
; are special forms

; 1.1.4 Compound Procedures

; defining procedures
(define (square x) (* x x))

(square 21)
(square (+ 2 5))
(square (square 3))

(define (sum-of-squares x y)
  (+ (square x) (square y)))
(sum-of-squares 3 4)

(define (f a)
  (sum-of-squares (+ a 1) (* a 2)))
(f 5)
