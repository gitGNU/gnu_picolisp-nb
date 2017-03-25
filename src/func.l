## func.l - function management functions
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



## (record sym [sym ..]) -> NIL

# Defines getter and (non-destructive) setter functions which act upon
# a list of length equal to the number of symbols passed to
# record. Basically provides a quick and easy data structure.

# The functions assigned to each symbol can be used in two forms, the
# first being the getter and the second being the setter.

# (sym 'lst) -> any
# (sym 'lst 'any) -> lst

# Probably you want to prefix each symbol with a data type name.
(de record X
   (let (@N 1)
      (recur (@N X)
         (unless (not X)
            (def (car X)
               (macro '(@ (let (Lst (next))
                             (if (not (args))
                                (car (nth Lst @N))
                                (place @N Lst (next)) ) ) ) ) )
            (recurse (inc @N) (cdr X)) ) ) ) )
