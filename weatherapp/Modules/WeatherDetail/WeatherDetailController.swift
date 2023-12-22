import Foundation
import UIKit

enum WeatherDetailState: CultureRxState {
	case viewDidLoad
}


final class WeatherDetailController: CultureRxViewController<WeatherDetailView, WeatherDetailViewModel, WeatherDetailState> {
	override func viewDidLoad() {
		setUpNavBar()
		
		view.backgroundColor = .random()
		state = .viewDidLoad
	}
	
	func setUpNavBar() {
		self.navigationItem.title = "Прогноз"
		let backButton = UIBarButtonItem()
		backButton.tintColor = .black
		self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
	}
}
