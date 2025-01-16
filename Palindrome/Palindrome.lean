inductive Palindrome : List α → Prop where
  | nil : Palindrome []
  | single : (a : α) → Palindrome [a]
  | sandwitch : (a : α) → Palindrome as → Palindrome ([a] ++ as ++ [a])

theorem palindrome_reverse (h : Palindrome as) : Palindrome as.reverse := by
  induction h with
  | nil => exact Palindrome.nil
  | single a => exact Palindrome.single a
  | sandwitch a h ih => simp; exact Palindrome.sandwitch _ ih

theorem reverse_eq_of_palindrome (h : Palindrome as) : as.reverse = as := by
  induction h with
  | nil => rfl
  | single a => rfl
  | sandwitch a _ ih => simp [ih]
