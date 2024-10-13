import Flutter
import UIKit
import GoogleMaps


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    //  GMSServices.provideAPIKey("YAIzaSyD9VG43rxjkFydYD1UmVRiX4aq1nC")
     GMSServices.provideAPIKey("AIzaSyAtq0J6XXzeUg63eLHZ_kZBqmf9MBk8G5g")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
