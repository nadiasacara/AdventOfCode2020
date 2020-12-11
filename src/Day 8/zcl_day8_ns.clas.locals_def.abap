TYPES: BEGIN OF ty_instruction,
         operation TYPE c LENGTH 3,
         argument  TYPE i,
       END OF ty_instruction.
TYPES tt_instruction TYPE STANDARD TABLE OF ty_instruction WITH EMPTY KEY.

TYPES: BEGIN OF ty_accumulator,
         accumulator    TYPE i,
         input_is_valid TYPE abap_bool,
       END OF ty_accumulator.
