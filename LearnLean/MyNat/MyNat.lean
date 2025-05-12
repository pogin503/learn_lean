inductive MyNat where
  | zero : MyNat
  | succ : MyNat -> MyNat
  deriving Repr

#check MyNat.zero
#check MyNat.succ
#check MyNat.succ (MyNat.zero)
#eval MyNat.succ (MyNat.zero)

open MyNat
#eval succ zero

def nat_to_mynat (n : Nat) : MyNat :=
  match n with
  | Nat.zero => MyNat.zero
  | Nat.succ n' => MyNat.succ (nat_to_mynat n')

instance : OfNat MyNat n where
  ofNat := nat_to_mynat n

def mynat_to_nat (n : MyNat) : Nat :=
  match n with
  | MyNat.zero => Nat.zero
  | MyNat.succ n' => Nat.succ (mynat_to_nat n')

def add (m : MyNat) (n : MyNat) : MyNat :=
  match n with
  | zero => m
  | succ n' => succ (add m n')

example : add 7 8 = 15 := rfl
def mul (m n : MyNat) : MyNat :=
  match n with
  | zero => zero
  | succ (zero) => m
  | succ n' => add m (mul m n')

example : mul 4 3 = 12 := rfl
example : mul 4 0 = 0 := rfl
example : mul 0 4 = 0 := rfl
example : mul 4 1 = 4 := rfl
