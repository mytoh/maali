;;; test.scm

(import (scheme base)
        (scheme write)
        (gauche base)
        (gauche test)
        (maali))

(test-start "maali")

(test-module 'maali) ; モジュールの一貫性チェック

(test-section "test paint noargument")
(test "feature no colour" "J-_-L" (paint "J-_-L"))

(test-section "test paint one argument")
(test "feature colour 1" "[33mJ-_-L[0m" (paint "J-_-L" 'yellow))
(test "feature colour 2" "[38;5;220mJ-_-L[0m" (paint "J-_-L" '(255 200 0)))
(test "feature colour 3" "[38;5;24mJ-_-L[0m" (paint "J-_-L" "#123456"))
(test "feature colour 4" "[38;5;24mJ-_-L[0m" (paint "J-_-L" "123456"))
(test "feature colour 5" "[38;5;255mJ-_-L[0m" (paint "J-_-L" "#fff"))
(test "feature colour 6" "[38;5;255mJ-_-L[0m" (paint "J-_-L" "fff"))
(test "feature colour 7" "[38;5;74mJ-_-L[0m" (paint "J-_-L" "#4183C4"))
(test "feature colour 8" "[38;5;141mJ-_-L[0m" (paint "J-_-L" "MediumPurple"))

(test-section "test unpaint one argument")
(test "feature unpaint" "test" (unpaint (paint "test" 33)))

(test-end :exit-on-failure #t)

;; Local Variables:
;; coding: utf-8
;; indent-tabs-mode: nil
;; End:
