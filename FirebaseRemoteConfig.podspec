Pod::Spec.new do |s|
  s.name             = 'FirebaseRemoteConfig'
  s.version          = '8.11.0'
  s.summary          = 'Firebase Remote Config'

  s.description      = <<-DESC
Firebase Remote Config is a cloud service that lets you change the
appearance and behavior of your app without requiring users to download an
app update.
                       DESC

  s.homepage         = 'https://firebase.google.com'
  s.license          = { :type => 'Apache', :file => 'LICENSE' }
  s.authors          = 'Google, Inc.'

  s.source           = {
    :git => 'https://github.com/firebase/firebase-ios-sdk.git',
    :tag => 'CocoaPods-' + s.version.to_s
  }
  s.social_media_url = 'https://twitter.com/Firebase'
  ios_deployment_target = '10.0'
  osx_deployment_target = '10.12'
  tvos_deployment_target = '10.0'
  watchos_deployment_target = '6.0'

  s.ios.deployment_target = ios_deployment_target
  s.osx.deployment_target = osx_deployment_target
  s.tvos.deployment_target = tvos_deployment_target
  s.watchos.deployment_target = watchos_deployment_target

  s.cocoapods_version = '>= 1.4.0'
  s.prefix_header_file = false

  base_dir = "FirebaseRemoteConfig/Sources/"
  s.source_files = [
    base_dir + '**/*.[mh]',
    'Interop/Analytics/Public/*.h',
    'FirebaseABTesting/Sources/Private/*.h',
    'FirebaseCore/Sources/Private/*.h',
    'FirebaseInstallations/Source/Library/Private/*.h',
  ]
  s.public_header_files = base_dir + 'Public/FirebaseRemoteConfig/*.h'
  s.pod_target_xcconfig = {
    'GCC_C_LANGUAGE_STANDARD' => 'c99',
    'HEADER_SEARCH_PATHS' => '"${PODS_TARGET_SRCROOT}"'
  }
  s.dependency 'FirebaseABTesting', '~> 8.0'
  s.dependency 'FirebaseCore', '~> 8.0'
  s.dependency 'FirebaseInstallations', '~> 8.0'
  s.dependency 'GoogleUtilities/Environment', '~> 7.7'
  s.dependency 'GoogleUtilities/NSData+zlib', '~> 7.7'

  s.test_spec 'unit' do |unit_tests|
    unit_tests.scheme = { :code_coverage => true }
    # TODO(dmandar) - Update or delete the commented files.
    unit_tests.source_files =
        'FirebaseRemoteConfig/Tests/Unit/FIRRemoteConfigComponentTest.m',
        'FirebaseRemoteConfig/Tests/Unit/RCNConfigContentTest.m',
        'FirebaseRemoteConfig/Tests/Unit/RCNConfigDBManagerTest.m',
#        'FirebaseRemoteConfig/Tests/Unit/RCNConfigSettingsTest.m',
#        'FirebaseRemoteConfig/Tests/Unit/RCNConfigTest.m',
        'FirebaseRemoteConfig/Tests/Unit/RCNConfigExperimentTest.m',
        'FirebaseRemoteConfig/Tests/Unit/RCNConfigValueTest.m',
        'FirebaseRemoteConfig/Tests/Unit/RCNPersonalizationTest.m',
#        'FirebaseRemoteConfig/Tests/Unit/RCNRemoteConfig+FIRAppTest.m',
        'FirebaseRemoteConfig/Tests/Unit/RCNRemoteConfigTest.m',
#        'FirebaseRemoteConfig/Tests/Unit/RCNThrottlingTests.m',
        'FirebaseRemoteConfig/Tests/Unit/RCNTestUtilities.m',
        'FirebaseRemoteConfig/Tests/Unit/RCNUserDefaultsManagerTests.m',
        'FirebaseRemoteConfig/Tests/Unit/RCNTestUtilities.h',
        'FirebaseRemoteConfig/Tests/Unit/RCNInstanceIDTest.m'
    # Supply plist custom plist testing.
    unit_tests.resources =
        'FirebaseRemoteConfig/Tests/Unit/Defaults-testInfo.plist',
        'FirebaseRemoteConfig/Tests/Unit/SecondApp-GoogleService-Info.plist',
        'FirebaseRemoteConfig/Tests/Unit/TestABTPayload.txt'
    unit_tests.requires_app_host = true
    unit_tests.dependency 'OCMock'
    unit_tests.requires_arc = true
  end

  # Run Swift API tests on a real backend.
  s.test_spec 'swift-api-tests' do |swift_api|
    swift_api.scheme = { :code_coverage => true }
    swift_api.platforms = {
      :ios => ios_deployment_target,
      :osx => osx_deployment_target,
      :tvos => tvos_deployment_target
    }
    swift_api.source_files = 'FirebaseRemoteConfig/Tests/SwiftAPI/*.swift',
                             'FirebaseRemoteConfig/Tests/FakeUtils/*.[hm]',
                             'FirebaseRemoteConfig/Tests/FakeUtils/*.swift'
    swift_api.requires_app_host = true
    swift_api.pod_target_xcconfig = {
      'SWIFT_OBJC_BRIDGING_HEADER' => '$(PODS_TARGET_SRCROOT)/FirebaseRemoteConfig/Tests/FakeUtils/Bridging-Header.h'
    }
    swift_api.dependency 'OCMock'
  end

  # Run Swift API tests and tests requiring console changes on a Fake Console.
  s.test_spec 'fake-console-tests' do |fake_console|
    fake_console.scheme = { :code_coverage => true }
    fake_console.platforms = {
      :ios => ios_deployment_target,
      :osx => osx_deployment_target,
      :tvos => tvos_deployment_target
    }
    fake_console.source_files = 'FirebaseRemoteConfig/Tests/SwiftAPI/*.swift',
                                      'FirebaseRemoteConfig/Tests/FakeUtils/*.[hm]',
                                      'FirebaseRemoteConfig/Tests/FakeUtils/*.swift',
                                      'FirebaseRemoteConfig/Tests/FakeConsole/*.swift'
    fake_console.requires_app_host = true
    fake_console.pod_target_xcconfig = {
      'SWIFT_OBJC_BRIDGING_HEADER' => '$(PODS_TARGET_SRCROOT)/FirebaseRemoteConfig/Tests/FakeUtils/Bridging-Header.h'
    }
    fake_console.dependency 'OCMock'
  end
end
