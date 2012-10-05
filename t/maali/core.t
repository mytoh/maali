
(add-load-path "src")
(use gauche.parameter)
(use test.gasmine)
(use maali.core)

(describe "paint with one argcount"
          (it "should return a simple symbol colour"
              (expect (paint "J-_-L" 'yellow) equal? "[33mJ-_-L[0m"))

          (it "should return an array as rgb color definition and use it as foreground color"
              (expect  (paint "J-_-L" '( 255 200 0 ) ) equal? "[38;5;220mJ-_-L[0m"))

          (it "should return a hex string (with #, 6 digits) as rgb color definition and use it as foreground color"
              (expect (paint "J-_-L" "#123456" ) equal? "[38;5;24mJ-_-L[0m"))


          (it "should return a hex string (no #, 6 digits) as rgb color definition and use it as foreground color"
              (expect (paint "J-_-L" "123456" ) equal? "[38;5;24mJ-_-L[0m"))


          (it "should return a hex string (with #, 3 digits) as rgb color definition and use it as foreground color"
              (expect (paint "J-_-L" "#fff" ) equal? "[38;5;255mJ-_-L[0m"))


          (it "should return a hex string (no #, 3 digits) as rgb color definition and use it as foreground color"
              (expect (paint "J-_-L" "fff" ) equal? "[38;5;255mJ-_-L[0m"))


          (it "should return a hex string (with uppercased letters) as rgb color definition and use it as foreground color"
              (expect (paint "J-_-L" "#4183C4" ) equal? "[38;5;74mJ-_-L[0m"))


          (it "should return a non-hex string as rgb color name (rgb.txt) and use it as foreground color"
              (expect (paint "J-_-L" "MediumPurple") equal? "[38;5;141mJ-_-L[0m"))
          )



(run-suites)


;; vim:filetype=scheme
