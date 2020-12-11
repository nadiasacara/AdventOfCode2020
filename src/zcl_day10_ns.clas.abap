CLASS zcl_day10_ns DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC
  INHERITING FROM zcl_aoc_ns.

  PUBLIC SECTION.
    METHODS zif_aoc_ns~first REDEFINITION.
    METHODS zif_aoc_ns~second REDEFINITION.

    METHODS constructor
      IMPORTING input TYPE string_table.


  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA adapters TYPE tt_int.

    METHODS get_differences_nr_for
      IMPORTING difference    TYPE i
      RETURNING VALUE(result) TYPE i.

ENDCLASS.



CLASS zcl_day10_ns IMPLEMENTATION.
  METHOD zif_aoc_ns~first.
    result = me->get_differences_nr_for( 1 ) * get_differences_nr_for( 3 ) .
  ENDMETHOD.

  METHOD get_differences_nr_for.
    result = REDUCE #( INIT sum = 0 prev = me->adapters[ 1 ] + 3
                FOR a IN adapters
                NEXT sum += COND #( WHEN prev - a = difference THEN 1 )
                     prev = a ).
  ENDMETHOD.

  METHOD zif_aoc_ns~second.
    DATA(combinations) = VALUE tt_int( FOR i = 1 WHILE i <= me->adapters[ 1 ] + 4 ( CONV #( 0 ) ) ).
    combinations[ lines( combinations ) ] = 1.

    LOOP AT me->adapters INTO DATA(adapter).
      combinations[ adapter + 1 ] = combinations[ adapter + 2 ] + combinations[ adapter + 3 ] + combinations[ adapter + 4 ].
    ENDLOOP.
    result = combinations[ 1 ].
  ENDMETHOD.

  METHOD constructor.
    super->constructor( input ).
    me->adapters = input.
    SORT me->adapters DESCENDING.
    APPEND 0 TO me->adapters.
  ENDMETHOD.
ENDCLASS.
