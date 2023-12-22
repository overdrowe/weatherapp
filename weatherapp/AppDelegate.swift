import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	var window: UIWindow?
	var navVC: UINavigationController?
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
				
		let window = UIWindow(frame: UIScreen.main.bounds)
		window.makeKeyAndVisible()
		
		navVC = UINavigationController(rootViewController: MainBuilder.build(routeHandler: mainRouter))
		window.rootViewController = navVC
		
		self.window = window
		
		return true
	}
}

// MARK: -
private extension AppDelegate {
	func mainRouter(route: MainOutputRoute) {
		switch route {
			case let .openDetail(weather):
			navVC?.pushViewController(WeatherDetailBuilder.build(parameters: .init(weather: weather)), animated: true)
		}
	}
}
