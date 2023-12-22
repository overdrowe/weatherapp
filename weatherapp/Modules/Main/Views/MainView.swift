import Foundation
import SnapKit
import RxSwift
import UIKit

class MainView: CultureRxView<MainViewConfig> {
	private lazy var collectionView: UICollectionView = {
		let collectionView = UICollectionView(
			frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height), 
			collectionViewLayout: UICollectionViewFlowLayout()
		)
		
//		collectionView.dataSource = self
		collectionView.delegate = self
//		collectionView.dragDelegate = self
		collectionView.register(CityCell.self, forCellWithReuseIdentifier: "CityCell")
		
		return collectionView
	}()
	
	override func addSubviews() {
		super.addSubviews()
		
		addSubviews(collectionView)
	}
	
	override func makeConstraints() {
		super.makeConstraints()
		
		collectionView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
	}
	
	override func prepareView() {
		super.prepareView()
		
		prepareCollectionView()
		
		let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture))
		collectionView.addGestureRecognizer(longPressGesture)
	}
	
	func prepareCollectionView() {
//		model.$weatherList.bind(to: collectionView.) { collectionView, index, item in
//			let indexPath = IndexPath(item: index, section: 0)
//			let cell: CustomCell =
//		collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCell
//			cell.setup(with: item)
//			return cell
//		}.disposed(by: disposeBag)
//
		model.$weatherList.bind(to: collectionView.rx.items(cellIdentifier: "CityCell", cellType: CityCell.self)) { row, model, cell in
			cell.update(item: model, tapActin: self.tapItemAction)
		}
	}
	
	private func tapItemAction(weather: Weather) {
		model.event = .openDetail(weather)
	}
	
	@objc private func handleLongPressGesture(_ gesture: UILongPressGestureRecognizer) {
		let gestureLocation = gesture.location(in: collectionView)
		switch gesture.state {
		case .began:
			guard let targetIndexPath = collectionView.indexPathForItem(at: gestureLocation) else { return }
			collectionView.beginInteractiveMovementForItem(at: targetIndexPath)
		case .changed:
			collectionView.updateInteractiveMovementTargetPosition(gestureLocation)
		case .ended:
			collectionView.endInteractiveMovement()
		default:
			collectionView.cancelInteractiveMovement()
		}
	}
}

//	extension MainView: UICollectionViewDataSource {
//		func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//			model.weatherList.count
//		}
//
//		func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CityCell", for: indexPath)
//			guard let concreteCell = cell as? CityCell else { return cell }
//			let codeIndex = indexPath.item % model.weatherList.count
//			concreteCell.update(item: model.weatherList[codeIndex])
//			return cell
//		}
//	}

extension MainView: UICollectionViewDelegateFlowLayout {
	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		sizeForItemAt indexPath: IndexPath
	) -> CGSize {
		CGSize(
			width: collectionView.frame.width,
			height: 100
		)
	}
}

extension MainView: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
		let item = model.weatherList.remove(at: sourceIndexPath.row)
		model.weatherList.insert(item, at: destinationIndexPath.row)
		
		model.event = .listReordered
	}
}

//extension MainView: UICollectionViewDragDelegate {
//	func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
//
//	}
//}

final class MainViewConfig: CultureRxModelOfView {
	@RxPublished var event: Event?
	@RxPublished var isLoading: Bool?
	@RxPublished var weatherList: [Weather] = []
}

extension MainViewConfig {
	enum Event {
		case reverseList
		case listReordered
		case openDetail(Weather)
	}
}
