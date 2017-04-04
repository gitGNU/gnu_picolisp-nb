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

(de room-command (Lst Fn)
   (setq Room (aa-insert "room-commands"
                 (aa-insert Lst Fn
                    (cdr (aa-search Room "room-commands")) )
                 Room ) ) )
   
(de get-room (RoomID)
   (cdr (aa-search (rooms) RoomID)) )

(de enter-room (RoomID)
   (location RoomID)
   (prinll (cdr (aa-search (get-room RoomID) "long-description"))) )   

(de read-loop ()
   (loop
      (let (Cmd (str (line T)))
         (let (RoomCmd
               (cdr
                   (aa-search
                      (cdr
                         (aa-search
                            (get-room (location))
                            "room-commands" ) ) Cmd ) ) )
            (if RoomCmd
               (RoomCmd)
               (if (or (= Cmd '("quit")) (= Cmd '("bye")))
                  (prog (prinll "Goodbye!") (quit))
                  (prinll "Nothing happens") ) ) ) ) ))

(de set-world-var (Name Val)
   (setq World (aa-insert "variables"
                  (aa-insert Name Val
                     (aa-search World "variables") ) World ) ) )

(de use-threshold-keypad ()
   (prinll "Enter a five digit code:")
   (let (Input (car (str (line T))))
      (if (or (not (num? Input))
             (< Input 0) (> Input 99999) )
         (prinll "Five digits, please.")
         (if (= Input 31415)
            (prog (prinll "You hear a clicking sound.")
               (set-world-var "threshold-door-unlocked" T))
            (prinll "You input the code but nothing happens.") ) ) ) )

(de init-world ()
   (world
      (location "threshold")
      (room "threshold"
         (room-long-description "You are standing at the entrance to a \
                                 building, reputed to be the home of one \
                                 Dr. Theobold. The entrance is barred by \
                                 a steel door. There is a five digit \
                                 numeric keypad on the door. A rubber \
                                 mat lines the threshold.")
         (room-command '("search" "mat")
            '(() (prinll "You found a small note. It is a picture of a \
                          cherry pie." ) ) )
         (room-command '("use" "keypad") 'use-threshold-keypad)
         ) ) )



