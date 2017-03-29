## (de add-room (Room RoomsLst)
##    (cons Room RoomsLst) )

## (de build-room (Name 

(de enter-room (Name Rooms)
   (let (Room (cadr (assoc Name Rooms)))
      ((cadr (assoc "long-desc-h" Room)) Room)))      

(de init-rooms ()
   (setq Rooms
      '(
        ("building-entrance"
           (("short-desc-h" ((_) (prinl "Threshold")))
            ("long-desc-h"
               ((Room) (prog
                          (prinl "You stand in front of a wooden door, reputed to be the home of one Dr. Theobold. The door has a small \
                                   keyhole.")
                          (if (getval Room "mat-lumpy")
                             (prinl "The welcome mat is slightly lumpy") ) ) ) )
            ("mat-lumpy" T)
            ("visited" NIL) ) )
        )
      )
 )
         
       


