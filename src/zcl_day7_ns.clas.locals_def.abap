TYPES: BEGIN OF ty_rule,
         outer_bag  TYPE string,
         inner_bags TYPE string,
       END OF ty_rule.
TYPES tt_rule TYPE STANDARD TABLE OF ty_rule WITH EMPTY KEY.
