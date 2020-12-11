CLASS ltcl_day10 DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA cut TYPE REF TO zif_aoc_ns.
    METHODS first_1st_input FOR TESTING.
    METHODS first_2nd_input FOR TESTING.
    METHODS first_my_input FOR TESTING.

    METHODS second_1st_input FOR TESTING.
    METHODS second_2nd_input FOR TESTING.
    METHODS second_my_input FOR TESTING.

    METHODS get_my_input
      RETURNING VALUE(result) TYPE string_table.
ENDCLASS.


CLASS ltcl_day10 IMPLEMENTATION.

  METHOD first_1st_input.
    DATA(input) = VALUE string_table( ( |16| ) ( |10| ) ( |15| ) ( |5| ) ( |1| ) ( |11| ) ( |7| ) ( |19| ) ( |6| ) ( |12| ) ( |4| ) ).
    cut = NEW zcl_day10_ns( input ).
    cl_abap_unit_assert=>assert_equals( exp = 35 act = cut->first( ) ).
  ENDMETHOD.

  METHOD first_2nd_input.
    DATA(input) = VALUE string_table( ( |28| ) ( |33| ) ( |18| ) ( |42| ) ( |31| ) ( |14| ) ( |46| ) ( |20| ) ( |48| )
        ( |47| ) ( |24| ) ( |23| ) ( |49| ) ( |45| ) ( |19| ) ( |38| ) ( |39| ) ( |11| ) ( |1| ) ( |32| ) ( |25| ) ( |35| )
        ( |8| ) ( |17| ) ( |7| ) ( |9| ) ( |4| ) ( |2| ) ( |34| ) ( |10| ) ( |3| ) ).
    cut = NEW zcl_day10_ns( input ).
    cl_abap_unit_assert=>assert_equals( exp = 220 act = cut->first( ) ).
  ENDMETHOD.

  METHOD first_my_input.
    cut = NEW zcl_day10_ns( get_my_input( ) ).
*    cl_abap_unit_assert=>assert_equals( exp = ... act = cut->first( ) ).
  ENDMETHOD.

  METHOD second_1st_input.
    DATA(input) = VALUE string_table( ( |16| ) ( |10| ) ( |15| ) ( |5| ) ( |1| ) ( |11| ) ( |7| ) ( |19| ) ( |6| ) ( |12| ) ( |4| ) ).
    cut = NEW zcl_day10_ns( input ).
    cl_abap_unit_assert=>assert_equals( exp = 8 act = cut->second( ) ).
  ENDMETHOD.

  METHOD second_2nd_input.
    DATA(input) = VALUE string_table( ( |28| ) ( |33| ) ( |18| ) ( |42| ) ( |31| ) ( |14| ) ( |46| ) ( |20| ) ( |48| )
        ( |47| ) ( |24| ) ( |23| ) ( |49| ) ( |45| ) ( |19| ) ( |38| ) ( |39| ) ( |11| ) ( |1| ) ( |32| ) ( |25| ) ( |35| )
        ( |8| ) ( |17| ) ( |7| ) ( |9| ) ( |4| ) ( |2| ) ( |34| ) ( |10| ) ( |3| ) ).
    cut = NEW zcl_day10_ns( input ).
    cl_abap_unit_assert=>assert_equals( exp = 19208 act = cut->second( ) ).
  ENDMETHOD.

  METHOD second_my_input.
    cut = NEW zcl_day10_ns( get_my_input( ) ).
*    cl_abap_unit_assert=>assert_equals( exp = ... act = cut->second( ) ).
  ENDMETHOD.

  METHOD get_my_input.
    result = VALUE #(
        ( |77| )
        ( |10| )
        ( |143| )
        ( |46| )
        ( |79| )
        ( |97| )
        ( |54| )
        ( |116| )
        ( |60| )
        ( |91| )
        ( |80| )
        ( |132| )
        ( |20| )
        ( |154| )
        ( |53| )
        ( |14| )
        ( |103| )
        ( |31| )
        ( |65| )
        ( |110| )
        ( |43| )
        ( |38| )
        ( |47| )
        ( |120| )
        ( |112| )
        ( |87| )
        ( |24| )
        ( |95| )
        ( |33| )
        ( |104| )
        ( |73| )
        ( |22| )
        ( |66| )
        ( |137| )
        ( |21| )
        ( |109| )
        ( |118| )
        ( |63| )
        ( |55| )
        ( |124| )
        ( |146| )
        ( |148| )
        ( |84| )
        ( |86| )
        ( |147| )
        ( |125| )
        ( |23| )
        ( |85| )
        ( |117| )
        ( |71| )
        ( |48| )
        ( |136| )
        ( |151| )
        ( |130| )
        ( |83| )
        ( |56| )
        ( |140| )
        ( |9| )
        ( |49| )
        ( |113| )
        ( |131| )
        ( |133| )
        ( |74| )
        ( |37| )
        ( |127| )
        ( |34| )
        ( |32| )
        ( |106| )
        ( |1| )
        ( |78| )
        ( |11| )
        ( |72| )
        ( |40| )
        ( |96| )
        ( |17| )
        ( |64| )
        ( |92| )
        ( |102| )
        ( |123| )
        ( |126| )
        ( |90| )
        ( |105| )
        ( |57| )
        ( |99| )
        ( |27| )
        ( |70| )
        ( |98| )
        ( |111| )
        ( |30| )
        ( |50| )
        ( |67| )
        ( |2| )
        ( |155| )
        ( |5| )
        ( |119| )
        ( |8| )
        ( |39| )
    ).
  ENDMETHOD.

ENDCLASS.
