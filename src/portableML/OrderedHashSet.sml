structure OrderedHashSet :> OrderedHashSet =
struct
  open Portable

  type 'a hashset = unit HashArray.hash * 'a list ref * ('a -> string)

  fun empty hash_function = (HashArray.hash 5, ref [], hash_function)

  fun member ((tbl, _, hash_function), x) = Option.isSome (HashArray.sub (tbl, hash_function x))

  fun add_inplace (original_set as (tbl, list_ref, hash_function), x) = let
      val _ = HashArray.update (tbl, hash_function x, ())
  in
      (tbl, (list_ref := x::(!list_ref); list_ref), hash_function)
  end

  fun copy (tbl, lst, hash_function) = let
      val tbl' = HashArray.hash 5
      val _ = HashArray.fold (fn (id, _, _) => HashArray.update (tbl', id, ())) () tbl
      val lst' = ref (!lst)
  in
      (tbl', lst', hash_function)
  end

  fun add (tbl, x) = add_inplace (copy tbl, x)

  fun listItems (_, lst, _) = !lst

  fun setItems compare set = HOLset.fromList compare (listItems set)

  (* Adds every element from A into B *)
  fun union_inplace (A, B) = let
      fun insert_fv x tbl = add_inplace (tbl, x)
      val A_items = listItems A
  in
      itlist insert_fv A_items B
  end

  (* Adds every element of A and B into a new ordered hash set *)
  fun union (A as (_,A_items_ref,hash_function), B) = let
      fun insert_fv x tbl = add_inplace (tbl, x)
      val tbl' = empty hash_function
      val B_items = listItems B
      val _ = itlist insert_fv (!A_items_ref) tbl'
      val _ = itlist insert_fv B_items tbl'
  in
      tbl'
  end

  fun fromSet hash_function set = let
      val tbl = HashArray.hash 5
      val _ = HOLset.foldl (fn (x,_) => HashArray.update(tbl, hash_function x, ())) () set
  in (tbl, ref (HOLset.listItems set), hash_function)
  end

  fun fromList hash_function list = let
      val tbl = HashArray.hash 5
      val _ = foldl (fn (x,_) => HashArray.update(tbl, hash_function x, ())) () list
  in (tbl, ref list, hash_function)
  end

  fun singleton (hash_function, x) = add_inplace (empty hash_function, x)

end;
