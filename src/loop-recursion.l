(de zip-set (L1 L2)
   (while (and L1 L2)
      (set (car L1) (car L2))
      (setq L1 (cdr L1))
      (setq L2 (cdr L2)) ) )

(de tc-recursion X
   (let (tc
      (list '@
         (list 'prog
            (list 'zip-set (list 'car (list 'quote (car X))) '(rest))
            '(setq CONTXXXX T)
            '(throw 'TCXXXXXX) ) ) )
      (prog
         (setq CONTXXXX T)
         (while CONTXXXX
            (setq CONTXXXX NIL)
            (catch 'TCXXXXXX
               (run (cdr X)) ) ) ) ) )

(de tc-test ()
   (setq A 1)
   (tc-recursion (A)
      (prinl A)
      (if (>= A 10) A
         (tc (+ A 1)) ) ) )

(de tc-test2 ()
   (setq A 1)
   (tc-recursion (A)
      (if (>= A 1000000000) A
         (tc (+ A 1)) ) ) )
