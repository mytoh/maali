
(use gauche.test)
(use pieni.mini)
(load "maali/core")
(import maali.core)

(test-module 'maali.core)

(test-section "with no options")
(test* "doesn't colourize at all" "J-_-L" (paint "J-_-L"))

(test-section "with one colour")

(test* "understands a simple symbol colour and use it as foregroud color"
  "[33mJ-_-L[0m" (paint "J-_-L" 'yellow))

(test* "understands an list as rgb colour definition and use it as foreground colour"
  "[38;5;220mJ-_-L[0m" (paint "J-_-L" '(255 200 0)))

(test* "understands a hex string (with #, 6 digits) as rgb colour definition and use it as foregroud colour"
  "[38;5;24mJ-_-L[0m" (paint "J-_-L" "#123456"))

(test* "understands a hex string (no #, 6 digits) as rgb color definition and use it as foreground color"
  "[38;5;24mJ-_-L[0m" (paint "J-_-L" "123456"))

(test* "understands a hex string (with #, 3 digits) as rgb color definition and use it as foreground color"
 "[38;5;255mJ-_-L[0m" (paint "J-_-L" "#fff" ))

(test* "understands a hex string (no #, 3 digits) as rgb color definition and use it as foreground color"
 "[38;5;255mJ-_-L[0m" (paint "J-_-L" "fff" ))

(test* "understands a hex string (with uppercased letters) as rgb color definition and use it as foreground color"
  "[38;5;74mJ-_-L[0m" (paint "J-_-L" "#4183C4" ))

(test* "understands a non-hex string as rgb color name (rgb.txt) and use it as foreground color"
  "[38;5;141mJ-_-L[0m" (paint "J-_-L" "MediumPurple"))


(test-end)
