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
		
		state = .viewDidLoad
	}
}
