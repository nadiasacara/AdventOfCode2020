CLASS zcl_day9_ns DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC
  INHERITING FROM zcl_aoc_ns.

  PUBLIC SECTION.
    METHODS zif_aoc_ns~first REDEFINITION.
    METHODS zif_aoc_ns~second REDEFINITION.

    METHODS constructor
      IMPORTING input    TYPE string_table
                preamble TYPE i.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA preamble TYPE i.

    METHODS element_is_a_sum
      IMPORTING VALUE(index)  TYPE i
      RETURNING VALUE(result) TYPE abap_bool.

    METHODS get_sum_start_and_end_index
      RETURNING VALUE(result) TYPE ty_index_pair.

    METHODS get_index_pairs_between
      IMPORTING limits        TYPE ty_index_pair
      RETURNING VALUE(result) TYPE tt_index_pair.
ENDCLASS.



CLASS zcl_day9_ns IMPLEMENTATION.
  METHOD zif_aoc_ns~first.
    LOOP AT input REFERENCE INTO DATA(element) FROM preamble + 1.
      IF element_is_a_sum( sy-tabix ) = abap_false.
        result = element->*.
        RETURN.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD zif_aoc_ns~second.
    DATA(indexes) = me->get_sum_start_and_end_index( ).
    DATA(max) = 0.
    DATA(min) = 999999999999999999999.
    LOOP AT input REFERENCE INTO DATA(number) FROM indexes-ind1 TO indexes-ind2.
      min = nmin( val1 = min val2 = number->* ).
      max = nmax( val1 = max val2 = number->* ).
    ENDLOOP.
    result = min + max.
  ENDMETHOD.

  METHOD element_is_a_sum.
    LOOP AT me->get_index_pairs_between( VALUE #( ind1 = index - preamble  ind2 = index - 1 ) ) REFERENCE INTO DATA(index_pair).
      IF CONV int8( input[ index ] ) = input[ index_pair->ind1 ] + input[ index_pair->ind2 ].
        result = abap_true.
        RETURN.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD get_index_pairs_between.
    result = VALUE #( FOR ind1 = limits-ind1 WHILE ind1 < limits-ind2
                        FOR ind2 = ind1 + 1 WHILE ind2 <= limits-ind2
                        ( ind1 = ind1 ind2 = ind2 ) ).
  ENDMETHOD.

  METHOD get_sum_start_and_end_index.
    DATA(invalid_nr) = me->zif_aoc_ns~first( ).

    DO lines( input ) - 1 TIMES.
      LOOP AT me->get_index_pairs_between( VALUE #( ind1 = sy-index ind2 = lines( input ) ) ) INTO result.
        DATA(partial_sum) = REDUCE #( INIT s = 0
                                      FOR number IN input FROM result-ind1 TO result-ind2
                                      NEXT s += number ).
        IF partial_sum = invalid_nr.
          RETURN.
        ELSEIF partial_sum > invalid_nr.
          EXIT.
        ENDIF.
      ENDLOOP.
    ENDDO.
  ENDMETHOD.

  METHOD constructor.
    super->constructor( input ).
    me->preamble = preamble.
  ENDMETHOD.

ENDCLASS.
