

(use gauche.test)
(use pieni.mini)
(load "maali/core")
(import maali.core)

(test-module 'maali.core)

(test-start "maali.core")

(define-test test-paint-no-argument
             (is (equal? "J-_-L" (paint "J-_-L"))))

(define-test test-paint-one-argument
             (is (equal? "[33mJ-_-L[0m" (paint "J-_-L" 'yellow)))
             (is (equal? "[38;5;220mJ-_-L[0m" (paint "J-_-L" '(255 200 0))))
             (is (equal? "[38;5;24mJ-_-L[0m" (paint "J-_-L" "#123456")))
             (is (equal? "[38;5;24mJ-_-L[0m" (paint "J-_-L" "123456")))
             (is (equal? "[38;5;255mJ-_-L[0m" (paint "J-_-L" "#fff" )))
             (is (equal? "[38;5;255mJ-_-L[0m" (paint "J-_-L" "fff" )))
             (is (equal? "[38;5;74mJ-_-L[0m" (paint "J-_-L" "#4183C4" )))
             (is (equal? "[38;5;141mJ-_-L[0m" (paint "J-_-L" "MediumPurple")))
             )


(test-end)
