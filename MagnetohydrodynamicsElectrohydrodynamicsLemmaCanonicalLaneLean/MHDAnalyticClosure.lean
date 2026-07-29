import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.MagnetohydrodynamicsElectrohydrodynamicsLemmaCanonicalLaneLean.MHDAnalyticCertificate

namespace HautevilleHouse
namespace MagnetohydrodynamicsElectrohydrodynamicsLemmaCanonicalLaneLean

def MHDAdmittedAnalyticClosure : Prop :=
  MHDAnalyticCertificateClosed sourceMHDAnalyticCertificate ∧
  ConstrainedTheoremClosure analyticAdmissibleClass

def UnrestrictedClassicalMHDBoundaryCarried : Prop :=
  formalizationCertificate.theoremBoundaryOpen = true ∧
  mathlibPDESubstrate.unrestrictedMHDStackCarried = true

theorem mhd_admitted_analytic_closure_checked :
    MHDAdmittedAnalyticClosure := by
  exact And.intro source_mhd_analytic_certificate_closed
    (constrained_theorem_closure analyticAdmissibleClass)

theorem unrestricted_classical_mhd_boundary_carried_checked :
    UnrestrictedClassicalMHDBoundaryCarried := by
  exact And.intro rfl rfl

end MagnetohydrodynamicsElectrohydrodynamicsLemmaCanonicalLaneLean
end HautevilleHouse