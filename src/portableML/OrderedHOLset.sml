structure OrderedHOLset :> OrderedHOLset =
struct
  open Portable

  type 'a ordered_set = 'a HOLset.set * 'a list

  fun empty ordering = (HOLset.empty ordering, [])

  fun add (original_set as (set, list), x) =
      if HOLset.member (set, x) then original_set
      else (HOLset.add (set, x), x::list)

  val listItems = snd

  val setItems = fst

  fun member ((set, _), x) = HOLset.member (set, x)

  fun union (A, B) = let
      fun insert_fv x set = add (set, x)
      val A_items = listItems A
  in
      itlist insert_fv A_items B
  end

  (* Reverse append written to mirror mLibUseful's Lib.union *)
  fun revAppend (A, B) = let
      fun rev (set, list) = (set, List.rev list)
      fun revAppend' (lst, S) =
          case lst of
              [] => S
            | t::ts => revAppend' (ts, add(S, t))
  in
      revAppend' (snd A, rev B)
  end

  fun fromSet set = (set, HOLset.listItems set)

end;
