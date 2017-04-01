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

(load "tree.l")

(de prinll @ (prog
                (apply 'prinl (rest))
                (prinl)))

(de world ARGLST
   (setq World (aa-insert "rooms" NIL NIL))
   (run ARGLST)
   World )

(de location @
   (if (not (arg 1))
      (cdr (aa-search World "location"))
      (setq World (aa-insert "location" (next) World)) ) )

(de rooms ()
   (cdr (aa-search World "rooms")) )

(de room ARGLST
   (if (not (car ARGLST))
      (quit "func `room' missing argument")
      (let (Room ())
         (run (cdr ARGLST))
         (setq World
            (aa-insert
               "rooms"
               (aa-insert (car ARGLST) Room (rooms)) World ) ) ) ) )

(de room-long-description (Description)
   (setq Room (aa-insert "long-description" Description Room)) )

(de get-room (RoomID)
   (cdr (aa-search (rooms) RoomID)) )

(de enter-room (RoomID)
   (location RoomID)
   (prinll (cdr (aa-search (get-room RoomID) "long-description"))) )

(de init-world ()
   (world
      (location "threshold")
      (room "threshold"
         (room-long-description "You stand in front of a wooden door, \
                                 reputed to be the home of one Dr. \
                                 Theobold. The door has a small keyhole."))
 ) )

