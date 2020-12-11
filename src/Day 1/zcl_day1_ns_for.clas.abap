CLASS zcl_day1_ns_for DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC
  INHERITING FROM zcl_aoc_ns.

  PUBLIC SECTION.
    METHODS zif_aoc_ns~first REDEFINITION.
    METHODS zif_aoc_ns~second REDEFINITION.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_day1_ns_for IMPLEMENTATION.

  METHOD zif_aoc_ns~first.
    result = REDUCE #(
        INIT product = 0
        FOR i IN input INDEX INTO ind_i TO lines( input ) - 1
            FOR j IN input FROM ind_i + 1
        NEXT product = COND #( WHEN i + j = 2020 THEN i * j ELSE product ) ).
  ENDMETHOD.

  METHOD zif_aoc_ns~second.
    DATA(lines) = lines( input ).
    result = REDUCE #(
        INIT product = 0
        FOR i IN input INDEX INTO ind_i TO lines - 2
            FOR j IN input INDEX INTO ind_j FROM ind_i + 1 TO lines - 1
                FOR m IN input FROM ind_j + 1
        NEXT product = COND #( WHEN i + j + m = 2020 THEN i * j * m ELSE product ) ).
  ENDMETHOD.

ENDCLASS.
