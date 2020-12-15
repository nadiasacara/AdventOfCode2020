CLASS zcl_day15_ns DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC
  INHERITING FROM zcl_aoc_ns.

  PUBLIC SECTION.
    METHODS zif_aoc_ns~first REDEFINITION.
    METHODS zif_aoc_ns~second REDEFINITION.

  PROTECTED SECTION.
  PRIVATE SECTION.

    METHODS get_last_turn_number
      IMPORTING last_turn     TYPE int8
      RETURNING VALUE(result) TYPE int8.
ENDCLASS.



CLASS zcl_day15_ns IMPLEMENTATION.
  METHOD zif_aoc_ns~first.
    result = me->get_last_turn_number( 2020 ).
  ENDMETHOD.

  METHOD zif_aoc_ns~second.
    result = me->get_last_turn_number( 30000000 ).
  ENDMETHOD.

  METHOD get_last_turn_number.
    SPLIT input[ 1 ] AT ',' INTO TABLE DATA(start_numbers).
    DATA(game) = VALUE tt_game( FOR wa IN start_numbers INDEX INTO i ( number = wa last_turn = i ) ).
    DATA(prev_turn) = game[ last_turn = lines( game ) ].

    DO last_turn - lines( start_numbers ) TIMES.
      DATA(new_number) = SWITCH #( prev_turn-before_last_turn
          WHEN 0 THEN 0
          ELSE prev_turn-last_turn - prev_turn-before_last_turn ).

      READ TABLE game WITH TABLE KEY number = new_number REFERENCE INTO DATA(new_game).
      IF sy-subrc IS NOT INITIAL.
        INSERT VALUE #( number = new_number ) INTO TABLE game REFERENCE INTO new_game.
      ENDIF.

      new_game->before_last_turn = new_game->last_turn.
      new_game->last_turn = lines( start_numbers ) + sy-index.
      prev_turn = new_game->*.
    ENDDO.

    result = new_number.
  ENDMETHOD.

ENDCLASS.
