signature OrderedHOLset =
sig
    type 'a ordered_set
    val empty : ('a -> string) -> 'a ordered_set
    val copy : 'a ordered_set -> 'a ordered_set
    val add : ('a ordered_set * 'a) -> 'a ordered_set
    val add_inplace : ('a ordered_set * 'a) -> 'a ordered_set
    val listItems : 'a ordered_set -> 'a list
    val setItems : ('a * 'a -> order) -> 'a ordered_set -> 'a HOLset.set
    val member : ('a ordered_set * 'a) -> bool
    val union : ('a ordered_set * 'a ordered_set) -> 'a ordered_set
    val union_inplace : ('a ordered_set * 'a ordered_set) -> 'a ordered_set
    val fromSet : ('a -> string) -> 'a HOLset.set -> 'a ordered_set
    val fromList : ('a -> string) -> 'a list -> 'a ordered_set
    val singleton : ('a -> string) * 'a -> 'a ordered_set
end
