TYPES: BEGIN OF ty_operation,
         position TYPE int8,
         value    TYPE int8,
       END OF ty_operation.
TYPES tt_operation TYPE STANDARD TABLE OF ty_operation WITH EMPTY KEY.

TYPES: BEGIN OF ty_memory_sorted,
         position TYPE int8,
         value    TYPE int8,
       END OF ty_memory_sorted.
TYPES tt_memory_sorted TYPE SORTED TABLE OF ty_memory_sorted WITH UNIQUE KEY position.

TYPES tt_char TYPE STANDARD TABLE OF c WITH EMPTY KEY.

TYPES: BEGIN OF ty_program,
         mask       TYPE tt_char,
         operations TYPE tt_operation,
       END OF ty_program.
TYPES tt_program TYPE STANDARD TABLE OF ty_program WITH EMPTY KEY.

TYPES tt_int TYPE STANDARD TABLE OF int8 WITH EMPTY KEY.
TYPES tt_binary_adrs TYPE STANDARD TABLE OF tt_int WITH EMPTY KEY.
