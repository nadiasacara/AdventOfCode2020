CLASS zcl_aoc_ns DEFINITION
  PUBLIC
  ABSTRACT
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES zif_aoc_ns
      ALL METHODS ABSTRACT .

    METHODS constructor
      IMPORTING input TYPE string_table.

  PROTECTED SECTION.
    DATA input TYPE string_table.

  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_aoc_ns IMPLEMENTATION.

  METHOD constructor.
    me->input = input.
  ENDMETHOD.

ENDCLASS.
