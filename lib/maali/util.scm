
(define-library (maali util)
    (export
      rgb-txt->list)
  (import
    (scheme base)
    (gauche base)
    (util match)
    (util list)
    (file util)
    (text unicode)
    (srfi 1)
    (srfi 13))

  (begin

    (define (comment? string-line)
      (cond
        ((= (string-length string-line) 0)
         #f)
        ((equal? #\# (~ (string-trim-both (string-trim-both string-line) #\t) 0))
         #t)
        (else #f)))

    (define (empty-line? line)
      (if (string=? "" line)
        #t #f))

    (define (colour-list lst)
      (map
          (lambda (e)
            (let ((colours (string-split (string-trim-both e) #/\s+/)))
              `(,(last colours)
                (,(car colours)
                 ,(cadr colours)
                 ,(caddr colours)))))
        lst))

    (define (rgb-txt->list file)
      (colour-list
       (remove
           (lambda (l)
             (or (comment? l)
               (empty-line? l)))
         (file->string-list file))))

    ))
