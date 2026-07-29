import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.MagnetohydrodynamicsElectrohydrodynamicsLemmaCanonicalLaneLean.SpinWaveIsingLayer

namespace HautevilleHouse
namespace MagnetohydrodynamicsElectrohydrodynamicsLemmaCanonicalLaneLean

structure MHDEndpointCertificate where
  spinWave : SpinWaveCertificate
  ising : IsingCertificate
  landauLifshitzClosed : Prop
  mhdEquationsClosed : Prop
  domainWidthClosed : Prop
  landauLifshitzClosedProof : landauLifshitzClosed
  mhdEquationsClosedProof : mhdEquationsClosed
  domainWidthClosedProof : domainWidthClosed

def sourceMHDEndpointCertificate : MHDEndpointCertificate := {
  spinWave := sourceSpinWaveCertificate
  ising := sourceIsingCertificate
  landauLifshitzClosed := MagnetohydrodynamicBalance primitiveMagneticFlow
  mhdEquationsClosed := MHDEquationsClosed primitiveMagneticFlow
  domainWidthClosed := magneticDomainWidth 1.0 0.1 = Real.sqrt (1.0 / 0.1)
  landauLifshitzClosedProof := primitive_mhd_balance_checked
  mhdEquationsClosedProof := primitive_mhd_equations_closed_checked
  domainWidthClosedProof := by native_decide
}

def MHDEndpointClosed (C : MHDEndpointCertificate) : Prop :=
  SpinWaveLayerClosed C.spinWave ∧ IsingLayerClosed C.ising ∧
  C.landauLifshitzClosed ∧ C.mhdEquationsClosed ∧ C.domainWidthClosed

theorem source_mhd_endpoint_closed : MHDEndpointClosed sourceMHDEndpointCertificate := by
  exact And.intro source_spin_wave_layer_closed
    (And.intro source_ising_layer_closed
      (And.intro sourceMHDEndpointCertificate.landauLifshitzClosedProof
        (And.intro sourceMHDEndpointCertificate.mhdEquationsClosedProof sourceMHDEndpointCertificate.domainWidthClosedProof)))

end MagnetohydrodynamicsElectrohydrodynamicsLemmaCanonicalLaneLean
end HautevilleHouse