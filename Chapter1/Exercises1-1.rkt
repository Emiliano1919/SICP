#lang scheme
;EXERCISE 1.1
10 
; 10
(+ 5 3 4)
; 12
(- 9 1)
; 8
(/ 6 2)
; 3
(+ (* 2 4) (- 4 6))
; 6
(define a 3)
(define b (+ a 1))
; b = 3+1 = 4 
(+ a b (* a b))
; + 3 4 12 = 19
(= a b)
; false 
(if (and (> b a) (< b (* a b)))
    b
    a)
; 4
(cond ((= a 4) 6)
      ((= b 4) (+ 6 7 a))
      (else 25))
; 16
(+ 2 (if (> b a) b a))
; 4+2 = 6
(* (cond ((> a b) a)
         ((< a b) b)
         (else -1))
   (+ a 1))
; * 4 4 = 16


;EXERCISE 1.2

(/ (+ 5 4
      (- 2
         (- 3
            (+ 6
               (/ 4 5)))))
   (* 3
      (- 6 2)
      (- 2 7)))
; Results in -37/150=-0.2466666

;EXERCISE 1.3
(define (square x) (* x x))
(define (2bigSquares a b c)
  (cond ((and (>= a b) (>= b c))
         (+ (square a)(square b)))
        ((and (>= b a) (>= a c))
         (+ (square b)(square a)))
        ((and (>= a b) (>= c b))
         (+ (square a)(square c)))
        ((and (>= c a) (>= a b))
         (+ (square c)(square a)))
        ((and (>= c b) (>= b a))
         (+ (square c)(square b)))
        ((and (>= b c) (>= c a))
         (+ (square b)(square c)))
        ((and (= a c) (= c b))
         (+ (square a)(square b)))))

;EXERCISE 1.4
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))
; We define a function called a-plus-abs-b in which
; you input 2 values a and b and if
; b is positibe you add them together like a+b
; but if b is negative you add them like a- (-b)=a+b
; this is possible since the operator that manipulates a and b
; is a compound expression where it decides what to use - or + depending on the value of b

; EXERCISE 1.5
(define (p) (p))
(define (test x y)
  (if (= x 0) 0 y))
; if we are using applicative-order we will get 0 since we evaluate first (= x 0) and we don't get into a loop
; if we use normal-order we will expand first and in doing so we will put (if (= 0 0) 0 (p)) and
; we will continue to expand the (p) infinitely until we get a stack overflow error (at least in other languages, idk how it works here)