import Mathlib.Data.Real.Basic

-- ref: https://www.youtube.com/watch?v=s9Dyiu4S4vA&list=PLX21uJ4UfpF43NExUcPcAEgnzV58x_26l&index=1

theorem Boyle {P1 P2 V1 V2 T1 T2 n1 n2 R : ℝ }
(h1: P1*V1 = n1*R*T1)
(h2: P2*V2 = n2*R*T2)
(h3: T1 = T2)
(h4: n1 = n2) :
(P1*V1 = P2*V2) := by
  rw [h3] at h1
  rw [h4] at h1
  rw [← h2] at h1
  exact h1

-- example {x y : ℝ}
--   _ = (90 + 150) / 2 := by rw []
--  _ = 120 := by ring
