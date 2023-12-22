import Foundation
import UIKit

public enum MainBuilder {
	static func build(routeHandler: @escaping (MainOutputRoute) -> Void ) -> UIViewController {
		let viewModel = MainViewModel()
		let controller = MainViewController(viewModel: viewModel)
		viewModel.view = controller
		
		viewModel.$route
			.compactMap { $0 }
			.subscribe { routeHandler($0) }
//			.dispose()
		
		return controller
	}
}
