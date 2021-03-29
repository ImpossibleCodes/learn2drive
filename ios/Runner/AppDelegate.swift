import UIKit
import Flutter
import GoogleMaps
import background_locator

func registerPlugins(registry: FlutterPluginRegistry) -> () {
    if (!registry.hasPlugin("BackgroundLocatorPlugin")) {
        GeneratedPluginRegistrant.register(with: registry)
    }
}

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    BackgroundLocatorPlugin.setPluginRegistrantCallback(registerPlugins)
    GMSServices.provideAPIKey("AIzaSyD8s0bE1jXNtDy03vtEjM38xwf4xCuBf5s")

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
