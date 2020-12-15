CLASS zcl_day15_ns_main DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_day15_ns_main IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA(day15) = NEW zcl_day15_ns( VALUE string_table( ( |12,20,0,6,1,17,7| ) ) ).
    out->write( day15->zif_aoc_ns~second( ) ).
  ENDMETHOD.

ENDCLASS.
