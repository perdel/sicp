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

#| Exercise 1.5
Ben Bitdiddle has invented a test to determine whether the interpreter he is
faced with is using applicative- order evaluation or normal-order evaluation. He
defines the following two procedures:
|#

(define (p) (p))
(define (test x y)
  (if (= x 0) 0 y))

(test 0 (p))
; applicative-order evaluation: 
; (test 0 (p)
;   (if (= 0 0) 0 (p))) => never returns because (p) needs to be evaluated

; normal-order evaluation:
; (test 0 (p)
;   (if (= 0 0) 0 (p))) => 0

; 1.1.7 Example: Square Roots by Newton's Method
(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (sqrt x)
  (sqrt-iter 1.0 x))

(sqrt 9)

(sqrt (+ 100 37))

(sqrt (+ (sqrt 2) (sqrt 3)))

(square (sqrt 1000))

#| Exercise 1.6
Alyssa P. Hacker doesn’t see why if needs to be provided as a special form. “Why
can’t I just define it as an ordinary procedure in terms of cond?” she asks.
Alyssa’s friend Eva Lu Ator claims this can indeed be done, and she defines a
new version of if:
|#

(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

(new-if (= 2 3) 0 5)
(new-if (= 1 1) 0 5)

(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))

(sqrt 9)

; The ordinary procedure definition of if, new-if, results in a non-terminating
; procedure call. Since both cases are always evaluated sqrt-iter is called over
; and over again.

#| Exercise 1.7
The good-enough? test used in computing square roots will not be very eﬀective
for ﬁnding the square roots of very small numbers. Also, in real computers,
arithmetic operations are almost always performed with limited precision.  This
makes our test inadequate for very large numbers. Explain these statements, with
examples showing how the test fails for small and large numbers. An alternative
strategy for implementing good-enough? is to watch how guess changes from one
iteration to the next and to stop when the change is a very small fraction of
the guess.  Design a square-root procedure that uses this kind of end test. Does
this work better for small and large numbers?
|#

(square (sqrt 1e-10)); fails for small numbers
(square (sqrt 5e20)); fails for large numbers

(define (sqrt-iter guess x)
  (let ((better (improve guess x)))
  (if (better-good-enough? guess better)
      guess
      (sqrt-iter better x))))

(define (better-good-enough? new-guess old-guess)
  (< (abs (- new-guess old-guess)) (* 0.001 new-guess)))

(square (sqrt 1e-10)); works now for small numbers
(square (sqrt 5e20)); also works for large numbers

#| Exercise 1.8
Newton’s method for cube roots is based on the fact that if y is an
approximation to the cube root of x, then a better approximation is given by the
value (x/y^2 + 2y)/3. Use this formula to implement a cube-root procedure
analogous to the square-root procedure. (In Section 1.3.4 we will see how to
implement Newton’s method in general as an abstraction of these square-root and
cube-root procedures.)
|#

(define (cube-root x)
  (cube-root-iter 1.0 x))

(define (cube-root-iter guess x)
  (let ((better (improve guess x)))
  (if (better-good-enough? guess better)
      guess
      (cube-root-iter better x))))

(define (improve guess x)
  (/ (numerator guess x) 3))

(define (numerator guess x)
  (+ (/ x (square guess)) (* 2 guess)))

(cube-root 125)

; 1.1.8 Procedures as Black-Box Abstractions

; procedural abstractions
(define (square x) (* x x))
(square 2)
(define (square x) (exp (double (log x))))
(define (double x) (+ x x))
(square 2)

; local names 
(define (square x) (* x x))
(define (square y) (* y y)) ; not distinguishable

; illustrate bound variables
(define (good-enough? guess x)
  (< (abs (- (square guess) x))
  0.001))
; guess and x are bound variables
; <, abs, -, square are free variables

; interal definitions and block structures

; nesting definition, block structure 
(define (sqrt x)
  (define (good-enough? guess x)
    (< (abs (- (square guess) x)) 0.001))
  (define (improve guess x) (average guess (/ x guess)))
  (define (sqrt-iter guess x)
    (if (good-enough? guess x)
        guess
        (sqrt-iter (improve guess x) x)))
  (sqrt-iter 1.0 x))

(sqrt 9)

; make x a free variable -> lexical scoping
(define (sqrt x)
  (define (good-enough? guess)
    (< (abs (- (square guess) x)) 0.001))
  (define (improve guess) (average guess (/ x guess)))
  (define (sqrt-iter guess)
    (if (good-enough? guess)
        guess
        (sqrt-iter (improve guess))))
  (sqrt-iter 1.0))

(sqrt 9)

; 1.2 Procedures and the Processes They Generate

; 1.2.1 Linear Recursion and Iteration

; linear recursive process for computing 6!
(define (factorial n)
  (if (= n 1)
      1
      (* n (factorial (- n 1)))))

(factorial 6); 720

; linear iterative process for computing 6!
(define (factorial n)
  (fact-iter 1 1 n))
(define (fact-iter product counter max-count)
  (if (> counter max-count)
      product
      (fact-iter (* counter product)
                 (+ counter 1)
                 max-count)))

(factorial 6); 720

#| Exercise 1.9
Each of the following two procedures defines a method for adding two positive
integers in terms of the procedures inc, which increments its argument by 1, and
dec, which decrements its argument by 1
|#

#| 
Using the substitution model, illustrate the process generated by each procedure
in evaluating (+ 4 5). Are these processes iterative or recursive?
|#

(define (+ a b)
  (if (= a 0) b (inc (+ (dec a) b))))

; (+ 4 5)
; (inc (+ 3 5))
; (inc (+ inc (+ 2 5)))
; (inc (+ inc (+ inc (+ 1 5))))
; (inc (+ inc (+ inc (+ inc (+ 0 5)))))
; (inc (+ inc (+ inc (+ inc (5)))))
; (inc (+ inc (+ inc (6))))
; (inc (+ inc (7)))
; (inc (8))
; (9)

; => recursive process


(define (+ a b)
  (if (= a 0) b (+ (dec a) (inc b))))

; (+ 4 5)
; (+ 3 6)
; (+ 2 7)
; (+ 1 8)
; (+ 0 9)
; (9)

; => iterative process

#| Exercise 1.10:
The following procedure computes a mathematical function called Ackermann’s
function.
|#
(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1) (A x (- y 1))))))

; What are the values of the following expressions?
(A 1 10) ; => 1024
(A 2 4) ; => 65536
(A 3 3) ; => 65536

; Consider the following procedures, where A is the procedure defined above:
(define (f n) (A 0 n)) ; => computes 2n
(define (g n) (A 1 n)) ; => computes 2^n
(define (h n) (A 2 n)) ; => computes 2^2^2... n times, i.e. tetration
(define (k n) (* 5 n n))

#|
Give concise mathematical definitions for the functions computed by the
procedures f, g, and h for positive integer values of n. For example, (k n)
computes 5n^2.
|#

; 1.2.2 Tree Recursion

; Compute Fibonacci numbers
(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1))
                 (fib (- n 2))))))

(fib 5) ; 5

; Terrible way of computing Fibonacci numbers because extremely redundant.

; iterative procedure to compute Fibonacci numbers:
(define (fib-linear n)
  (fib-iter 1 0 n))
(define (fib-iter a b count)
  (if (= count 0)
    b
    (fib-iter (+ a b) a (- count 1))))

(fib-linear 6)
