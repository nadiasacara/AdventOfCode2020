TYPES: BEGIN OF ty_coord,
         x TYPE i,
         y TYPE i,
       END OF ty_coord.

TYPES: BEGIN OF ty_cardinal_points,
         point      TYPE c LENGTH 1,
         left_point TYPE c LENGTH 1,
       END OF ty_cardinal_points.
types tt_cardinal_points type STANDARD TABLE OF ty_cardinal_points with EMPTY KEY.
