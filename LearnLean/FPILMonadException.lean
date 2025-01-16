import Batteries.Tactic.Instances

namespace LearnLean.FPIL

def ExceptT (ε : Type u) (m : Type u → Type v) (α : Type u) : Type v :=
  m (Except ε α)

def ExceptT.mk {ε α : Type u} (x : m (Except ε α)) : ExceptT ε m α := x

def ExceptT.run {ε α : Type u} (x : ExceptT ε m α) : m (Except ε α) := x

instance {ε : Type u} {m : Type u → Type v} [Monad m] : Monad (ExceptT ε m) where
  pure x := ExceptT.mk (pure (Except.ok x))
  bind result next := ExceptT.mk do
    match ← result with
    | .error e => pure (.error e)
    | .ok x => next x

instance [Monad m] : MonadLift (Except ε) (ExceptT ε m) where
  monadLift action := ExceptT.mk (pure action)

instance [Monad m] : MonadLift m (ExceptT ε m) where
  monadLift action := ExceptT.mk (.ok <$> action)


structure LetterCounts where
  vowels : Nat
  consonants : Nat
deriving Repr

inductive Err where
  | notALetter : Char → Err
deriving Repr

def vowels :=
  let lowerVowels := "aeiuoy"
  lowerVowels ++ lowerVowels.map (·.toUpper)

def consonants :=
  let lowerConsonants := "bcdfghjklmnpqrstvwxz"
  lowerConsonants ++ lowerConsonants.map (·.toUpper )

-- def countLetters (str : String) : StateT LetterCounts (Except Err) Unit :=
--   let rec loop (chars : List Char) := do
--     match chars with
--     | [] => pure ()
--     | c :: cs =>
--       let st ← get
--       let st' ←
--         if c.isAlpha then
--           if vowels.contains c then
--             pure {st with vowels := st.vowels + 1}
--           else if consonants.contains c then
--             pure {st with consonants := st.consonants + 1}
--           else -- modified or non-English letter
--             pure st
--         else throw (.notALetter c)
--       set st'
--       loop cs
--   loop str.toList

def modify [MonadState σ m] (f : σ → σ) : m Unit :=
  modifyGet fun s => ((), f s)

def countLetters (str : String) : StateT LetterCounts (Except Err) Unit :=
  let rec loop (chars : List Char) := do
    match chars with
    | [] => pure ()
    | c :: cs =>
      if c.isAlpha then
        if vowels.contains c then
          modify fun st => {st with vowels := st.vowels + 1}
        else if consonants.contains c then
          modify fun st => {st with consonants := st.consonants + 1}
        else -- modified or non-English letter
          pure ()
      else throw (.notALetter c)
      loop cs
  loop str.toList

class MonadState (σ : outParam (Type u)) (m : Type u → Type v) : Type (max (u+1) v) where
  get : m σ
  set : σ → m PUnit
  modifyGet : (σ → α × σ) → m α
