## tree.l - Tree data type implementations
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

(de bst-new (Key Val)
   (list Key Val NIL NIL) )

(de bst-insert (Tree Key Val)
   (if (== (car Tree) Key) (set (cdr Tree) Val)
      (if (< Key (car Tree))
         (if (not (caddr Tree))
            (set (cddr Tree) (bst-new Key Val))
            (bst-insert (caddr Tree) Key Val) )
         (if (not (cadddr Tree))
            (set (cdddr Tree) (bst-new Key Val))
            (bst-insert (cadddr Tree) Key Val) ) ) )
   Tree )

(de bst-search (Tree Key)
   (if (not Tree)
      NIL
      (if (== Key (car Tree))
         (list (car Tree) (cadr Tree))
         (if (< Key (car Tree))
            (bst-search (caddr Tree) Key)
            (bst-search (cadddr Tree) Key) ) ) ) )

# AANode = ((Key Val) LeftT RightT Level)

(de record X
   (let (N 1)
      (recur (N X)
         (unless (not X)
            (eval (list 'de (car X) '(Lst) (list 'car (list 'nth 'Lst N))))
            (recurse (inc N) (cdr X)) ) ) ) )

(record aa-kv aa-left aa-right aa-level)

(de aa-unwrap X
   (let (KV (car (car X))
         Left (cadr (car X))
         Right (caddr (car X))
         Level (cadddr (car X)) )
      (run (cdr X)) ) )

(de aa-skew (Tree)
   (unless (not Tree)
      (if (not (aa-left Tree))
         Tree
         (if (== (aa-level (aa-left Tree)) (aa-level Tree))
            (list (aa-kv (aa-left Tree))
               (aa-left (aa-left Tree))
               (list (aa-kv Tree) (aa-right (aa-left Tree)) (aa-right Tree) (aa-level Tree))
               (aa-level (aa-left Tree)) )
            Tree ) ) ) )

(de aa-split (Tree)
   (unless Tree
      (if (not (and (aa-right Tree) (aa-right (aa-right Tree))))
         Tree
         (if (== (aa-level Tree) (aa-level (aa-right (aa-right Tree))))
            (list (aa-kv (aa-right Tree))
               (list (aa-kv Tree) (aa-left Tree) (aa-left (aa-right Tree)) (aa-level Tree))
               (aa-right Tree)
               (inc (aa-level (aa-right Tree))) )
            Tree ) ) ) )


(de aa-insert (Key Val Tree)

   # Empty tree
   (if (not Tree)
      (list (list Key Val) NIL NIL 1)

      (aa-split
         (aa-skew
            (if (== Key (car (aa-kv Tree)))
               (list (list Key Val) (aa-left Tree) (aa-right Tree) (aa-level Tree))
               (if (< Key (car (aa-kv Tree)))
                  (list (aa-kv Tree) (aa-insert Key Val (aa-left Tree)) (aa-right Tree) (aa-level Tree))
                  (list (aa-kv Tree) (aa-left Tree) (aa-insert Key Val (aa-right Tree)) (aa-level Tree)) ) ) ) ) ) )

## (de t23-new (Key Val)
##    (list (list Key Val) NIL NIL NIL NIL) )

## (de t23-unwrap-node X
##    (let (left-kv (car (car X))
##          right-kv (car (nth (car X) 2))
##          left-node (car (nth (car X) 3))
##          middle-node (car (nth (car X) 4))
##          right-node (car (nth (car X) 5)) )
##       (run (cdr X)) ) )

## (de t23-insert (Node Key Val)
##    (t23-unwrap-node Node

##       # Leaf
##       (if (not left-node)

##          # Single key node
##          (if (not right-kv)

##             # Key matches, replace
##             (if (== (car left-kv) Key)
##                (list (list Key Val) NIL NIL NIL NIL)
               
##                # Key doesn't match, place in one of the key slots
##                (if (< (car left-kv) Key)
##                   (list left-kv (list Key Val) NIL NIL NIL)
##                   (list (list Key Val) left-kv NIL NIL NIL) ) )
            
##             # Two Key Node
            
##             # Key matches left, replace
##             (if (== (car left-kv) Key)
##                (list (list Key Val) right-kv left-node middle-node right-node)
               
##                # Key matches right, replace
##                (if (== (car right-kv) Key)
##                   (list left-kv (list Key Val) left-node middle-node right-node)
