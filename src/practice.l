## practice.l - Picolisp solutions to practice programming problems
## Copyright (C) 2017  Christopher Howard

## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.

## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.

## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

(de hello-world () (println "Hello world!"))

(de request-name () (prinln "What is your name?")
   (let (q (read))
      (prinl "Hello " q "!") ) )

(de req-name-2 () (prinln "What is your name?")
   (let (q (read))
      (if (= q "Christopher")
         (prinl "What is your will, Sire?")
         (prinl "Oh, hi " q ".") ) ) )

(de provide-sum () (prinl "Input a positive number:")
   (let (n (read))
      (prinl "The sum of the numbers 1 to " n " equals "
         (sum-range n) ) ) )

(de sum-range (n) (apply '+ (range 1 n)))

(de sum-range-3-5 (n)
   (let ffn '((N) (or (=0 (% N 3)) (=0 (% N 5))))
      (apply '+ (filter 'ffn (range 1 n))) ) )

(de req-positive-num ()
   (prinl "Input a positive number:")
   (read) )

(de ask-sum-or-prod ()
   (let (N (req-positive-num)
         Op (prog (prinl "1: sum or 2: product?")
               (read) ) )
      (prinl "The " (if (== Op 1) "sum " "product ") "of 1 to " N " is "
         (foldl
            (if (== Op 1) '+ '*)
            (if (== Op 1) 0 1)
            (range 1 N) ) ) ) )

(de mult-table (N)
   (for R N
      (prog (for C N
               (prin (align 3 (* C R)) " ") )
         (prin "\n") ) ) )

(de primes (L)
   (if (> L 2) (prinl 3))
   (for N L
      (if (or (=0 (% N 2))
             (for Div (range 2 (sqrt N))
                (T (=0 (% N Div)) T) ) )
         Nil (prinl N) ) ) )

(de req-num-guess (U)
   (prinl "Please guess a number between 1 and " U ":")
   (read) )

(de guessing-game ()
   (let (Try 1 Target (rand 1 10))
      (recur (Try)
         (let Guess (req-num-guess 10)
            (if (< Guess Target) (prog (prinl "Too low") (recurse (+ 1 Try)))
               (if (> Guess Target) (prog (prinl "Too high") (recurse (+ 1 Try)))
                  (prinl "Correct! That took " Try " guesses.") ) ) ) ) ) )

(de leap-year (Y)
   (if (and (=0 (% Y 4))
          (or (=0 (% Y 400)) (not (=0 (% Y 100)))) )
      Y Nil ) )

(de next-leap-years (Cnt)
   (setq Year (inc-to-4 (car (date (date)))))
   (recur (Year Cnt)
      (if (=0 Cnt) Nil
         (if (leap-year Year)
            (prog (prinl Year) (recurse (+ 4 Year) (dec Cnt)))
            (recurse (+ 4 Year) Cnt) ) ) ) )

(de inc-to-4 (N)
   (if (=0 (% N 4)) N (inc-to-4 (inc N))) )

(de sumf ()
   (* 4
      (sum '((K)
             (*/ (if (=0 (% K 2)) -1.0 1.0)
                1.0
                (- (* 2.0 K) 1.0) ) )
         (range 1 1000000) ) ) )

(de foldl (Fn Acc Lst)
   (if (== () Lst) Acc
      (let Acc2 (Fn Acc (car Lst))
         (foldl Fn Acc2 (cdr Lst)) ) ) )

(de greatest (Lst)
   (foldl
      '((A B) (if (> A B) A B))
      (car Lst)
      (cdr Lst) ) )

(de odd-members (Lst)
   (reverse (let (Sw T Acc ())
               (recur (Lst Sw Acc)
                  (if Lst
                     (if Sw
                        (recurse (cdr Lst) Nil (cons (car Lst) Acc))
                        (recurse (cdr Lst) T Acc) )
                     Acc ) ) ) ) )

(de run-total (Lst)
   (reverse
      (let Acc (0)
         (recur (Lst Acc)
            (if (car Lst)
               (recurse (cdr Lst) (cons (+ (car Lst) (car Acc)) Acc))
               Acc ) ) ) ) )

(de mix (L1 L2)
   (if (nor L1 L2) ()
      (if (and L1 (not L2)) (cons (car L1) (mix (cdr L1) L2))
         (if (and (not L1) L2) (cons (car L2) (mix L1 (cdr L2)))
            (cons (car L1) (cons (car L2) (mix (cdr L1) (cdr L2)))) ) ) ) )

(de even (Num) (=0 (% Num 2)))

(de odd (Num) (n0 (% Num 2)))

(de palindrome? (Str)
   (let (Chars (chop Str)
         Half (/ (length Chars) 2)
         H (head Half Chars)
         T (tail Half Chars) )
      (= H (reverse T)) ) )

(de fib (Cnt)
   (cons 0
      (cons 1
         (let (A 0 B 1)
            (recur (Cnt A B)
               (if (=0 Cnt) ()
                  (let Sum (+ A B)
                     (cons Sum (recurse (dec Cnt) B Sum)) ) ) ) ) ) ) )

