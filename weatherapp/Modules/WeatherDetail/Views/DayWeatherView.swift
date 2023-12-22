import Foundation
import SnapKit
import UIKit

final class DayWeatherView: BaseView {
	var container = UIView()
	var dayNameLabel = UILabel()
	var temperatureLabel = UILabel()
	
	var selectItem: (() -> Void)?
	
	override func addSubviews() {
		super.addSubviews()
		
		addSubviews(container)
		container.addSubviews(dayNameLabel, temperatureLabel)
	}
	
	override func makeConstraints() {
		container.snp.makeConstraints { make in
			make.horizontalEdges.equalToSuperview()
			make.verticalEdges.equalToSuperview()
		}
		
		dayNameLabel.snp.makeConstraints { make in
			make.top.equalToSuperview().inset(8)
			make.centerX.equalToSuperview()
		}
		
		temperatureLabel.snp.makeConstraints { make in
			make.bottom.equalToSuperview().inset(8)
			make.top.equalTo(dayNameLabel.snp.bottom).inset(8)
			make.centerX.equalToSuperview()
		}
	}
	
	override func configure() {
		container.backgroundColor = .white.withAlphaComponent(0.4)
		container.layer.cornerRadius = 4
		
		container.layer.shadowOpacity = 0.1
		container.layer.shadowRadius = 4
		container.layer.shadowColor = UIColor.black.cgColor
		container.layer.shadowOffset = CGSize(width: 0, height: 0)
		
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
		container.addGestureRecognizer(tapGesture)
	}
	
	// MARK: - public methods
	public func update(data: DayWeather, selectAction: @escaping () -> Void) {
		dayNameLabel.textColor = .black
		temperatureLabel.textColor = .black
		
		dayNameLabel.text = data.date.formatted(Date.FormatStyle().weekday(.abbreviated))
		temperatureLabel.text = data.temperature
		
		selectItem = selectAction
		container.addGestureRecognizer(.init(target: self, action: #selector(tapAction)))
	}
	
	// MARK: - actions
	@objc private func tapAction() {
		selectItem?()
	}
}
