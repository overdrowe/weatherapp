import Foundation
import RxSwift
import UIKit

public enum MainOutputRoute: CultureRxOutputRoute {
	case openDetail(Weather)
}

class MainViewModel: CultureRxViewModel<MainViewController, MainViewState, MainOutputRoute> {
	override var viewStateSubject: Observable<MainViewState?> { view.$state }
	private let repository = WeatherRepository()
	private var model = MainModel(cities: [])
	
	override func viewStateChanged(_ state: MainViewState) {
		switch state {
		case .viewDidLoad:
			fetchWeather()
			observeEvents(view.model.$event, callback: observeViewEvents)
		}
	}
}

// MARK: - Private
private extension MainViewModel {
	func observeViewEvents(event: MainViewConfig.Event) {
		switch event {
		case .listReordered:
			break
		case .reverseList:
			model.cities = view.model.weatherList.reversed()
			view.model.weatherList = model.cities
		case let .openDetail(item):
//			print(item.name)
			route = .openDetail(item)
		}
	}
}

// MARK: - weather feetching
private extension MainViewModel {
	func fetchWeather() {
		repository.fetchWeather { items in
			self.view.model.weatherList = items
		}
	}
}
