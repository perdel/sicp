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

; 1.1.5 The Substitution Model for Procedure Application

; (f 5) 
; (sum-of-squares (+ a 1) (* a 2))
; (sum-of-squares (+ 5 1) (* 5 2))
; (sum-of-squares 6 10)
; (+ (square 6) (square 10))
; (+ (* 6 6) (* 10 10))
; (+ 36 100)
; (136)

; normal-order evaluation
; (sum-of-squares (+ 5 1) (* 5 2))
; (+ (square (+ 5 1)) (square (* 5 2)))
; (+ (* (+ 5 1) (+ 5 1)) (* (* 5 2) (* 5 2)))

; reduction
; (+ (* 6 6) (* 10 10))
; (+ 36 100)

; 1.1.6 Conditional Expressions and Predicates
(define (abs x)
  (cond ((> x 0) x)
        ((= x 0) 0)
        ((< x 0) (- x))))

; alternative definition with else
(define (abs x)
  (cond ((< x 0) (- x))
        (else x)))

; yet another definition with if
(define (abs x)
  (if (< x 0)
      (- x)
      x))

; logical compound operations
; (and (> x 5) (< x 10))

(define (>= x y) (or (> x y) (= x y)))

(define (>= x y) (not (< x y)))

#| Exercise 1.1
Below is a sequence of expressions. What is the result printed by the
interpreter in response to each expression? Assume that the sequence is to be
evaluated in the order in which it is presented. 
|#

10 ; 10
(+ 5 3 4) ; 12
(- 9 1) ; 8
(/ 6 2) ; 3
(+ (* 2 4) (- 4 6)) ; 6

(define a 3)
(define b (+ a 1))
(+ a b (* a b)) ; 19
(= a b) ; #f

(if (and (> b a) (< b (* a b)))
    b
    a) ; 4

(cond ((= a 4) 6)
      ((= b 4) (+ 6 7 a))
      (else 25)) ; 16

(+ 2 (if (> b a) b a)) ; 6

(* (cond ((> a b) a)
         ((< a b) b)
         (else -1))
   (+ a 1)) ; 16
  
#| Exercise 1.2
Translate the following expression into prefix form: (cf. p27)
|#

(/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5))))) (* 3 (- 6 2) (- 2 7)))

#| Exercise 1.3
 Deﬁne a procedure that takes three numbers as arguments and returns the sum of
 the squares of the two larger numbers.
|#

(define (larger-squares a b c)
        (cond ((and (or (< a b) (= a b)) (or (< a c) (= a c))) (sum-of-squares b c))
              ((and (or (< b a) (= b a)) (or (< b c) (= b c))) (sum-of-squares a c))
              (else (sum-of-squares a b))))

#| Exercise 1.4
Observe that our model of evaluation allows for combinations whose operators are
compound expres- sions. Use this observation to describe the behavior of the
following procedure:
|#

(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

; The compound if expression determines the operator: + if b is positive and -
; if b is negative. Based on this choice the absolute value of b is added to a –
; as the name of the procedure implies.

(a-plus-abs-b 2 3) ; 5
(a-plus-abs-b 2 -3) ; also 5