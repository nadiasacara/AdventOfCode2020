*"* use this source file for any type of declarations (class
*"* definitions, interfaces or type declarations) you need for
*"* components in the private section
TYPES ty_ticket TYPE STANDARD TABLE OF i WITH EMPTY KEY.
TYPES tt_ticket TYPE STANDARD TABLE OF ty_ticket WITH EMPTY KEY.

TYPES: BEGIN OF ty_field_checks,
         position     TYPE i,
         valid_checks TYPE STANDARD TABLE OF i WITH EMPTY KEY,
       END OF ty_field_checks.
TYPES tt_pos_checks TYPE STANDARD TABLE OF ty_field_checks WITH EMPTY KEY.

TYPES: BEGIN OF ty_found_fields,
         field_nr TYPE i,
         check_nr TYPE i,
       END OF ty_found_fields.
TYPES tt_found_fields TYPE SORTED TABLE OF ty_found_fields WITH UNIQUE KEY check_nr.

TYPES tt_check_range TYPE RANGE OF i.
