TYPES: BEGIN OF ty_pass_fields,
         field TYPE c LENGTH 3,
         value TYPE string,
       END OF ty_pass_fields.
TYPES tt_pass_fields TYPE SORTED TABLE OF ty_pass_fields WITH UNIQUE KEY field.
TYPES tt_pass TYPE STANDARD TABLE OF tt_pass_fields WITH DEFAULT KEY.
