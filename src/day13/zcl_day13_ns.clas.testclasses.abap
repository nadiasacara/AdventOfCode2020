CLASS ltcl_day13 DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA cut TYPE REF TO zif_aoc_ns.
    METHODS first_1st_input FOR TESTING.
    METHODS first_my_input  FOR TESTING.

    METHODS second_1st_input FOR TESTING.
    METHODS second_2nd_input FOR TESTING.
    METHODS second_3rd_input FOR TESTING.
    METHODS second_4th_input FOR TESTING.
    METHODS second_5th_input FOR TESTING.
    METHODS second_6th_input FOR TESTING.
    METHODS second_my_input  FOR TESTING.
ENDCLASS.


CLASS ltcl_day13 IMPLEMENTATION.

  METHOD first_1st_input.
    DATA(input) = VALUE string_table(
        ( |939| )
        ( |7,13,x,x,59,x,31,19| )
    ).
    cut = NEW zcl_day13_ns( input ).
    cl_abap_unit_assert=>assert_equals( exp = 295 act = cut->first( ) ).
  ENDMETHOD.

  METHOD first_my_input.
    DATA(input) = VALUE string_table(
        ( |1000434| )
        ( |17,x,x,x,x,x,x,41,x,x,x,x,x,x,x,x,x,983,x,29,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,19,x,x,x,23,x,x,x,x,x,x,x,397,x,x,x,x,x,37,x,x,x,x,x,x,13| )
    ).
    cut = NEW zcl_day13_ns( input ).
*    cl_abap_unit_assert=>assert_equals( exp = ... act = cut->first( ) ).
  ENDMETHOD.

  METHOD second_1st_input.
    DATA(input) = VALUE string_table(
        ( || )
        ( |7,13,x,x,59,x,31,19| )
    ).
    cut = NEW zcl_day13_ns( input ).
    cl_abap_unit_assert=>assert_equals( exp = 1068781 act = cut->second( ) ).
  ENDMETHOD.

  METHOD second_2nd_input.
    DATA(input) = VALUE string_table(
        ( || )
        ( |17,x,13,19| )
    ).
    cut = NEW zcl_day13_ns( input = input ).
    cl_abap_unit_assert=>assert_equals( exp = 3417 act = cut->second( ) ).
  ENDMETHOD.

  METHOD second_3rd_input.
    DATA(input) = VALUE string_table(
        ( || )
        ( |67,7,59,61| )
    ).
    cut = NEW zcl_day13_ns( input ).
    cl_abap_unit_assert=>assert_equals( exp = 754018 act = cut->second( ) ).
  ENDMETHOD.

  METHOD second_4th_input.
    DATA(input) = VALUE string_table(
            ( || )
            ( |67,x,7,59,61| )
        ).
    cut = NEW zcl_day13_ns( input ).
    cl_abap_unit_assert=>assert_equals( exp = 779210 act = cut->second( ) ).
  ENDMETHOD.

  METHOD second_5th_input.
    DATA(input) = VALUE string_table(
            ( || )
            ( |67,7,x,59,61| )
        ).
    cut = NEW zcl_day13_ns( input ).
    cl_abap_unit_assert=>assert_equals( exp = 1261476 act = cut->second( ) ).
  ENDMETHOD.

  METHOD second_6th_input.
    DATA(input) = VALUE string_table(
            ( || )
            ( |1789,37,47,1889| )
        ).
    cut = NEW zcl_day13_ns( input ).
    cl_abap_unit_assert=>assert_equals( exp = 1202161486 act = cut->second( ) ).
  ENDMETHOD.

  METHOD second_my_input.
    DATA(input) = VALUE string_table(
        ( || )
        ( |17,x,x,x,x,x,x,41,x,x,x,x,x,x,x,x,x,983,x,29,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,19,x,x,x,23,x,x,x,x,x,x,x,397,x,x,x,x,x,37,x,x,x,x,x,x,13| )
    ).
    cut = NEW zcl_day13_ns( input = input start_t = 100000000000000 ).
*    cl_abap_unit_assert=>assert_equals( exp = ... act = cut->second( ) ).
  ENDMETHOD.

ENDCLASS.
