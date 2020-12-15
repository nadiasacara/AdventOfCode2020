CLASS zcl_day6_ns DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC
  INHERITING FROM zcl_aoc_ns.

  PUBLIC SECTION.
    METHODS zif_aoc_ns~first REDEFINITION.
    METHODS zif_aoc_ns~second REDEFINITION.

  PROTECTED SECTION.
  PRIVATE SECTION.

    METHODS fill_group_answers
      RETURNING VALUE(result) TYPE tt_answers.
ENDCLASS.



CLASS zcl_day6_ns IMPLEMENTATION.
  METHOD zif_aoc_ns~first.
    LOOP AT fill_group_answers( ) REFERENCE INTO DATA(answers).
      result += REDUCE int8(
        INIT yes_answers = 0
        FOR word = concat_lines_of( answers->* ) THEN replace( val = word sub = word(1) with = `` occ = 0 ) WHILE word <> ``
        NEXT yes_answers += 1 ) .
    ENDLOOP.
  ENDMETHOD.

  METHOD zif_aoc_ns~second.
    LOOP AT fill_group_answers( ) REFERENCE INTO DATA(answers).
      result += REDUCE int8(
        INIT yes_all_answers = 0
        FOR word = concat_lines_of( answers->* ) THEN replace( val = word sub = word(1) with = `` occ = 0 ) WHILE word <> ``
        NEXT yes_all_answers += COND #( WHEN count( val = word sub = word(1) ) = lines( answers->* ) THEN 1  )
        ).
    ENDLOOP.
  ENDMETHOD.

  METHOD fill_group_answers.
    DATA group_answer TYPE string_table.
    DATA(answers) = input.
    APPEND || TO answers.
    LOOP AT answers REFERENCE INTO DATA(answer).
      IF answer->* IS NOT INITIAL.
        APPEND answer->* TO group_answer.
      ELSE.
        APPEND group_answer TO result.
        CLEAR group_answer[].
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
