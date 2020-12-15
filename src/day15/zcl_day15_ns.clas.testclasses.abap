CLASS ltcl_day15 DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA cut TYPE REF TO zif_aoc_ns.
    METHODS first_1st_input FOR TESTING.
    METHODS first_2nd_input FOR TESTING.
    METHODS first_3rd_input FOR TESTING.
    METHODS first_4th_input FOR TESTING.
    METHODS first_5th_input FOR TESTING.
    METHODS first_6th_input FOR TESTING.
    METHODS first_7th_input FOR TESTING.
    METHODS first_my_input FOR TESTING.

    METHODS second_1st_input FOR TESTING.
    METHODS second_2nd_input FOR TESTING.

ENDCLASS.


CLASS ltcl_day15 IMPLEMENTATION.

  METHOD first_1st_input.
    DATA(input) = VALUE string_table( ( |0,3,6| ) ).
    cut = NEW zcl_day15_ns( input ).
    cl_abap_unit_assert=>assert_equals( exp = 436 act = cut->first( ) ).
  ENDMETHOD.

  METHOD first_2nd_input.
    DATA(input) = VALUE string_table( ( |1,3,2| ) ).
    cut = NEW zcl_day15_ns( input ).
    cl_abap_unit_assert=>assert_equals( exp = 1 act = cut->first( ) ).
  ENDMETHOD.

  METHOD first_3rd_input.
    DATA(input) = VALUE string_table( ( |2,1,3| ) ).
    cut = NEW zcl_day15_ns( input ).
    cl_abap_unit_assert=>assert_equals( exp = 10 act = cut->first( ) ).
  ENDMETHOD.

  METHOD first_4th_input.
    DATA(input) = VALUE string_table( ( |1,2,3| ) ).
    cut = NEW zcl_day15_ns( input ).
    cl_abap_unit_assert=>assert_equals( exp = 27 act = cut->first( ) ).
  ENDMETHOD.

  METHOD first_5th_input.
    DATA(input) = VALUE string_table( ( |2,3,1| ) ).
    cut = NEW zcl_day15_ns( input ).
    cl_abap_unit_assert=>assert_equals( exp = 78 act = cut->first( ) ).
  ENDMETHOD.

  METHOD first_6th_input.
    DATA(input) = VALUE string_table( ( |3,2,1| ) ).
    cut = NEW zcl_day15_ns( input ).
    cl_abap_unit_assert=>assert_equals( exp = 438 act = cut->first( ) ).
  ENDMETHOD.

  METHOD first_7th_input.
    DATA(input) = VALUE string_table( ( |3,1,2| ) ).
    cut = NEW zcl_day15_ns( input ).
    cl_abap_unit_assert=>assert_equals( exp = 1836 act = cut->first( ) ).
  ENDMETHOD.

  METHOD first_my_input.
    DATA(input) = VALUE string_table( ( |12,20,0,6,1,17,7| ) ).
    cut = NEW zcl_day15_ns( input ).
    cl_abap_unit_assert=>assert_equals( exp = 866 act = cut->first( ) ).
  ENDMETHOD.

  METHOD second_1st_input.
    DATA(input) = VALUE string_table( ( |0,3,6| ) ).
    cut = NEW zcl_day15_ns( input ).
    cl_abap_unit_assert=>assert_equals( exp = 175594 act = cut->second( ) ).
  ENDMETHOD.

  METHOD second_2nd_input.
    DATA(input) = VALUE string_table( ( |1,3,2| ) ).
    cut = NEW zcl_day15_ns( input ).
    cl_abap_unit_assert=>assert_equals( exp = 2578 act = cut->second( ) ).
  ENDMETHOD.

ENDCLASS.
