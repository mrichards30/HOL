signature OrderedHashSet =
sig
    type 'a hashset
    val empty : ('a -> string) -> 'a hashset
    val copy : 'a hashset -> 'a hashset
    val add : ('a hashset * 'a) -> 'a hashset
    val add_inplace : ('a hashset * 'a) -> 'a hashset
    val listItems : 'a hashset -> 'a list
    val setItems : ('a * 'a -> order) -> 'a hashset -> 'a HOLset.set
    val member : ('a hashset * 'a) -> bool
    val union : ('a hashset * 'a hashset) -> 'a hashset
    val union_inplace : ('a hashset * 'a hashset) -> 'a hashset
    val fromSet : ('a -> string) -> 'a HOLset.set -> 'a hashset
    val fromList : ('a -> string) -> 'a list -> 'a hashset
    val singleton : ('a -> string) * 'a -> 'a hashset
end
