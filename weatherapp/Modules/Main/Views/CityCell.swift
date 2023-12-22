import Foundation
import SnapKit
import UIKit

final class CityCell: UICollectionViewCell {
	var container = UIView()
	var cityNameLabel = UILabel()
	var temperatureLabel = UILabel()
	
	var model: Weather?
	var selectItem: ((Weather) -> Void)?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		addSubviews()
		makeConstraints()
		configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Internal methods
	func update(item: Weather, tapActin: @escaping (Weather) -> Void) {
		self.selectItem = tapActin
		self.model = item
		self.cityNameLabel.text = item.name
		self.temperatureLabel.text = item.forecast.first?.temperature
	}
	
	// MARK: - Private methods
	private func addSubviews() {
		container.addSubviews(cityNameLabel, temperatureLabel)
		addSubviews(container)
	}
	
	private func makeConstraints() {
		container.snp.makeConstraints { make in
			make.horizontalEdges.equalToSuperview().inset(16)
			make.verticalEdges.equalToSuperview().inset(8)
		}
		
		cityNameLabel.snp.makeConstraints { make in
			make.centerY.equalToSuperview()
			make.leading.equalToSuperview().inset(16)
		}
		
		temperatureLabel.snp.makeConstraints { make in
			make.centerY.equalToSuperview()
			make.centerX.equalToSuperview()
		}
	}
	
	private func configure() {
		container.backgroundColor = .white
		container.layer.cornerRadius = 10
		
		container.layer.shadowOpacity = 0.2
		container.layer.shadowRadius = 10
		container.layer.shadowColor = UIColor.black.cgColor
		container.layer.shadowOffset = CGSize(width: 0, height: 0)
		
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
		container.addGestureRecognizer(tapGesture)
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
	}
	
	// MARK: - actions
	@objc private func tapAction() {
		guard let model, let selectItem else { return }
		selectItem(model)
	}
}

