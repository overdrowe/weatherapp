import UIKit

enum MainViewState: CultureRxState {
	case viewDidLoad
}

final class MainViewController: CultureRxViewController<MainView, MainViewModel, MainViewState> {

	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.largeTitleDisplayMode = .never
		navigationItem.title = "Погода"
		
		let invert = UIBarButtonItem(
			image: UIImage(systemName: "arrow.up.arrow.down"),
			style: .done,
			target: self,
			action: #selector(invertAction)
		)

		navigationItem.rightBarButtonItems = [invert]
		
		state = .viewDidLoad
	}
	
	@objc private func invertAction() {
		model.event = .reverseList
	}
}
