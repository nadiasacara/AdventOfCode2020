CLASS zcl_day3_ns DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC
  INHERITING FROM zcl_aoc_ns.

  PUBLIC SECTION.
    METHODS zif_aoc_ns~first REDEFINITION.
    METHODS zif_aoc_ns~second REDEFINITION.

  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS sum_trees
      IMPORTING right         TYPE i
                down          TYPE i
      RETURNING VALUE(result) TYPE i.
ENDCLASS.



CLASS zcl_day3_ns IMPLEMENTATION.

  METHOD zif_aoc_ns~first.
    result = sum_trees( right = 3 down  = 1 ).
  ENDMETHOD.

  METHOD zif_aoc_ns~second.
    result = sum_trees( right = 1 down = 1 ) *
             sum_trees( right = 3 down = 1 ) *
             sum_trees( right = 5 down = 1 ) *
             sum_trees( right = 7 down = 1 ) *
             sum_trees( right = 1 down = 2 ).
  ENDMETHOD.

  METHOD sum_trees.
    result = REDUCE #(
                INIT trees = 0
                     off = 0
                FOR i = 1 THEN i + down WHILE i <= lines( input )
                NEXT trees += SWITCH #( substring( val = input[ i ] off = off len = 1 ) WHEN '#' THEN 1 )
                     off = ( off + right ) MOD strlen( input[ 1 ] ) ).
  ENDMETHOD.

ENDCLASS.
