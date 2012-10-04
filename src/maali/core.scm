
;; -*- coding: utf-8 -*-

(define-module maali.core
  (export
    paint)
  (use util.match)
  (use util.list)
  (use srfi-13))
(select-module maali.core)

(define (wrap code)
  (string-append "[" code  "m"))

(define (nothing)
  "[0m")

(define ansi-colours
  '((black   0)
    (red     1)
    (green   2)
    (yellow  3)
    (blue    4)
    (magenta 5)
    (cyan    6)
    (white   7)
    (default 9)
    ))

(define (simple-colour lyst colour)
  (x->string (+ 30 (car (assoc-ref lyst colour)))))

(define (simple s colour)
  (string-append (wrap (simple-colour ansi-colours colour)) s (nothing)))

(define-syntax paint
  (syntax-rules ()
    ((_ s colour)
     (simple s colour)
     )
    )
  )

