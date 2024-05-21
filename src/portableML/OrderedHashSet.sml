structure OrderedHashSet :> OrderedHashSet =
struct
  open Portable

  type 'a hashset = unit HashArray.hash * 'a list ref * ('a -> string)

  fun empty hasher = (HashArray.hash 5, ref [], hasher)

  fun member ((tbl, _, hasher), x) = Option.isSome (HashArray.sub (tbl, hasher x))

  fun add_inplace (original_set as (tbl, list_ref, hasher), x) = let
      val _ = HashArray.update (tbl, hasher x, ())
  in
      (tbl, (list_ref := x::(!list_ref); list_ref), hasher)
  end

  fun copy (tbl, lst, hasher) = let
      val tbl' = HashArray.hash 5
      val _ = HashArray.fold (fn (id, _, _) => HashArray.update (tbl', id, ())) () tbl
      val lst' = ref (!lst)
  in
      (tbl', lst', hasher)
  end

  fun add (tbl, x) = add_inplace (copy tbl, x)

  fun listItems (_, lst, _) = !lst

  fun setItems compare set = HOLset.fromList compare (listItems set)

  fun union_inplace (A, B) = let
      fun insert_fv x tbl = add_inplace (tbl, x)
      val A_items = listItems A
  in
      itlist insert_fv A_items B
  end

  fun union (A, B) = let
      fun insert_fv x tbl = add (tbl, x)
      val A_items = listItems A
  in
      itlist insert_fv A_items B
  end

  fun fromSet hasher set = let
      val tbl = HashArray.hash 5
      val _ = HOLset.foldl (fn (x,_) => HashArray.update(tbl,hasher x,())) () set
  in (tbl, ref (HOLset.listItems set), hasher)
  end

  fun fromList hasher list = let
      val tbl = HashArray.hash 5
      val _ = foldl (fn (x,_) => HashArray.update(tbl,hasher x,())) () list
  in (tbl, ref list, hasher)
  end

  fun singleton (hasher, x) = add (empty hasher, x)

end;
