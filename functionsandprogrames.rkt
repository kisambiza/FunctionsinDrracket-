;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname functionsandprogrames) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "htdp")) #f)))
; FUNCTIONS AND PROGRAMS
;PROGRAMS ARE FUNCTIONS they consume inputs and produce outputs
;programs work with a variety of data images, numbers, strings ....
;programs have definitions and expressions which use the definitions
;there are two kinds of definitions
; constant definitions of the shape (define variable expression) and
; function definitions which come in many flavors (define (functionname variable ... variable) expresion)
;Define a function
; 1. "(define ("
; 2.the name of the function
; 3. followed by variables, separated by space, ending in ")"
; 4. and an expresion followed by ")"
(define (f x) 1)
(define (g x y) (+ 1 1))
(define (h x y z) (+ (* 2 2) 3))
; a function defintion introduces a new operation on data
;the number of variables needed in a function determine the number of inputs
; the inputs are also called arguments or parameters
;APPLICATION OF FUNCTIONS Application of functions puts defined functions to work
;HOW IT WORKS
;1.write "("
;2.write down the name of the defined function f
;3.write down as many arguments as f consumes, separated by space,
;4.And add ")" at the end

(define (sq x) (* x x))
(define (area x y)
  (* x y))

(define (distance x y)
  (if (< y 0) x
      (sqrt (+(sq x) (sq y)))))

(define (cvolume x)
  (* (sq x) x))

(define (csaface x)
  (* (sq x) 6))

; its good plactce to figure out what goes wrong when things go wrong
; function eveluation is a 3 step process, determine the values of the argument expressions,
; check the number of arguments and function parameters if they are the same
; compute the value of the body of the function
; every professional is a programe, a step by step procedure of generating a certain output

(define (string-first s)
  (substring s 0 1))

(define (==> x y)
  (or (not x) y))

(define (image-clasify img)
  (cond
    [(>= (image-height img) (image-width img)) "Tall"]
    [(= (image-height img) (image-width img)) "Square"]
    [(<= (image-height img) (image-width img)) "Wide"]))

(define (string-insert s i)
  (string-append (substring s 0 i)
                 "_"
                 (substring s i)))

