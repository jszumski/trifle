package app.cash.security_sdk

class LibraryVersion : Version {
  private val recordedVersion: String = "${BuildConfig.VERSION_CODE}.${BuildConfig.VERSION_NAME}"

  override fun complete(): String = recordedVersion

  override fun major(): Int = recordedVersion.split('.').firstOrNull()?.toInt() ?: -1

  override fun minor(): Int = recordedVersion.split('.').elementAtOrNull(1)?.toInt() ?: -1
}