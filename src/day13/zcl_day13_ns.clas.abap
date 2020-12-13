CLASS zcl_day13_ns DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC
  INHERITING FROM zcl_aoc_ns.

  PUBLIC SECTION.
    METHODS zif_aoc_ns~first REDEFINITION.
    METHODS zif_aoc_ns~second REDEFINITION.

    METHODS constructor
      IMPORTING input   TYPE string_table.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA time TYPE i.
    DATA buses TYPE string_table.

    METHODS get_least_common_multiple_of
      IMPORTING a             TYPE int8
                b             TYPE int8
      RETURNING VALUE(result) TYPE int8.

    METHODS get_greatest_common_divisor_of
      IMPORTING a             TYPE int8
                b             TYPE int8
      RETURNING VALUE(result) TYPE int8.
ENDCLASS.



CLASS zcl_day13_ns IMPLEMENTATION.
  METHOD zif_aoc_ns~first.
    DATA(shortest_wait) = 9999.

    LOOP AT buses REFERENCE INTO DATA(bus) WHERE table_line <> 'x'.
      DATA(wait) = bus->* - time MOD bus->*.
      IF shortest_wait > wait.
        shortest_wait = wait.
        DATA(my_bus) = bus->*.
      ENDIF.
    ENDLOOP.

    result = shortest_wait * my_bus.
  ENDMETHOD.

  METHOD zif_aoc_ns~second.

    DATA(step) = CONV int8( buses[ 1 ] ).
    result = buses[ 1 ].

    LOOP AT buses REFERENCE INTO DATA(bus) FROM 2 WHERE table_line <> 'x' .
      DO.
        IF ( result + sy-tabix - 1 ) MOD bus->* = 0.
          step = get_least_common_multiple_of( a = step b = CONV #( bus->* ) ).
          EXIT.
        ELSE.
          result += step.
        ENDIF.
      ENDDO.
    ENDLOOP.

  ENDMETHOD.

  METHOD get_least_common_multiple_of.
    result = ( a * b ) / get_greatest_common_divisor_of( a = a b = b ).
  ENDMETHOD.

  METHOD get_greatest_common_divisor_of.
    result = SWITCH #( b
        WHEN 0 THEN a
        ELSE get_greatest_common_divisor_of( a = b b = a MOD b ) ).
  ENDMETHOD.

  METHOD constructor.
    super->constructor( input ).
    me->time = input[ 1 ].
    SPLIT input[ 2 ] AT ',' INTO TABLE buses.
  ENDMETHOD.

ENDCLASS.
