package app.cash.trifle

import android.security.keystore.KeyGenParameterSpec
import android.security.keystore.KeyProperties
import android.util.Log
import java.security.KeyPair
import java.security.KeyPairGenerator
import java.security.KeyStore
import java.security.spec.ECGenParameterSpec

class KeyHandle internal constructor(private val alias: String) {
  // Throw an illegal state exception if we can't get hold of the proper key material. This
  // *should never happen* since the only way to obtain a KeyHandle is to deserialize one, which
  // should have already checked for this, or to generate a new one.
  private val exceptionMessage =
    "Android KeyStore does not contain a keypair corresponding to the $alias alias"
  private val keyStore = KeyStore.getInstance(ANDROID_KEYSTORE_TYPE).apply {
    load(null)
  }

  init {
    if (!keyStore.containsAlias(alias)) {
      // Need to generate a new key for this key alias in the keystore.
      val kpg: KeyPairGenerator = KeyPairGenerator.getInstance(
        KeyProperties.KEY_ALGORITHM_EC,
        ANDROID_KEYSTORE_TYPE
      )
      val parameterSpec: KeyGenParameterSpec = KeyGenParameterSpec.Builder(
        alias,
        KeyProperties.PURPOSE_SIGN or KeyProperties.PURPOSE_VERIFY
      ).run {
        setAlgorithmParameterSpec(ECGenParameterSpec("secp256r1"))
        setUserAuthenticationRequired(false)
        setDigests(KeyProperties.DIGEST_SHA256, KeyProperties.DIGEST_SHA512)
        build()
      }

      kpg.initialize(parameterSpec)

      val kp = kpg.generateKeyPair()
      Log.i("TRIFLE", "Created KeyHandle with alias $alias")
    }
  }

  internal val keyPair: KeyPair by lazy {
    try {
      val entry: KeyStore.Entry = keyStore.getEntry(alias, null)
      if (entry is KeyStore.PrivateKeyEntry) {
        return@lazy KeyPair(entry.certificate.publicKey, entry.privateKey)
      }
    } catch (e: Exception) {
      throw IllegalStateException(exceptionMessage, e)
    }
    throw IllegalStateException(exceptionMessage)
  }

  fun serialize(): ByteArray = alias.toByteArray(Charsets.UTF_8)

  override fun equals(other: Any?): Boolean {
    val other = other as? KeyHandle ?: return false
    return alias == other.alias
  }

  override fun hashCode(): Int = alias.hashCode()

  companion object {
    private const val ANDROID_KEYSTORE_TYPE: String = "AndroidKeyStore"

    fun deserialize(bytes: ByteArray): KeyHandle {
      val alias = bytes.toString(Charsets.UTF_8)
      val ks = KeyStore.getInstance(ANDROID_KEYSTORE_TYPE).apply {
        load(null)
      }
      if (!ks.containsAlias(alias)) {
        throw IllegalArgumentException(
          "Android KeyStore does not contain a keypair corresponding to the $alias alias"
        )
      }
      return KeyHandle(alias)
    }

    //TODO(dcashman): Consoidate API surface with iOS surface.
    fun generateKeyHandle(alias: String): KeyHandle {
      return KeyHandle(alias)
    }
  }
}
