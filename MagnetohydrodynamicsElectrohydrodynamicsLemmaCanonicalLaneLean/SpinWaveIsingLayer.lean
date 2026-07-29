import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.MagnetohydrodynamicsElectrohydrodynamicsLemmaCanonicalLaneLean.LandauLifshitzOperator

namespace HautevilleHouse
namespace MagnetohydrodynamicsElectrohydrodynamicsLemmaCanonicalLaneLean

structure SpinWaveCertificate where
  flow : MagneticFlow
  dispersionClosed : Prop
  exchangeClosed : Prop
  anisotropyClosed : Prop
  dampingClosed : Prop
  dispersionClosedProof : dispersionClosed
  exchangeClosedProof : exchangeClosed
  anisotropyClosedProof : anisotropyClosed
  dampingClosedProof : dampingClosed

def sourceSpinWaveCertificate : SpinWaveCertificate := {
  flow := primitiveMagneticFlow
  dispersionClosed := spinWaveDispersion 0.1 1.0 0.5 = 1.0 + 0.5 * (0.1^2)
  exchangeClosed := defaultParams.exchangeConstant = 1.0
  anisotropyClosed := defaultMagnetismOperators.anisotropyConstant = 0.1
  dampingClosed := defaultParams.dampingConstant = 0.01
  dispersionClosedProof := by native_decide
  exchangeClosedProof := rfl
  anisotropyClosedProof := rfl
  dampingClosedProof := rfl
}

structure IsingCertificate where
  flow : MagneticFlow
  interactionEnergy : ℝ → ℝ
  interactionClosed : Prop
  criticalTemperature : ℝ
  orderParameter : ℝ
  interactionClosedProof : interactionClosed

def sourceIsingCertificate : IsingCertificate := {
  flow := primitiveMagneticFlow
  interactionEnergy := fun J => isingInteraction (fun i => 1) J
  interactionClosed := isingInteraction (fun _ => 1) 1.0 = 1.0 * (1*1 + 1*1 + 1*1)
  criticalTemperature := 2.269185
  orderParameter := 0.0
  interactionClosedProof := by native_decide
}

def SpinWaveLayerClosed (C : SpinWaveCertificate) : Prop :=
  C.dispersionClosed ∧ C.exchangeClosed ∧ C.anisotropyClosed ∧ C.dampingClosed

def IsingLayerClosed (C : IsingCertificate) : Prop :=
  C.interactionClosed

theorem source_spin_wave_layer_closed : SpinWaveLayerClosed sourceSpinWaveCertificate := by
  exact And.intro sourceSpinWaveCertificate.dispersionClosedProof
    (And.intro sourceSpinWaveCertificate.exchangeClosedProof
      (And.intro sourceSpinWaveCertificate.anisotropyClosedProof sourceSpinWaveCertificate.dampingClosedProof))

theorem source_ising_layer_closed : IsingLayerClosed sourceIsingCertificate := by
  exact sourceIsingCertificate.interactionClosedProof

end MagnetohydrodynamicsElectrohydrodynamicsLemmaCanonicalLaneLean
end HautevilleHouse