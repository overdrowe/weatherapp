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
		
		collectionView.dataSource = self
		collectionView.delegate = self
		collectionView.register(CityCell.self, forCellWithReuseIdentifier: "CityCell")
		
		let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture))
		collectionView.addGestureRecognizer(longPressGesture)
		
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
	}
	
	override func configure() {
		super.configure()
		backgroundColor = .black
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

extension MainView: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		model.cities?.count ?? .zero
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CityCell", for: indexPath)
		guard let concreteCell = cell as? CityCell else { return cell }
		guard let cities = model.cities else { return cell }
		let codeIndex = indexPath.item % cities.count
		concreteCell.update(name: cities[codeIndex])
		return cell
	}
}

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
		let item = model.cities?.remove(at: sourceIndexPath.row)
		guard let item else { return }
		model.cities?.insert(item, at: destinationIndexPath.row)
		
		model.event = .listReordered
	}
}

final class MainViewConfig: CultureRxModelOfView {
	@RxPublished var event: Event?
	@RxPublished var cities: [String]?
}

extension MainViewConfig {
	enum Event {
		case listReordered
	}
}
