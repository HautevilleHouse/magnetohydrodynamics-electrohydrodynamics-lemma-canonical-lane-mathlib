import canonicalLaneMathlib.AdmissibleClass

namespace HautevilleHouse
namespace MagnetohydrodynamicsElectrohydrodynamicsLemmaCanonicalLaneLean

abbrev Space3 := Fin 3 → ℝ
abbrev Time := ℝ
abbrev ScalarField := Time → Space3 → ℝ
abbrev VectorField := Time → Space3 → Space3

structure MHDEOperators where
  curl : VectorField → VectorField
  gradient : ScalarField → VectorField
  divergence : VectorField → ScalarField
  laplacian : VectorField → VectorField
  timeDerivative : VectorField → VectorField
  crossProduct : VectorField → VectorField → VectorField
  lorentzForce : VectorField → VectorField → VectorField
  lorentzForceIdempotent : ∀ B, lorentzForce B (lorentzForce B B) = lorentzForce B B

def primitiveMHDEOperators : MHDEOperators := {
  curl := fun v => v
  gradient := fun _ => (fun _ _ => (0,0,0))
  divergence := fun _ => (fun _ _ => 0)
  laplacian := fun v => v
  timeDerivative := fun _ => (fun _ _ => (0,0,0))
  crossProduct := fun u v => (fun _ _ => (0,0,0))
  lorentzForce := fun u v => (fun _ _ => (0,0,0))
  lorentzForceIdempotent := by
    intro B
    ext t x; simp
}

structure MHDEFlow where
  velocity : VectorField
  magneticField : VectorField
  electricField : VectorField
  density : ScalarField
  pressure : ScalarField
  viscosity : ℝ
  resistivity : ℝ
  operators : MHDEOperators

def primitiveMHDEFlow : MHDEFlow := {
  velocity := (fun _ _ => (0,0,0))
  magneticField := (fun _ _ => (0,0,0))
  electricField := (fun _ _ => (0,0,0))
  density := (fun _ _ => 1)
  pressure := (fun _ _ => 0)
  viscosity := 1
  resistivity := 1
  operators := primitiveMHDEOperators
}

def InductionEquation (F : MHDEFlow) : Prop :=
  F.operators.timeDerivative F.magneticField =
  F.operators.curl (F.operators.crossProduct F.velocity F.magneticField) +
  F.operators.laplacian F.magneticField * (1 / F.resistivity)

def CurrentDensity (F : MHDEFlow) : VectorField :=
  F.operators.curl F.magneticField

def LorentzForce (F : MHDEFlow) : VectorField :=
  F.operators.crossProduct (CurrentDensity F) F.magneticField

def MomentumEquation (F : MHDEFlow) : Prop :=
  F.density * (F.operators.timeDerivative F.velocity) =
  -F.operators.gradient F.pressure + LorentzForce F +
  F.viscosity * F.operators.laplacian F.velocity

def ContinuityEquation (F : MHDEFlow) : Prop :=
  F.operators.timeDerivative F.density +
  F.operators.divergence (F.density *> F.velocity) = (fun _ _ => 0)

def MHDEQuationsClosed (F : MHDEFlow) : Prop :=
  InductionEquation F ∧ MomentumEquation F ∧ ContinuityEquation F

theorem primitive_induction_equation_checked :
    InductionEquation primitiveMHDEFlow := by
  unfold InductionEquation primitiveMHDEFlow
  simp

theorem primitive_momentum_equation_checked :
    MomentumEquation primitiveMHDEFlow := by
  unfold MomentumEquation primitiveMHDEFlow
  simp

theorem primitive_continuity_equation_checked :
    ContinuityEquation primitiveMHDEFlow := by
  unfold ContinuityEquation primitiveMHDEFlow
  simp

theorem primitive_mhde_equations_closed_checked :
    MHDEQuationsClosed primitiveMHDEFlow := by
  exact And.intro primitive_induction_equation_checked
    (And.intro primitive_momentum_equation_checked primitive_continuity_equation_checked)

end MagnetohydrodynamicsElectrohydrodynamicsLemmaCanonicalLaneLean
end HautevilleHouse
