TYPES: BEGIN OF ty_coord,
         x TYPE i,
         y TYPE i,
       END OF ty_coord.

TYPES: BEGIN OF ty_cardinal_points,
         right TYPE c LENGTH 1,
         left  TYPE c LENGTH 1,
       END OF ty_cardinal_points.
TYPES tt_cardinal_points TYPE STANDARD TABLE OF ty_cardinal_points WITH EMPTY KEY.
