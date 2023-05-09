plugins {
  id("com.android.application")
  id("kotlin-android")
}

android {
  compileSdkVersion(33)

    defaultConfig {
    applicationId = "app.cash.trifle"
    minSdkVersion(24)
    targetSdkVersion(33)
    versionCode = 1
    versionName = "1.0"

    testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
  }

  buildTypes {
    getByName("release") {
      isMinifyEnabled = false
      proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
    }
  }
  compileOptions {
    sourceCompatibility = JavaVersion.VERSION_11
    targetCompatibility = JavaVersion.VERSION_11
  }
}

dependencies {
  implementation("androidx.core:core-ktx:1.9.0")
  implementation("androidx.appcompat:appcompat:1.6.0")
  implementation("com.google.android.material:material:1.8.0")
  implementation("androidx.constraintlayout:constraintlayout:2.1.4")
  implementation(project(":android:trifle"))
  testImplementation("junit:junit:4.+")
  androidTestImplementation("androidx.test.ext:junit:1.1.5")
  androidTestImplementation("androidx.test.espresso:espresso-core:3.5.1")
}