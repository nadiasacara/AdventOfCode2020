TYPES tt_chartab TYPE TABLE OF c WITH EMPTY KEY.
TYPES char_matrix TYPE TABLE OF tt_chartab WITH EMPTY KEY.
TYPES char_cube TYPE TABLE OF char_matrix WITH EMPTY KEY.

TYPES: BEGIN OF ty_coord,
         x TYPE i,
         y TYPE i,
         z TYPE i,
       END OF ty_coord.
TYPES tt_coord TYPE TABLE OF ty_coord WITH EMPTY KEY.



TYPES char_cube4 TYPE TABLE OF char_cube WITH EMPTY KEY.
TYPES: BEGIN OF ty_coord4,
         x TYPE i,
         y TYPE i,
         z TYPE i,
         w TYPE i,
       END OF ty_coord4.
TYPES tt_coord4 TYPE TABLE OF ty_coord4 WITH EMPTY KEY.
