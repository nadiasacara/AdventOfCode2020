CLASS zcl_day18_ns DEFINITION
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
    METHODS perform_expression1
      IMPORTING expression    TYPE string
      CHANGING  ind           TYPE i
      RETURNING VALUE(result) TYPE int8.

    METHODS perform_expression2
      IMPORTING expression    TYPE string
                open          TYPE abap_bool OPTIONAL
      CHANGING  ind           TYPE i
      RETURNING VALUE(result) TYPE int8.
ENDCLASS.



CLASS zcl_day18_ns IMPLEMENTATION.
  METHOD zif_aoc_ns~first.
    DATA(i) = 0.
    result = REDUCE #( INIT sum = CONV int8( 0 )
                       FOR line IN input
                       NEXT sum += me->perform_expression1(
                        EXPORTING expression = replace( val = line  sub = | | with = || occ = 0 )
                        CHANGING  ind = i ) ).
  ENDMETHOD.

  METHOD zif_aoc_ns~second.
    result = REDUCE #( INIT sum = CONV int8( 0 ) i = 0
                       FOR line IN input
                       NEXT sum += me->perform_expression2(
                        EXPORTING expression = replace( val = line  sub = | | with = || occ = 0 )
                        CHANGING  ind = i )
                            i = 0 ).
  ENDMETHOD.

  METHOD constructor.

    super->constructor( input ).

  ENDMETHOD.

  METHOD perform_expression1.
    result = 0. DATA(operation) = '+'.
    DATA(i) = 0.
    WHILE i < strlen( expression ).

      DATA(char) = expression+i(1).

      IF char = '+' OR char = '*'.
        operation = char.
        i += 1.
      ELSEIF char = ')'.
        i += 1. ind = i. RETURN.
      ELSE.
        IF char BETWEEN '0' AND '9'.
          DATA(number) = CONV int8( char ).
          i += 1.
        ELSEIF char = '('.
          DATA(off) = 0.
          number = me->perform_expression1( EXPORTING expression = substring( val = expression off = i + 1 )
                                            CHANGING  ind = off ).
          i += off + 1.
        ENDIF.
        result = SWITCH int8( operation
                    WHEN '+' THEN result + number
                    WHEN '*' THEN result * number ).
      ENDIF.
    ENDWHILE.
  ENDMETHOD.

  METHOD perform_expression2.
    result = 0. DATA(operation) = '+'.
    DATA(i) = 0.
    WHILE i < strlen( expression ).

      DATA(char) = expression+i(1).

      IF open = abap_true AND ( char = ')' OR char = '*' ).
        ind = i. RETURN.
      ELSEIF char = ')' .
        i += 1. ind = i. RETURN.
      ELSEIF char = '+' OR char = '*'.
        operation = char.
        i += 1.
      ELSE.
        IF operation = '*'.
          DATA(off) = 0.
          DATA(number) = me->perform_expression2( EXPORTING expression = substring( val = expression off = i )
                                                            open = abap_true
                                                  CHANGING  ind = off ).
          i += off.
        ELSE.
          IF char BETWEEN '0' AND '9'.
            IF operation = '+'.
              number = CONV int8( char ).
              i += 1.
            ENDIF.
          ELSEIF char = '('.
            off = 0.
            number = me->perform_expression2( EXPORTING expression = substring( val = expression off = i + 1 )
                                              CHANGING  ind = off ).
            i += off + 1.
          ENDIF.
        ENDIF.
        result = SWITCH int8( operation
          WHEN '+' THEN result + number
          WHEN '*' THEN result * number ).
      ENDIF.
    ENDWHILE.
    ind = i.
  ENDMETHOD.

ENDCLASS.
