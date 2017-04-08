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
      (aa-search-val World "location")
      (setq World (aa-insert "location" (next) World)) ) )

(de rooms ()
   (aa-search-val World "rooms") )

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
                    (aa-search-val Room "room-commands") )
                 Room ) ) )
   
(de room-exit (Direction Fn)
   (setq Room (aa-insert "room-exits"
                 (aa-insert Direction Fn
                    (aa-search-val Room "room-exits") )
                 Room ) ) )

(de get-room (RoomID)
   (aa-search-val (rooms) RoomID) )

(de print-exits (RoomID)
   (let (Exit-Str
         (glue ", "
            (aa-keys-to-list
               (aa-search-val
                  (get-room RoomID) "room-exits" ) ) ) )
      (when Exit-Str
         (prinll "Exits: " Exit-Str))))

(de look-at-room (RoomID)
   (prinll (aa-search-val (get-room RoomID) "long-description"))
   (print-exits RoomID))

(de enter-room (RoomID)
   (location RoomID)
   (look-at-room RoomID) )

(de c-loop X
   (let (continue '(() (throw 'CONTINUE NIL))
         break '(() (throw 'BREAK NIL)))
      (catch 'BREAK
         (loop
            (catch 'CONTINUE
               (run X) ) ) ) ) )

(de print-help ()
   (prinll "Common commands are...\n\n"
      "look, go <exit>, search <item>, use <item>, quit" ) )

(de print-warranty ()
   (prinll
      "This program is distributed in the hope that it will be useful,\n"
      "but WITHOUT ANY WARRANTY; without even the implied warranty of\n"
      "MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the\n"
      "GNU General Public License for more details." ) )

(de print-license ()
   (prinll
      "This program is free software: you can redistribute it and/or modify\n"
      "it under the terms of the GNU General Public License as published by\n"
      "the Free Software Foundation, either version 3 of the License, or\n"
      "(at your option) any later version.\n\n"
      "You should have received a copy of the GNU General Public License\n"
      "along with this program.  If not, see <http://www.gnu.org/licenses/>."))

(de read-loop ()
   (c-loop
      (prin "> ")
      (flush)
      (let (Cmd (str (line T)))
         (prinl "")

         (when (= Cmd '("help"))
            (prog (print-help) (continue)))

         (when (= Cmd '("warranty"))
            (prog (print-warranty) (continue)))
         
         (when (= Cmd '("license"))
            (prog (print-license) (continue)))
         
         (when (= Cmd '("look"))
            (prog (look-at-room (location)) (continue)) )
         
         (when (or (= Cmd '("quit")) (= Cmd '("bye")))
            (prog (prinll "Goodbye!") (bye)) )
         
         (let (RoomCmd
               (aa-search-val
                  (aa-search-val
                     (get-room (location))
                     "room-commands" ) Cmd ) )
            (when RoomCmd
               (prog (RoomCmd) (continue)) ) )
         
         (if (= (car Cmd) "go")
            (let (ExitCmd
                  (aa-search-val
                     (aa-search-val
                        (get-room (location))
                        "room-exits" ) (cadr Cmd) ) )
               (if ExitCmd
                  (prog (ExitCmd) (continue))
                  (prog (prinll "Nothing happens") (continue)) ) ) )
         
         (prinll "Nothing happens") ) ) )

(de set-world-var (Name Val)
   (setq World (aa-insert "variables"
                  (aa-insert Name Val
                     (aa-search-val World "variables") ) World ) ) )

(de read-world-var (Name)
   (aa-search-val (aa-search-val World "variables") Name) )

(de use-threshold-keypad ()
   (prin "Enter a five digit code: ") (flush)
   (let (Input (car (str (line T))))
      (if (or (not (num? Input))
             (< Input 0) (> Input 99999) )
         (prinll "Five digits, please.")
         (if (= Input 31415)
            (prog (prinll "\nYou hear a clicking sound.")
               (set-world-var "threshold-door-unlocked" T))
            (prinll "\nYou input the code but nothing happens.") ) ) ) )

(de letter? (C) (and (str? C)
                   (or (and (>= C "A") (<= C "Z"))
                      (and (>= C "a") (<= C "z")) ) ) )

(de cryptogram-encrypt (Message SubsTree)
   (let (SubFn
         '((C) (if (not (letter? C))
                  C
                  (let (UC (uppc C))
                     (if (aa-search-val SubsTree UC)
                        @
                        "_" ) ) ) ) )
      (glue "" (mapcar 'SubFn (chop Message))) ) )

(de space-out (Str)
   (glue " " (chop Str)) )

(de use-crypto-tablet ()
   (prinll "The tablet displays a cryptogram:")
   ## (c-loop
   ##    (let (Subst (read-world-var "crypto-tablet-substitutions"))
   ##       )
   ##    (prinll 
 )

(de start-game ()
   (prinll "\n" "Dr. Theobold: A Text Adventure Game" "\n"
      "Copyright (C) 2017 Christopher Howard" "\n"
      "This program comes with ABSOLUTELY NO WARRANTY; for details type `warranty'." "\n"
      "This is free software, and you are welcome to redistribute it \
       under certain conditions; type `license' for details.")
   (print-help)
   (init-world)
   (enter-room "threshold")
   (read-loop) )

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
         (room-exit "north" '(() (if (read-world-var "threshold-door-unlocked")
                                    (enter-room "atrium")
                                    (prinll "The door is locked") ) ) ) )
      (room "atrium"
         (room-long-description "You are in a large atrium. The walls are \
                                 covered in ornate carvings. The room is \
                                 mostly open and empty except a few chairs \
                                 and couches in the middle, centered \
                                 around a small table. A small computer \
                                 tablet is laying on the table.")
         (room-exit "south" '(() (enter-room "threshold")))
         (room-command '("use" "tablet") (use-crypto-tablet))
         )
      ) )
