# Non-destructive
(de merge-sort-by (LteFn Lst)
   (let (merge '((Left Right Res)
                 (if (and Left Right)
                    (if (LteFn (car Left) (car Right))
                       (merge (cdr Left) Right (cons (car Left) Res))
                       (merge Left (cdr Right) (cons (car Right) Res)) )
                    (if Left
                       (merge (cdr Left) Right (cons (car Left) Res))
                       (if Right
                          (merge Left (cdr Right) (cons (car Right) Res))
                          (reverse Res) ) ) ) )
         Len (length Lst)
         Half-Len (/ Len 2) )
      (if (<= Len 1) Lst
         (merge
            (merge-sort-by LteFn (head Half-Len Lst))
            (merge-sort-by LteFn (tail (- Len Half-Len) Lst)) ) ) ) )

# Non-destructive
(de merge-sort (Lst)
   (merge-sort-by '<= Lst) )
