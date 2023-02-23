package app.cash.security_sdk.internal.providers

import app.cash.security_sdk.internal.TrifleAlgorithmIdentifier.ECDSASha256AlgorithmIdentifier
import com.google.crypto.tink.signature.SignatureConfig
import org.bouncycastle.asn1.x509.SubjectPublicKeyInfo
import org.junit.jupiter.api.Assertions
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import java.security.KeyPair
import java.security.KeyPairGenerator
import java.security.PrivateKey
import java.security.SecureRandom
import java.security.Signature
import java.security.spec.ECGenParameterSpec

internal class BCContentVerifierProviderTest {
  private val data = byteArrayOf(0x00, 0x01, 0x02, 0x03)
  private lateinit var privateSignKey: PrivateKey
  private lateinit var contentVerifierProvider: BCContentVerifierProvider

  @BeforeEach
  fun setUp() {
    SignatureConfig.register()
    val ecSpec = ECGenParameterSpec("secp256r1")
    val generator = KeyPairGenerator.getInstance("EC")
    generator.initialize(ecSpec, SecureRandom())

    val keypair: KeyPair = generator.generateKeyPair()
    privateSignKey = keypair.private

    contentVerifierProvider = BCContentVerifierProvider(
      SubjectPublicKeyInfo.getInstance(keypair.public.encoded)
    )
  }

  @Test
  fun `test get() returns content verifier with appropriate key`() {
    val bcContentVerifier = contentVerifierProvider.get(ECDSASha256AlgorithmIdentifier)
    bcContentVerifier.outputStream.write(data)

    val signature = Signature.getInstance("SHA256withECDSA")
    signature.initSign(privateSignKey)
    signature.update(data)

    Assertions.assertTrue(bcContentVerifier.verify(signature.sign()))
  }

  @Test
  fun `test getAssociatedCertificate`() {
    Assertions.assertNull(contentVerifierProvider.associatedCertificate)
  }
}