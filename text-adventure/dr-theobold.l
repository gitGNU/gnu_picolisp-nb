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
         
       


