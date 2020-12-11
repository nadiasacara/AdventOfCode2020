TYPES: BEGIN OF ty_index_pair,
         ind1 TYPE i,
         ind2   TYPE i,
       END OF ty_index_pair.
TYPES tt_index_pair TYPE STANDARD TABLE OF ty_index_pair WITH EMPTY KEY.