(cadr (1 2 3))

(de count-out (N)
   (let (bar '((X)
               (if (< X 1) (prinl "DONE!")
                  (prog (prinl X) (bar (dec X))) ) ) )
      (bar N) ) )

(de my-age (birth-y birth-m birth-d)
   (let (today-date (date (date))
         today-y (car today-date)
         today-m (cadr today-date)
         today-d (caddr today-date) )
      (- (- today-y birth-y)
         (if (or (> today-m birth-m)
                (and (== today-m birth-m) (>= today-d birth-d)) ) 0 1 ) ) ) )

(de vowel? (C) (car (member C '("a", "e", "i", "o", "u"))))

(de pig-latinize-word (Sym)
   (let (InLst (chop Sym)
         OutLst (if (vowel? (car InLst))
                   (append InLst '("w" "a" "y"))
                   (recur (InLst)
                      (if (vowel? (car InLst))
                         (append InLst '("a" "y"))
                         (recurse (append (cdr InLst) (list (car InLst)))) ) ) ) )
      (glue NIL OutLst) ) )

(de greatest-base-digit (B Int)
  (let (rec '((D)
              (if (> (** B D) Int) (- D 1)
                 (rec (+ 1 D)) ) ) )
     (rec 1) ) )

(de int-to-base-list (B Int)
  (let (rec '((D Int)
              (if (< D 0) ()
                 (let (Div (** B D)
                       Quo (/ Int Div))
                    (cons Quo (rec (- D 1) (- Int (* Div Quo)))) ) ) ) )
     (rec (greatest-base-digit B Int) Int) ) )

(de pad-list (PadElem DesiredLen Lst)
   (let (L (length Lst)
         NL Lst)
      (while (< L DesiredLen)
         (setq NL (cons PadElem NL))
         (inc 'L) )
      NL ) )

# Buggy!
(de permutations (KindLst SlotCnt)
   (let (KCount (length KindLst)
         PCount (** KCount SlotCnt)
         Acc () )
      (for N PCount
         (let (CurrBaseLst (reverse (int-to-base-list KCount (- N 1)))
               NewPerm (mapcar '((BElem)
                                 (car (nth KindLst (inc BElem))) )
                          CurrBaseLst ) )
            (setq Acc
               (cons
                  (reverse
                     (pad-list (car KindLst) SlotCnt (reverse NewPerm)))
                  Acc ) ) )
         (reverse Acc) ) ) )

(de to-morse (Letters)
   (let

      (TableFn
       '((C) (case (uppc C)
                (" " " ")
                ("A" ".- ")
                ("B" "-... ")
                ("C" "-.-. ")
                ("D" "-.. ")
                ("E" ". ")
                ("F" "..-. ")
                ("G" "--. ")
                ("H" ".... ")
                ("I" ".. ")
                ("J" ".--- ")
                ("K" "-.- ")
                ("L" ".-.. ")
                ("M" "-- ")
                ("N" "-. ")
                ("O" "--- ")
                ("P" ".--. ")
                ("Q" "--.- ")
                ("R" ".-. ")
                ("S" "... ")
                ("T" "- ")
                ("U" "..- ")
                ("V" "...- ")
                ("W" ".-- ")
                ("X" "-..- ")
                ("Y" "-.-- ")
                ("Z" "--.. ")
                ("0" "----- ")
                ("1" ".---- ")
                ("2" "..--- ")
                ("3" "...-- ")
                ("4" "....- ")
                ("5" "..... ")
                ("6" "-.... ")
                ("7" "--... ")
                ("8" "---.. ")
                ("9" "----. ")
                ("Ä" ".-.-")
                ("Á" ".--.-")
                ("Å" ".--.-")
                ("Ch" ----)
                ("É" "..-..")
                ("Ñ" "--.--")
                ("Ö" "---.")
                ("Ü" "..--")
                ("." ".-.-.-")
                ("," "--..--")
                (":" "---...")
                ("?" "..--..")
                ("'" ".----.")
                ("-" "-....-")
                ("/" "-..-.")
                ("()" "-.--.-")
                ("\"" ".-..-.")
                ("@" ".--.-.")
                ("=" "-...-")
                ) ) )
      (pack (mapcar 'TableFn (chop Letters))) ) )

# Destructive
(de selection-sort-by (LteFn Lst)
   (let (Mark1 Lst)
      (recur (Mark1)
         (if (not Mark1) NIL
            (prog (let (Mark2 (cdr Mark1))
                     (recur (Mark2)
                        (if (not Mark2) NIL
                           (if (LteFn Mark2 Mark1)
                              (let (Interm (car Mark1))
                                 (prog
                                    (set Mark1 (car Mark2))
                                    (set Mark2 Interm)
                                    (recurse (cdr Mark2)) ) )
                              (recurse (cdr Mark2)) ) ) ) )
               (recurse (cdr Mark1)) ) ) ) ) )

# Destructive
(de selection-sort (Lst)
   (selection-sort-by '<= Lst) )

