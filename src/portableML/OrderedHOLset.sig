signature OrderedHOLset =
sig
    type 'a ordered_set
    val empty : ('a * 'a -> order) -> 'a ordered_set
    val add : ('a ordered_set * 'a) -> 'a ordered_set
    val listItems : 'a ordered_set -> 'a list
    val setItems : 'a ordered_set -> 'a HOLset.set
    val member : ('a ordered_set * 'a) -> bool
    val union : ('a ordered_set * 'a ordered_set) -> 'a ordered_set
    val revAppend : ('a ordered_set * 'a ordered_set) -> 'a ordered_set
    val fromSet : 'a HOLset.set -> 'a ordered_set
    val fromList : ('a * 'a -> order) -> 'a list -> 'a ordered_set
end
