import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    // TODO: Do we need this?
    // var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // TODO: Do we need this?

        // window = UIWindow(frame: UIScreen.main.bounds)
        // window?.rootViewController = ViewController()
        // window?.makeKeyAndVisible()

        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}
