import Foundation
import RxSwift

public enum WeatherDetailOutputRoute: CultureRxOutputRoute { }

final class WeatherDetailViewModel: CultureRxViewModel<WeatherDetailController, WeatherDetailState, WeatherDetailOutputRoute> {
	override var viewStateSubject: Observable<WeatherDetailState?> { view.$state }
	
	var weather: Weather
	
	init(weather: Weather) {
		self.weather = weather
	}
	
	override func viewStateChanged(_ state: WeatherDetailState) {
		super.viewStateChanged(state)
		
		switch state {
		case .viewDidLoad:
			view.model.weather = weather
			observeEvents(view.model.$event, callback: observeViewEvents)
		}
	}
}

// MARK: - Private
private extension WeatherDetailViewModel {
	func observeViewEvents(event: WeatherDetailViewConfig.Event) {
		switch event {
		case let .daySelected(index):
			view.model.currentIndex = index
		}
	}
}
