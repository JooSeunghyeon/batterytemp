import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
    println("🔑 Keystore properties loaded:")
    println("  storeFile: ${keystoreProperties.getProperty("storeFile")}")
    println("  keyAlias: ${keystoreProperties.getProperty("keyAlias")}")
    println("  storePassword: ${if (keystoreProperties.getProperty("storePassword") != null) "✓" else "✗"}")
    println("  keyPassword: ${if (keystoreProperties.getProperty("keyPassword") != null) "✓" else "✗"}")
} else {
    println("❌ key.properties file not found!")
}

android {
    namespace = "com.juseunghyeon.batterytemp"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    signingConfigs {
        create("release") {
            val storeFileProperty = keystoreProperties.getProperty("storeFile")
            val keyAliasProperty = keystoreProperties.getProperty("keyAlias")
            val keyPasswordProperty = keystoreProperties.getProperty("keyPassword")
            val storePasswordProperty = keystoreProperties.getProperty("storePassword")
            
            println("🔧 Setting up signing config:")
            println("  storeFile: $storeFileProperty")
            println("  keyAlias: $keyAliasProperty")
            
            if (storeFileProperty != null && keyAliasProperty != null && 
                keyPasswordProperty != null && storePasswordProperty != null) {
                keyAlias = keyAliasProperty
                keyPassword = keyPasswordProperty
                storeFile = file(storeFileProperty)
                storePassword = storePasswordProperty
                println("✅ Signing config set successfully!")
            } else {
                println("❌ Some signing properties are null!")
            }
        }
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.juseunghyeon.batterytemp"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
        }
    }
}

flutter {
    source = "../.."
}
