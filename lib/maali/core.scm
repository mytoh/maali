
;; -*- coding: utf-8 -*-

(define-module maali.core
  (export
    paint)
  (use maali.rgb-colours)
  (use util.match)
  (use util.list)
  (use srfi-1)
  (use srfi-13))
(select-module maali.core)

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

(define ansi-effects
  '(
    (reset 0) (nothing 0)
    (bright 1) (bold    1)
    (faint          2)
    (italic         3)
    (underline      4)
    (blink           5)  (slow_blink        5)
    (rapid_blink    6)
    (inverse         7)  (swap              7)
    (conceal         8)  (hide              9)
    (default_font   10)
    (font0   10) (font1   11) (font2   12) (font3   13) (font4   14)
    (font5   15) (font6   16) (font7   17) (font8   18) (font9   19)
    (fraktur        20)
    (bright_off      21) (bold_off          21) (double_underline   21)
    (clean          22)
    (italic_off      23) (fraktur_off       23)
    (underline_off  24)
    (blink_off      25)
    (inverse_off     26) (positive          26)
    (conceal_off     27) (show              27) (reveal             27)
    (crossed_off     29) (crossed_out_off   29)
    (frame          51)
    (encircle       52)
    (overline       53)
    (frame_off       54) (encircle_off      54)
    (overline_off   55)
    ))

(define ansi-colours-foreground
  '(
    (black    30)
    (red      31)
    (green    32)
    (yellow   33)
    (blue     34)
    (magenta  35)
    (cyan     36)
    (white    37)
    (default  39)
    ))

(define ansi-colours-background
  '(
    (black    40)
    (red      41)
    (green    42)
    (yellow   43)
    (blue     44)
    (magenta  45)
    (cyan     46)
    (white    47)
    (default  49)
    ))

(define (wrap code)
  (string-append "[" code  "m"))

(define (wrap-with-nothing code s)
  (string-append code s (nothing)))

(define (nothing)
  "[0m")


(define (symbol-colour-foreground lyst colour)
  (x->string (car (assoc-ref lyst colour))))


(define (rgb-value red green blue)
  (if (if-gray-possible red green blue)
    (string-append
      ";5;"
      (number->string
        (+ 232
           (floor->exact (/. (+ red green blue) 33)))))
    ; ";5;#{ 232 + ((red.to_f + green.to_f + blue.to_f)/33).round }"
    (string-append
      ";5;"
      (number->string
        (+ 16
           (* (floor->exact (*. 6 (/. red 256))) 36)
           (* (floor->exact (*. 6 (/. green 256))) 6)
           (* (floor->exact (*. 6 (/. blue 256))) 1))))))

(define (duplicate-string s)
  (list->string
    (fold
      (lambda (c r)
        (append (list c c) r))
      '() (string->list s))))


(define (if-gray-possible red green blue)
  (let loop ((sep 42.5)
             (cnt 1))
    (cond
      ((or (< red (* sep cnt))
         (< green (* sep cnt))
         (< blue  (* sep cnt)))
       (and (< red (* sep cnt))
         (< green (* sep cnt))
         (< blue (* sep))))
      ((< cnt 6)
       (loop sep (+ cnt 1)))
      ((< 6 cnt)
        #t))))

(define (colour-rgb r g b)
  (string-append
    "38"
    (rgb-value r g b)))

(define (colour-symbol colour)
  (let ((c (symbol-colour-foreground ansi-colours-foreground colour)))
    (cond
      (c c))
    ))

(define (colour-hex colour)
  (let ((s (string-trim colour #\#)))
    (cond
      ((= (string-length s) 6)
       (colour-rgb (string->number (substring s 0 2) 16)
                   (string->number (substring s 2 4) 16)
                   (string->number (substring s 4 6) 16)))
      ((= (string-length s) 3)
       (colour-hex (duplicate-string s))))))

(define (colour-rgb-name name)
  (let* ((cols (car (assoc-ref rgb-colours (string->symbol name))))
         (r (x->number (car cols)))
         (g (x->number (cadr cols)))
         (b (x->number (caddr cols))))
    (colour-rgb r g b)))

(define (colour-256-number number)
  (string-append
    "38;5;"
    (number->string number)))

(define (make-colour-string st code)
  (wrap-with-nothing
    (wrap code)
    st))

(define (colour-dispatch s . rest)
  (if (null? rest)
    s
    (match (car rest)
      ((r g b)
       (make-colour-string s (colour-rgb r g b)))
      ((? string? st)
      (cond
        ((rxmatch->string #/^#?(?:[a-zA-Z0-9]{3}){1,2}$/ st)
         (make-colour-string s (colour-hex st)))
        (else
            (make-colour-string s (colour-rgb-name st)))))
      ((? number? st)
       (make-colour-string s (colour-256-number st)))
      (colour
        (make-colour-string s (colour-symbol colour)))
      ))
  )

(define-macro (paint s . rest)
  `(,colour-dispatch ,s ,@rest))

