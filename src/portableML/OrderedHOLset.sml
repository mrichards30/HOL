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
end;
