CLASS ltcl_day17 DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA cut TYPE REF TO zif_aoc_ns.

    METHODS first_1st_input FOR TESTING RAISING cx_static_check.
    METHODS first_my_input FOR TESTING.

    METHODS second_1st_input FOR TESTING.
    METHODS second_2nd_input FOR TESTING.
ENDCLASS.


CLASS ltcl_day17 IMPLEMENTATION.

  METHOD first_1st_input.
    DATA(input) = VALUE string_table(
        ( |.#.| )
        ( |..#| )
        ( |###| )
    ).
    cut = NEW zcl_day17_ns2_multidim_input( input ).
    cl_abap_unit_assert=>assert_equals( exp = 112 act = cut->first( ) ).
  ENDMETHOD.

  METHOD first_my_input.
    DATA(input) = VALUE string_table(
        ( |....#...| )
        ( |.#..###.| )
        ( |.#.#.###| )
        ( |.#....#.| )
        ( |...#.#.#| )
        ( |#.......| )
        ( |##....#.| )
        ( |.##..#.#| )
    ).
    cut = NEW zcl_day17_ns2_multidim_input( input ).
    cl_abap_unit_assert=>assert_equals( exp = 301 act = cut->first( ) ).
  ENDMETHOD.

  METHOD second_1st_input.
    DATA(input) = VALUE string_table(
        ( |.#.| )
        ( |..#| )
        ( |###| )
    ).
    cut = NEW zcl_day17_ns2_multidim_input( input ).
    cl_abap_unit_assert=>assert_equals( exp = 848 act = cut->second( ) ).
  ENDMETHOD.

  METHOD second_2nd_input.
    DATA(input) = VALUE string_table(
        ( |....#...| )
        ( |.#..###.| )
        ( |.#.#.###| )
        ( |.#....#.| )
        ( |...#.#.#| )
        ( |#.......| )
        ( |##....#.| )
        ( |.##..#.#| )
    ).
    cut = NEW zcl_day17_ns2_multidim_input( input ).
    cl_abap_unit_assert=>assert_equals( exp = 2424 act = cut->second( ) ).
  ENDMETHOD.

ENDCLASS.
