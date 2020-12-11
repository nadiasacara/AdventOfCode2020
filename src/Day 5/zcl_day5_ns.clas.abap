CLASS zcl_day5_ns DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC
  INHERITING FROM zcl_aoc_ns.

  PUBLIC SECTION.
    METHODS zif_aoc_ns~first REDEFINITION.
    METHODS zif_aoc_ns~second REDEFINITION.

  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS calculate_seat_id
      IMPORTING row           TYPE i
                column        TYPE i
      RETURNING VALUE(result) TYPE i.

    METHODS get_seat_id_for_seat
      IMPORTING seat          TYPE string
      RETURNING VALUE(result) TYPE i.

    METHODS get_row
      IMPORTING seat          TYPE string
      RETURNING VALUE(result) TYPE i.

    METHODS get_column
      IMPORTING seat          TYPE string
      RETURNING VALUE(result) TYPE i.
ENDCLASS.



CLASS zcl_day5_ns IMPLEMENTATION.

  METHOD zif_aoc_ns~first.
    LOOP AT input INTO DATA(seat).
      result = nmax( val1 = result val2 = get_seat_id_for_seat( seat ) ).
    ENDLOOP.
  ENDMETHOD.

  METHOD get_seat_id_for_seat.
    result = calculate_seat_id( row = get_row( seat ) column = get_column( seat ) ).
  ENDMETHOD.

  METHOD calculate_seat_id.
    result = row * 8 + column.
  ENDMETHOD.

  METHOD get_row.
    result = REDUCE #(
        INIT max = 127
             min = 0
        FOR i = 0 WHILE i < 7
        NEXT max = SWITCH #( seat+i(1)
                    WHEN 'F' THEN ( min + max ) DIV 2 ELSE max )
             min = SWITCH #( seat+i(1)
                    WHEN 'B' THEN ( ( min + max ) DIV 2 + 1 ) ELSE min )
    ).
  ENDMETHOD.

  METHOD get_column.
    result = REDUCE #(
        INIT max = 7
             min = 0
        FOR i = 7 WHILE i < 10
        NEXT max = SWITCH #( seat+i(1)
                    WHEN 'L' THEN ( min + max ) DIV 2 ELSE max )
             min = SWITCH #( seat+i(1)
                    WHEN 'R' THEN ( ( min + max ) DIV 2 + 1 ) ELSE min )
    ).
  ENDMETHOD.

  METHOD zif_aoc_ns~second.
    DATA(possible_seats) = VALUE tt_sorted_int(
                            FOR i = 0 WHILE i <= 127
                                FOR j = 0 WHILE j <= 7
                                    ( calculate_seat_id( row = i column = j ) ) ) .
    DATA(occupied_seats) = VALUE tt_sorted_int( FOR seat IN input ( get_seat_id_for_seat( seat ) ) ).
    DATA(free_seats) = FILTER #( possible_seats EXCEPT IN occupied_seats WHERE table_line = table_line ).

    LOOP AT free_seats INTO DATA(free_seat) FROM 2 TO lines( free_seats ) - 1.
      DATA(prev_seat) = free_seats[ sy-tabix - 1 ].
      DATA(next_seat) = free_seats[ sy-tabix + 1 ].
      IF free_seat <> prev_seat + 1 AND free_seat <> next_seat - 1.
        result = free_seat.
        RETURN.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
