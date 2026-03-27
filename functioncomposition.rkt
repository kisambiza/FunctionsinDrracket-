;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname functioncomposition) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "htdp")) #f)))
(require 2htdp/batch-io)
(define (letter fst 1st signature-name)
  (string-append
   (opening fst)
   "\n\n"
   (body fst 1st)
   "\n\n"
   (closing signature-name)))

(define (opening fst)
  (string-append "Dear " fst ","))

(define (body fst 1st)
  (string-append
   "We have descovered that all people with the" "\n"
   "Last name " 1st " have won our lottery. So " "\n"
   fst ", " "hurry and pick up your prize."))

(define (closing signature-name)
  (string-append
   "Regards,"
   "\n\n"
   signature-name
   "\n"))

; a program should define one function per task