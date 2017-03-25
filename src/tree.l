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

(load "func.l")

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

(record aa-kv aa-left aa-right aa-level)

(de aa-search (Tree Key)
   (unless (not Tree)
      (if (== Key (car (aa-kv Tree)))
         (aa-kv Tree)
         (if (< Key (car (aa-kv Tree)))
            (aa-search (aa-left Tree) Key)
            (aa-search (aa-right Tree) Key) ) ) ) )

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
   (unless (not Tree)
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

## (de aa-delete (Tree Key)
##    (unless Tree
##       (if (> Key (car (aa-kv Tree)))
##          (list (aa-kv Tree) (aa-left Tree) (aa-delete (aa-right Tree Key)) (aa-level Tree))
##          (if (< Key (car (aa-kv Tree)))
##             (list (aa-kv Tree) (aa-delete (aa-left Tree Key)) (aa-right Tree) (aa-level Tree))
##             (unless (not (or (aa-left Tree) (aa-right Tree)))
##                (if (not (aa-left Tree))
##                   (let (L (successor Tree))
##                      (list (aa-kv L) (aa-left Tree) (delete (aa-right Tree) (car (aa-kv L))) (aa-value L)) )
##                   (let (L (predecessor Tree))
##                      (list (aa-kv L) (delete (aa-left Tree) (car (aa-kv L))) (aa-right Tree) (aa-value L)) ) ) ) ) )
##       (let (Tree2 (skew (decrease-level Tree))
##             Tree3 
##  )
         
      
                  
