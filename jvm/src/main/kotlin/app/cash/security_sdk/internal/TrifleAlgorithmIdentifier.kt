package app.cash.security_sdk.internal

import org.bouncycastle.asn1.ASN1ObjectIdentifier
import org.bouncycastle.asn1.x509.AlgorithmIdentifier

sealed class TrifleAlgorithmIdentifier(
  oid: String,
  params: TrifleAlgorithmIdentifier? = null
) : AlgorithmIdentifier(ASN1ObjectIdentifier(oid), params) {
  // Defined in https://www.rfc-editor.org/rfc/rfc8420
  // Registry http://oid-info.com/cgi-bin/display?oid=1.3.101.112&a=display
  // TODO(dcashman): Define a custom OID based on tink primitives.
  object TinkAlgorithmIdentifier: TrifleAlgorithmIdentifier("1.3.101.112")

  // Defined in https://datatracker.ietf.org/doc/html/draft-josefsson-pkix-newcurves-01
  // Registry http://oid-info.com/cgi-bin/display?oid=1.3.6.1.4.1.11591.15.1&a=display
  object Ed25519AlgorithmIdentifier: TrifleAlgorithmIdentifier("1.3.6.1.4.1.11591.15.1")

  // Defined in https://www.rfc-editor.org/rfc/rfc5480
  // Registry http://oid-info.com/cgi-bin/display?oid=1.2.840.10045.3.1.7&a=display
  object P256v1AlgorithmIdentifier: TrifleAlgorithmIdentifier("1.2.840.10045.3.1.7")

  // Defined in https://www.rfc-editor.org/rfc/rfc3279
  // Registry http://oid-info.com/cgi-bin/display?oid=1.2.840.10045.2.1&a=display
  class ECPublicKeyAlgorithmIdentifier(curve: TrifleAlgorithmIdentifier)
    : TrifleAlgorithmIdentifier(oid = "1.2.840.10045.2.1", params = curve)
}
