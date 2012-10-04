
(use gauche.test)
(load "maali/core")
(import maali.core)

(test-module 'maali.core)

(test-section "paint , ansi colours")

(test* "should return black string" "[30mtest[0m" (paint "test" 'black))
(test* "should return red string" "[31mtest[0m" (paint "test" 'red))
(test* "should return green string" "[32mtest[0m" (paint "test" 'green))
(test* "should return yellow string" "[33mtest[0m" (paint "test" 'yellow))
(test* "should return blue string" "[34mtest[0m" (paint "test" 'blue))
(test* "should return magenta string" "[35mtest[0m" (paint "test" 'magenta))
(test* "should return cyan string" "[36mtest[0m" (paint "test" 'cyan))
(test* "should return white string" "[37mtest[0m" (paint "test" 'white))




(test-end)
