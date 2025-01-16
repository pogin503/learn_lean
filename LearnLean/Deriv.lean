import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Data.Real.Basic

-- 関数をラムダ式で定義
def f (x : ℝ) : ℝ := x^2 + 3 * x + 1

-- 導関数を計算
-- #eval deriv f 2  -- x = 2 での f'(x) の値
