import Foundation
import UIKit

public enum MainBuilder {
	static func build() -> UIViewController {
		let viewModel = MainViewModel()
		let controller = MainViewController(viewModel: viewModel)
		viewModel.view = controller
		
		return controller
	}
}
