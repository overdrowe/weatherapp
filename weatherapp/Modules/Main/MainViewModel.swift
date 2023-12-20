import Foundation
import RxSwift
import UIKit

public enum MainOutputRoute: CultureRxOutputRoute {
	case openDetail(String)
}

class MainViewModel: CultureRxViewModel<MainViewController, MainViewState, MainOutputRoute> {
	override var viewStateSubject: Observable<MainViewState?> { view.$state }
	private let model = MainModel(cities: ["Ufa", "Moscow", "Krasnodar"])
	
	private var counter = 0
	
	override func viewStateChanged(_ state: MainViewState) {
		switch state {
		case .viewDidLoad:
			view.model.cities = model.cities
			observeEvents(view.model.$event, callback: observeViewEvents)
			break
		}
	}
}

// MARK: - Private
private extension MainViewModel {
	func observeViewEvents(event: MainViewConfig.Event) {
		switch event {
		case .listReordered:
//			view.model.text = "Уфа \(counter)"
			print("нажатие \(counter)")
			counter += 1
			
			guard let cities = view.model.cities else { return }
			model.cities = cities
		}
	}
}

