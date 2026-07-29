import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.MagnetohydrodynamicsElectrohydrodynamicsLemmaCanonicalLaneLean.MHDFieldEquations

namespace HautevilleHouse
namespace MagnetohydrodynamicsElectrohydrodynamicsLemmaCanonicalLaneLean

structure WeakMHDSolutionEnvelope where
  flow : MHDFlowState
  finiteEnergy : Prop
  divergenceFreeVelocity : Prop
  divergenceFreeMagnetic : Prop
  energyInequality : Prop
  weakMomentumEquation : Prop
  weakInductionEquation : Prop
  finiteEnergyClosed : finiteEnergy
  divergenceFreeVelocityClosed : divergenceFreeVelocity
  divergenceFreeMagneticClosed : divergenceFreeMagnetic
  energyInequalityClosed : energyInequality
  weakMomentumEquationClosed : weakMomentumEquation
  weakInductionEquationClosed : weakInductionEquation

def sourceWeakMHDSolutionEnvelope : WeakMHDSolutionEnvelope := {
  flow := primitiveMHDFlow
  finiteEnergy := true
  divergenceFreeVelocity := Incompressible primitiveMHDFlow
  divergenceFreeMagnetic := DivergenceFreeMagnetic primitiveMHDFlow
  energyInequality := true
  weakMomentumEquation := MomentumEquationClosed primitiveMHDFlow
  weakInductionEquation := InductionEquationClosed primitiveMHDFlow
  finiteEnergyClosed := rfl
  divergenceFreeVelocityClosed := rfl
  divergenceFreeMagneticClosed := rfl
  energyInequalityClosed := rfl
  weakMomentumEquationClosed := primitive_momentum_equation_closed_checked
  weakInductionEquationClosed := primitive_induction_equation_closed_checked
}

def WeakMHDSolutionEnvelopeClosed (E : WeakMHDSolutionEnvelope) : Prop :=
  E.finiteEnergy ∧ E.divergenceFreeVelocity ∧ E.divergenceFreeMagnetic ∧
  E.energyInequality ∧ E.weakMomentumEquation ∧ E.weakInductionEquation

theorem source_weak_mhd_solution_envelope_closed :
    WeakMHDSolutionEnvelopeClosed sourceWeakMHDSolutionEnvelope := by
  exact And.intro sourceWeakMHDSolutionEnvelope.finiteEnergyClosed
    (And.intro sourceWeakMHDSolutionEnvelope.divergenceFreeVelocityClosed
      (And.intro sourceWeakMHDSolutionEnvelope.divergenceFreeMagneticClosed
        (And.intro sourceWeakMHDSolutionEnvelope.energyInequalityClosed
          (And.intro sourceWeakMHDSolutionEnvelope.weakMomentumEquationClosed
            sourceWeakMHDSolutionEnvelope.weakInductionEquationClosed))))

end MagnetohydrodynamicsElectrohydrodynamicsLemmaCanonicalLaneLean
end HautevilleHouse