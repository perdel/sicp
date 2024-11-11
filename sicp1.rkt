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

