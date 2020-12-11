CLASS zcl_day11_ns DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC
  INHERITING FROM zcl_aoc_ns .

  PUBLIC SECTION.
    METHODS zif_aoc_ns~first REDEFINITION.
    METHODS zif_aoc_ns~second REDEFINITION.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA check_only_1 TYPE abap_bool.
    DATA possible_neighbours TYPE i.

    METHODS move_and_count_occupied
      IMPORTING input         TYPE string_table
      RETURNING VALUE(result) TYPE i.

    METHODS get_occupied_seats
      IMPORTING input         TYPE string_table
                coord         TYPE ty_coord
      RETURNING VALUE(result) TYPE i.

    METHODS get_steps
      RETURNING VALUE(result) TYPE tt_coord.
ENDCLASS.



CLASS zcl_day11_ns IMPLEMENTATION.
  METHOD zif_aoc_ns~first.
    me->check_only_1 = abap_true.
    me->possible_neighbours = 4.
    result = me->move_and_count_occupied( input ).
  ENDMETHOD.

  METHOD zif_aoc_ns~second.
    me->check_only_1 = abap_false.
    me->possible_neighbours = 5.
    result = me->move_and_count_occupied( input ).
  ENDMETHOD.

  METHOD move_and_count_occupied.
    DATA new_input TYPE string_table.
    LOOP AT input INTO DATA(line).
      DATA(new_line) = VALUE string( ).

      DO strlen( line ) TIMES.
        DATA(off) = sy-index - 1.
        result += SWITCH #( line+off(1) WHEN '#' THEN 1 ).
        DATA(occup_seats) = SWITCH #( line+off(1) WHEN '#' OR 'L'
                            THEN get_occupied_seats( input = input coord = VALUE #( line = sy-tabix column = sy-index ) ) ).

        new_line &&= SWITCH ty_char( line+off(1)
                            WHEN 'L' THEN SWITCH #( occup_seats WHEN 0 THEN '#' ELSE line+off(1) )
                            WHEN '#' THEN COND #( WHEN occup_seats >= me->possible_neighbours THEN 'L' ELSE line+off(1) )
                            ELSE line+off(1) ).
      ENDDO.
      APPEND new_line TO new_input.
    ENDLOOP.

    result = COND #( WHEN input = new_input THEN result
                     ELSE me->move_and_count_occupied( new_input ) ).
  ENDMETHOD.

  METHOD get_occupied_seats.
    LOOP AT me->get_steps( ) INTO DATA(step).
      DATA(i) = coord-line + step-line.
      DATA(off) = coord-column + step-column - 1.

      WHILE ( i BETWEEN 1 AND lines( input ) ) AND ( off >= 0 AND off < strlen( input[ 1 ] ) ).

        DATA(line) = input[ i ].
        result += SWITCH #( line+off(1) WHEN '#' THEN 1 WHEN 'L' THEN 0 ).
        IF line+off(1) <> '.' OR check_only_1 = abap_true.
          EXIT.
        ENDIF.

        i += step-line.
        off += step-column.
      ENDWHILE.
    ENDLOOP.
  ENDMETHOD.

  METHOD get_steps.
    result = VALUE #(
        ( line = -1 column = -1 )
        ( line = -1 column = 0  )
        ( line = -1 column = 1 )
        ( line = 0  column = -1  )
        ( line = 0  column = 1 )
        ( line = 1  column = -1 )
        ( line = 1  column = 0 )
        ( line = 1  column = 1 )
    ).
  ENDMETHOD.

ENDCLASS.
