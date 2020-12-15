CLASS zcl_day8_ns DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC
  INHERITING FROM zcl_aoc_ns.

  PUBLIC SECTION.
    METHODS zif_aoc_ns~first REDEFINITION.
    METHODS zif_aoc_ns~second REDEFINITION.

  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS fill_instructions
      RETURNING VALUE(result) TYPE tt_instruction.

    METHODS get_accumulator
      IMPORTING instructions  TYPE tt_instruction
      RETURNING VALUE(result) TYPE ty_accumulator.
ENDCLASS.



CLASS zcl_day8_ns IMPLEMENTATION.

  METHOD zif_aoc_ns~first.
    result = me->get_accumulator( me->fill_instructions( ) )-accumulator.
  ENDMETHOD.

  METHOD zif_aoc_ns~second.

    DATA(instructions) = me->fill_instructions( ).

    LOOP AT instructions REFERENCE INTO DATA(instr).

      IF instr->operation = 'nop' OR instr->operation = 'jmp'.

        DATA(old_operation) = instr->operation.
        instr->operation = SWITCH #( instr->operation
                        WHEN 'nop' THEN 'jmp'
                        WHEN 'jmp' THEN 'nop' ).
        DATA(accumulator) = get_accumulator( instructions ).
        instr->operation = old_operation.

        IF accumulator-input_is_valid = abap_true.
          result = accumulator-accumulator.
          RETURN.
        ENDIF.

      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD get_accumulator.

    DATA executed_instructs TYPE SORTED TABLE OF i WITH UNIQUE KEY table_line.
    DATA(i) = 1.
    result-input_is_valid = abap_true.

    WHILE i <= lines( instructions ).

      IF line_exists( executed_instructs[ table_line = i ] ).
        result-input_is_valid = abap_false.
        RETURN.

      ELSE.
        INSERT i INTO TABLE executed_instructs.
        DATA(instruction) = instructions[ i ].

        result-accumulator += SWITCH i( instruction-operation WHEN 'acc' THEN instruction-argument ).
        i += SWITCH #( instruction-operation
                WHEN 'nop' OR 'acc' THEN 1
                WHEN 'jmp' THEN instruction-argument ).
      ENDIF.
    ENDWHILE.

  ENDMETHOD.

  METHOD fill_instructions.
    LOOP AT input REFERENCE INTO DATA(instr).
      APPEND VALUE #( operation = instr->*(3) argument = instr->*+4 ) TO result.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
