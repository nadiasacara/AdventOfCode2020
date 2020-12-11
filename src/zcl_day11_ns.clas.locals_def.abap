TYPES: BEGIN OF ty_coord,
         line TYPE i,
         column   TYPE i,
       END OF ty_coord.
TYPES tt_coord TYPE STANDARD TABLE OF ty_coord WITH EMPTY KEY.

TYPES ty_char TYPE c LENGTH 1.
