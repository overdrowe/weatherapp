import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	var window: UIWindow?
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
				
		let window = UIWindow(frame: UIScreen.main.bounds)
		window.makeKeyAndVisible()
		
		let navVC = UINavigationController(rootViewController: MainBuilder.build())
		window.rootViewController = navVC
		
		self.window = window
		
		return true
	}
}
