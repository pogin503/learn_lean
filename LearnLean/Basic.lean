-- mport Std
def hello := "world"

theorem easy : 2 + 2 = 4 :=
  rfl

-- @演算子
#check @id        -- {α : Sort u_1} → α → α
#check @id Nat    -- Nat → Nat
#check @id Bool   -- Bool → Bool

#check @id Nat 1     -- Nat
#check @id Bool true -- Bool


-- examples with equality
#check Eq   -- Eq.{u_1} {α : Sort u_1} : α → α → Prop
#check @Eq  -- @Eq : {α : Sort u_1} → α → α → Prop
#check Eq.symm   -- Eq.symm.{u} {α : Sort u} {a b : α} (h : a = b) : b = a
#check @Eq.symm  -- @Eq.symm : ∀ {α : Sort u_1} {a b : α}, a = b → b = a

#print Eq.symm

-- examples with And
#check And        -- And (a b : Prop) : Prop
#check And.intro  -- And.intro {a b : Prop} (left : a) (right : b) : a ∧ b
#check @And.intro -- @And.intro : ∀ {a b : Prop}, a → b → a ∧ b

-- a user-defined function
def foo {α : Type u} (x : α) : α := x

#check foo
#check @foo
#print foo
