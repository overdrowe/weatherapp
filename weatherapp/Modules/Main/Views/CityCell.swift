import Foundation
import SnapKit
import UIKit

final class CityCell: UICollectionViewCell {
	var contaienr = UIView()
	var cityNameLabel = UILabel()
	var temperatureLabel = UILabel()
	
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
	func update(name: String) {
		cityNameLabel.text = name
		temperatureLabel.text = "+\(Int.random(in: 1..<25))" // TODO: сделать нормальную модель WeatherItem { let cityName, let temperature }
	}
	
	// MARK: - Private methods
	private func addSubviews() {
		contaienr.addSubviews(cityNameLabel, temperatureLabel)
		addSubviews(contaienr)
	}
	
	private func makeConstraints() {
		contaienr.snp.makeConstraints { make in
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
		contaienr.backgroundColor = .white
		contaienr.layer.cornerRadius = 10
		
		contaienr.layer.shadowOpacity = 0.2
		contaienr.layer.shadowRadius = 10
		contaienr.layer.shadowColor = UIColor.black.cgColor
		contaienr.layer.shadowOffset = CGSize(width: 0, height: 0)
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
	}
}

