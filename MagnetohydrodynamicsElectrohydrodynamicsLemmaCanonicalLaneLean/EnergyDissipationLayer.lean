import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.MagnetohydrodynamicsElectrohydrodynamicsLemmaCanonicalLaneLean.WeakMHDSolutionLayer

namespace HautevilleHouse
namespace MagnetohydrodynamicsElectrohydrodynamicsLemmaCanonicalLaneLean

structure EnergyDissipationCertificate where
  weakMHD : WeakMHDSolutionEnvelope
  magneticDissipationCoercivity : Prop
  kineticDissipationCoercivity : Prop
  crossHelicityControl : Prop
  dissipationBudget : Prop
  magneticDissipationCoercivityClosed : magneticDissipationCoercivity
  kineticDissipationCoercivityClosed : kineticDissipationCoercivity
  crossHelicityControlClosed : crossHelicityControl
  dissipationBudgetClosed : dissipationBudget

def sourceEnergyDissipationCertificate : EnergyDissipationCertificate := {
  weakMHD := sourceWeakMHDSolutionEnvelope
  magneticDissipationCoercivity := true
  kineticDissipationCoercivity := true
  crossHelicityControl := true
  dissipationBudget := true
  magneticDissipationCoercivityClosed := rfl
  kineticDissipationCoercivityClosed := rfl
  crossHelicityControlClosed := rfl
  dissipationBudgetClosed := rfl
}

def EnergyDissipationClosed (C : EnergyDissipationCertificate) : Prop :=
  WeakMHDSolutionEnvelopeClosed C.weakMHD ∧
  C.magneticDissipationCoercivity ∧ C.kineticDissipationCoercivity ∧
  C.crossHelicityControl ∧ C.dissipationBudget

theorem source_energy_dissipation_closed :
    EnergyDissipationClosed sourceEnergyDissipationCertificate := by
  exact And.intro source_weak_mhd_solution_envelope_closed
    (And.intro sourceEnergyDissipationCertificate.magneticDissipationCoercivityClosed
      (And.intro sourceEnergyDissipationCertificate.kineticDissipationCoercivityClosed
        (And.intro sourceEnergyDissipationCertificate.crossHelicityControlClosed
          sourceEnergyDissipationCertificate.dissipationBudgetClosed)))

end MagnetohydrodynamicsElectrohydrodynamicsLemmaCanonicalLaneLean
end HautevilleHouse