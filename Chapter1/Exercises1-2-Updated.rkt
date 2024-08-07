#lang scheme
;Chapter 1.2
;Exercise 1.9
(define (factorial n) (if (= n 1)
      1
      (* n (factorial (- n 1)))))
; Tail recursion is nice
(define (inc x) (+ x 1))
(define (dec x) (- x 1))

;(define (+ a b)
;(if (= a 0) b (inc (+ (dec a) b))))

; I made the drawing in my notebook we are calling procedures for the first 5 steps until we actually
; start reducting the equations.

;(define (+ a b)
;(if (= a 0) b (+ (dec a) (inc b))))

; Although this one still expands and then contracts we can determine the result of the process at any point.
; Therefore it is iterative.
;Notice that at each step (+ a b)= 9
; In the other process that is different. we go from 4+5 to 0+5
; If you were to put at any point in time those values, we wouldn't get the initial result


;Exercise 1.10

(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1) (A x (- y 1))))))

;(A 1 10) = 1024
;(A 2 4) = 65536
;(A 3 3) = 65536

(define (f n) (A 0 n))
;f(n)= 2n
(define (g n) (A 1 n))
;g(n)= 2^n
; It basically calls A(0,n-blabla) producing 2*the blabalba
; The fault is of the A procedure inside nested in the Ackermand of the else
(define (h n) (A 2 n))
; It will keep on calling A(1,A(1, A(1,A(1,....n-blablaba))))
; Unitl n-blabalabal = n-(n-1)= 1
; at which point there will be a 1 in the y position
; So we will have something like A(1,A(1,2)) which
; will end up creating A(1,2*2)
; this will continue collapsing the call pyramid by doing 2*2 y
; n-1 times, but it is important to note that the y would become the y=2*2y
; it should be something like

; h(n)=2^{h(n-1)}

; why? because we will have initially 2*2
; then we will have again 2*2*2*2
; we will be basically having the first 2^2 then keep on adding twos
; we will stop this when we have done it n-1 times
; ------------------------------------>n-1
; ------------------------------------2^2
; -----------------------------------(2^2)^2
; ----------------------------------((2^2)^2)^2
; ...
; 2^2^2^2^2^.....
; h(n)=2^{h(n-1)}
; this kind of broke my brain
; KAPUTTTT

(define (k n) (* 5 n n))
;  k(n)= 5n^2


; Exercise 1.11
(define (F n)
  (cond ((< n 3) n)
        (else (+ (F (- n 1))
                 (* 2 (F (- n 2)))
                 (* 3 (F (- n 3)))))
        ))
; Recursive process was easy to write, but I have no idea rn how to do iterative process
; n if n<3,
;f(n-1)+2f(n-2)+3f(n-3) if n≥3.
; f(3)= f(2)+2f(1)+3f(0)=2+2+0=4
; f(4)= f(3)+2f(2)+3f(1)=11

; f(10)=f(9)+2f(8)+3f(7)
; f(9)=f(8)+2f(7)+3f(6)
; f(8)=f(7)+2f(6)+3f(5)
; f(7)=f(6)+2f(5)+3f(4)
; f(6)=f(5)+2f(4)+3f(3)
; f(5)=f(4)+2f(3)+3f(2)
;> (Fd 3)
;4
;> (F 4)
;11
;> (Fd 4)
;11
;> (F 5)
;25
;> (Fd 5)
;25
(define (Fd n) (iter 2 1 0 n))
(define (iter a b c count)
  (if (< count 3)
      a
      (iter (+ a (* b 2) (* c 3)) a b (- count 1))))



; Exercise 1.12
; Kind of broke my brain, i'm too used to iteration and having ariables and lists
; what gave me the answer was this
;0
;0 1
;0 1 1
;0 1 2 1
;0 1 3 3 1
;0 1 4 6 4 1
; this is the same triangle but this one makes you realize that you can calculate it base on row above and row to the left
; you don't need to have the numbers in the middle
; Starts in column 0 and row 0
;-----------CASIOPEA CODE----------------;4
(define (Pascal row column)
  (cond
     ((and (= column 0)(= row 0)) 1)
     ((or (< column 0)(< row 0)) 0)
     (else (+ (Pascal (- row 1) (- column 1)) (Pascal (- row 1) column)))
   ))
;----------ISA'S SOLUTION--------------;3
(define (pascal n k)
  (if (or (= n k) (= n 1) (= k 1)) 1
      (+ (pascal (- n 1) (- k 1)) (pascal (- n 1) k))
   ))
;----------FactorialSOLUTION--------------; 2
(define (fpascal n k)
  (/ (factorial n) (* (factorial k)(factorial (- n k)))))
;----------ChooseSOLUTION--------------; 1
(define (cpascal n k)
  (if (or (= n 0) (= k 0)) 1 (/ (* n (cpascal (- n 1) (- k 1))) k)))

; I haven't managed to make this printer of the pyramid work
;(define (Printer a b n)
 ; (if (= count 0)
 ;     b
  ;    (fib-iter (+ a b) a (- count 1))))


;--------Recursive Fib---------------;
(define (Rfib n) (cond ((= n 0) 0) ((= n 1) 1)
(else (+ (Rfib (- n 1)) (Rfib (- n 2))))))
;---------Iterative Fib--------------;
(define (Ifib n) (fib-iter 1 0 n))
(define (fib-iter a b count) (if (= count 0)
      b
      (fib-iter (+ a b) a (- count 1))))
;----------Estimate Fib-------------;
(define (Fib n)(/ (- (expt (/ (+ 1 (sqrt 5)) 2) n)
                  (expt (/ (- 1 (sqrt 5)) 2) n)) (sqrt 5) ))

; Exercise 1.16
(define (square n) (* n n))
; Book Recursive solution
(define (fast-expt b n)
  (cond ((= n 0) 1)
   ((even? n) (square (fast-expt b (/ n 2))))
   (else (* b (fast-expt b (- n 1))))))
; Casiopea Solution
(define (expt b n)
  (cond ((= n 0) 1)
        ((= n 1) b)
        (else (expt-iter b n 1))))
(define (expt-iter b counter product)
  (cond ((= counter 1) product)
        ((even? counter) (expt-iter b (/ counter 2) (* product (* b b))))
        (else (expt-iter b (- counter 1) (* product b)))))

;Exercie 1.17
(define (* a b)
  (if (= b 0)
      0
      (+ a (* a (- b 1)))))
;Pre-work
(define (double b) (+ b b))
(define (halve b) (halve-iter 0 b))
(define (halve-iter counter product)
  (cond ((= product 0) counter)
  (else (halve-iter (+ counter 1) (- product 2)))))
; Actual Solution
(define (fast-multi a b)
  (cond ((= b 0) 0)
   ((even? b) (double (fast-multi a (halve b))))
   (else (+ a (fast-multi a  (- b 1))))))


;Exercice 1.18
(define (multi a b)
  (cond((even? b) (multi-iter a a b 1))
       (else (multi-iter a 0 b 0))))
(define (multi-iter a product b c)
  (cond
    ((and (= b 1) (= c 1)) product)
    ((and (= b 0) (= c 0)) product)
    ((even? b) (multi-iter a (double product) (halve b) c))
        (else (multi-iter a (+ a product) (- b 1) c))))