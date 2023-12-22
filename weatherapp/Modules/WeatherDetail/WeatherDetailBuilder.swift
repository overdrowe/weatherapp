import Foundation
import UIKit

final class WeatherDetailBuilder {
	struct Parameters {
		let weather: Weather
	}
	
	static func build(parameters: Parameters) -> UIViewController {
		let viewModel = WeatherDetailViewModel(weather: parameters.weather)
		let controller = WeatherDetailController(viewModel: viewModel)
		viewModel.view = controller
		
		return controller
	}
}
