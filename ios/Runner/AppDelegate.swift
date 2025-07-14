import UIKit
import Flutter
import GoogleMaps
import Firebase

@main
@objc class AppDelegate: FlutterAppDelegate {
 
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
   
    GMSServices.provideAPIKey("AIzaSyATbPpXTjnk535Ntl9H-2CuVk_An46zPQ0")
       FirebaseApp.configure()
       
       GeneratedPluginRegistrant.register(with: self)
        // application.registerForRemoteNotifications()
    if #available(iOS 12.0, *) {
      UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }
   
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
