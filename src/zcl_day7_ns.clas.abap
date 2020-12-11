CLASS zcl_day7_ns DEFINITION
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
    DATA rules TYPE tt_rule.

    METHODS get_outer_bags
      IMPORTING bag        TYPE string
      CHANGING  found_bags TYPE string_table.

    METHODS get_nr_inner_bags
      IMPORTING bag           TYPE string
      RETURNING VALUE(result) TYPE i.

ENDCLASS.


CLASS zcl_day7_ns IMPLEMENTATION.

  METHOD zif_aoc_ns~first.
    DATA bags TYPE string_table.
    me->get_outer_bags(
      EXPORTING bag   = |shiny gold|
      CHANGING  found_bags = bags
    ).
    result = lines( bags ).
  ENDMETHOD.

  METHOD get_outer_bags.
    LOOP AT rules REFERENCE INTO DATA(rule).

      IF find( val = rule->inner_bags sub = bag ) <> -1 AND NOT line_exists( found_bags[ table_line = rule->outer_bag ] ).

        APPEND rule->outer_bag TO found_bags.
        get_outer_bags(
          EXPORTING bag   = rule->outer_bag
          CHANGING  found_bags = found_bags
        ).
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD zif_aoc_ns~second.
    result = get_nr_inner_bags( |shiny gold| ).
  ENDMETHOD.

  METHOD get_nr_inner_bags.
    LOOP AT rules REFERENCE INTO DATA(rule).

      IF find( val = rule->outer_bag sub = bag ) <> -1.

        SPLIT rule->inner_bags AT |, | INTO TABLE DATA(inner_bags_list).

        LOOP AT inner_bags_list REFERENCE INTO DATA(inner_bag).
          IF inner_bag->*(1) BETWEEN '0' AND '9'.
            result += inner_bag->*(1) +
                      inner_bag->*(1) * get_nr_inner_bags( substring_before( val = inner_bag->*+2 sub = | bag| ) ).
          ENDIF.
        ENDLOOP.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD constructor.
    super->constructor( input ).
    LOOP AT input REFERENCE INTO DATA(rule).
      SPLIT rule->* AT | bags contain | INTO DATA(outer_bag) DATA(inner_bags).
      APPEND VALUE #( outer_bag = outer_bag inner_bags = inner_bags ) TO me->rules.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
