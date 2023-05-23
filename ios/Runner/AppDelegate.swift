import UIKit
import Flutter
import GoogleMaps
import FirebaseMessaging
import FirebaseCore

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey("AIzaSyB9OR6cl3V5rpopzLWgQsaiRFyUd2MGCJE")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

}