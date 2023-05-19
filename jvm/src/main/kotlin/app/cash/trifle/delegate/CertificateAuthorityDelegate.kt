package app.cash.trifle.delegate

import app.cash.trifle.Certificate
import app.cash.trifle.CertificateRequest
import java.time.Period

interface CertificateAuthorityDelegate {
  /**
   * Creates a self-signed certificate with the provided key and name.
   *
   * @param entityName the name with which we'll associate the public key.
   * @param validityPeriod the length of time for which this certificate should be accepted after
   * issuance.
   */
  fun createRootSigningCertificate(
    entityName: String,
    validityPeriod: Period,
  ): Certificate

  /**
   * Signs CertificateRequest using the provided trifle content signer and issuing certificate.
   *
   * @param issuerCertificate trifle certificate associated with the signer of this cert.
   * @param certificateRequest certificate request used to generate a new certificate
   */
  fun signCertificate(
    issuerCertificate: Certificate,
    certificateRequest: CertificateRequest,
  ): Certificate
}