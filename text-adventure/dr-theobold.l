## dr-theobold.l - a text-based adventure game
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

(de id (X) X)

(de nil-func () NIL)

(de asscv (Lst Key MissF NilF TrueF)
   (let (Res (assoc Key Lst))
      (if (not Res)
         (MissF)
         (if (not (cadr Res))
            (NilF)
            (TrueF (cadr Res)) ) ) ) )

(de visited? (RoomData)
   (asscv RoomData "visited"
      '(prinl "***Missing `visited' data, please report this bug.***")
      '(nil-func)
      'id) )

(de call-short-desc (RoomData)
   (asscv RoomData "short-desc-h"
      '(prinl "***Missing short description, please report this bug.***")
      '(prinl "***Missing short description, please report this bug.***")
      '((Hook) (Hook RoomData)) ) )

(de call-long-desc (RoomData)
   (asscv RoomData "long-desc-h"
      '(prinl "***Missing long description, please report this bug.***")
      '(prinl "***Missing long description, please report this bug.***")
      '((Hook) (Hook RoomData)) ) )

(de asscv-set (Lst Key Val MissF)
   (let (Elem (assoc Key Lst))
      (if (not Elem)
         (MissF)
         (con Elem (list Val)) ) ) )

(de set-visited (RoomData)
   (asscv-set RoomData "visited" T
      '(prinl "***Missing `visited' data, please report this bug.***") ) )

(de get-room-data (Name)
   (asscv Rooms Name
      '(throw "game-data-error" 'ERR-NO-ROOM-DATA)
      '(throw "game-data-error" 'ERR-NO-ROOM-DATA)
      'id ) )

(de enter-room (Name)
   (let (RoomData (get-room-data Name))
      (if (visited? RoomData)
         (call-short-desc RoomData)
         (prog
            (call-long-desc RoomData)
            (set-visited RoomData) ) ) ) )

   ## (let (Room (cadr (assoc Name Rooms)))
   ##    ((cadr (assoc "long-desc-h" Room)) Room)))      

(de init-rooms ()
   (setq Rooms
      '(
        ("threshold"
           (("short-desc-h" ((_) (prinl "Threshold")))
            ("long-desc-h"
               ((RoomData) (prog
                          (prinl "You stand in front of a wooden door, reputed to be the home of one Dr. Theobold. The door has a small \
                                   keyhole.")
                          (asscv RoomData "mat-lumpy"
                             '(prinl "***Missing game variable `mat-lumpy', please report this bug.***")
                             '(nil-func)
                             '((_) (prinl "The welcome mat is slightly lumpy")) ) ) ) )
            ("mat-lumpy" T)
            ("visited" NIL) ) )
        )
      )
 )
         
       


