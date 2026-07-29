import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.MagnetohydrodynamicsElectrohydrodynamicsLemmaCanonicalLaneLean.RegularityEndpointLayer

namespace HautevilleHouse
namespace MagnetohydrodynamicsElectrohydrodynamicsLemmaCanonicalLaneLean

structure MHDAnalyticCertificate where
  substrate : MathlibPDESubstrate
  operatorsClosed : Prop
  weakLayerClosed : Prop
  energyLayerClosed : Prop
  compactnessLayerClosed : Prop
  endpointLayerClosed : Prop
  canonicalCarriageImported : Prop
  operatorsClosedProof : operatorsClosed
  weakLayerClosedProof : weakLayerClosed
  energyLayerClosedProof : energyLayerClosed
  compactnessLayerClosedProof : compactnessLayerClosed
  endpointLayerClosedProof : endpointLayerClosed
  canonicalCarriageImportedProof : canonicalCarriageImported

def sourceMHDAnalyticCertificate : MHDAnalyticCertificate :=
  { substrate := mathlibPDESubstrate,
    operatorsClosed := LandauLifshitzEquationClosed primitiveFlow,
    weakLayerClosed := LerayHopfEnvelopeClosed sourceLerayHopfEnvelope,
    energyLayerClosed := EnergyEnstrophyClosed sourceEnergyEnstrophyCertificate,
    compactnessLayerClosed := CompactnessRigidityClosed sourceCompactnessRigidityCertificate,
    endpointLayerClosed := RegularityEndpointClosed sourceRegularityEndpointCertificate,
    canonicalCarriageImported := commonCoreProjectionLawAvailable ∧ commonCoreCarriageLawAvailable ∧ commonCoreIdempotenceAvailable,
    operatorsClosedProof := rfl,
    weakLayerClosedProof := source_leray_hopf_envelope_closed,
    energyLayerClosedProof := source_energy_enstrophy_closed,
    compactnessLayerClosedProof := source_compactness_rigidity_closed,
    endpointLayerClosedProof := source_regularity_endpoint_closed,
    canonicalCarriageImportedProof := And.intro mathlib_common_core_projection_law_checked
      (And.intro mathlib_common_core_carriage_law_checked mathlib_common_core_idempotence_checked)
  }

def MHDAnalyticCertificateClosed (C : MHDAnalyticCertificate) : Prop :=
  C.operatorsClosed ∧
  C.weakLayerClosed ∧
  C.energyLayerClosed ∧
  C.compactnessLayerClosed ∧
  C.endpointLayerClosed ∧
  C.canonicalCarriageImported

theorem source_mhd_analytic_certificate_closed :
    MHDAnalyticCertificateClosed sourceMHDAnalyticCertificate := by
  exact And.intro sourceMHDAnalyticCertificate.operatorsClosedProof
    (And.intro sourceMHDAnalyticCertificate.weakLayerClosedProof
      (And.intro sourceMHDAnalyticCertificate.energyLayerClosedProof
        (And.intro sourceMHDAnalyticCertificate.compactnessLayerClosedProof
          (And.intro sourceMHDAnalyticCertificate.endpointLayerClosedProof
            sourceMHDAnalyticCertificate.canonicalCarriageImportedProof))))

end MagnetohydrodynamicsElectrohydrodynamicsLemmaCanonicalLaneLean
end HautevilleHouse