import Foundation
import UIKit

final class WeatherDetailView: CultureRxView<WeatherDetailViewConfig> {
	
	var container = UIView()
	var dateLabel = UILabel()
	var cityNameLabel = UILabel()
	var temperatureLabel = UILabel()
	
	lazy var horizontalScrollView: UIScrollView = {
		let scrollView = UIScrollView()
		scrollView.showsHorizontalScrollIndicator = false
		return scrollView
	}()
	
	private lazy var contentView: UIView = {
		let contentView = UIView()
		contentView.frame.size = contentSize
		return contentView
	}()
	var weekDaysView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.alignment = .center
		stackView.spacing = 8
		return stackView
	}()
	
	private var contentSize: CGSize {
	 CGSize(width: frame.width, height: 100)
 }
	// MARK: - Private methods
	override func addSubviews() {
		super.addSubviews()
		
		addSubviews(container, horizontalScrollView)
		horizontalScrollView.addSubview(contentView)
		contentView.addSubview(weekDaysView)
		container.addSubviews(dateLabel, cityNameLabel, temperatureLabel)
	}
	
	override func makeConstraints() {
		container.snp.makeConstraints { make in
			make.horizontalEdges.equalToSuperview().inset(32)
			make.centerY.equalToSuperview()
		}
		
		temperatureLabel.snp.makeConstraints { make in
			make.leading.top.equalToSuperview()
		}
		
		cityNameLabel.snp.makeConstraints { make in
			make.leading.equalToSuperview()
			make.top.equalTo(temperatureLabel.snp.bottom).offset(8)
		}
		
		dateLabel.snp.makeConstraints { make in
			make.leading.bottom.equalToSuperview()
			make.top.equalTo(cityNameLabel.snp.bottom).offset(8)
		}
		
		horizontalScrollView.snp.makeConstraints { make in
			make.leading.trailing.equalToSuperview()
			make.top.equalTo(container.snp.bottom).offset(32)
			make.height.equalTo(100)
		}
		
		contentView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
		
		weekDaysView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
	}
	
	override func configure() {
		super.configure()
		
		temperatureLabel.font = .boldSystemFont(ofSize: 128)
		cityNameLabel.font = .systemFont(ofSize: 32)
		dateLabel.font = .systemFont(ofSize: 18)
		
		let _ = model.$weather.subscribe { [weak self] weather in
			guard let self, let weather else { return }
			self.updateState(weather: weather, currentIndex: self.model.currentIndex)
		}
		
		let _ = model.$currentIndex.subscribe { [weak self] index in
			guard let self, let weather = self.model.weather else { return }
			self.updateState(weather: weather, currentIndex: index) }
	}
	
	private func updateState(weather: Weather, currentIndex: Int) {
		self.cityNameLabel.text = weather.name
		self.temperatureLabel.text = weather.forecast[currentIndex].temperature
		
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MMM dd"
		self.dateLabel.text = dateFormatter.string(from: weather.forecast[currentIndex].date)
		
		self.setupWeekWeather(forecast: weather.forecast)
		self.setupForecastConstraints()
	}
	
	private func setupWeekWeather(forecast: [DayWeather]) {
		weekDaysView.subviews.forEach { $0.removeFromSuperview() }
		forecast.enumerated().forEach({ index, weather in
			let view = DayWeatherView()
			view.update(data: weather) { [weak self] in
				self?.model.event = .daySelected(index)
			}
			weekDaysView.addArrangedSubview(view)
		})
	}
	
	private func setupForecastConstraints() {
		weekDaysView.translatesAutoresizingMaskIntoConstraints = false

		for view in weekDaysView.arrangedSubviews {
			view.snp.makeConstraints { make in
				make.width.equalTo(140)
				make.height.equalTo(100)
			}
		}
	}
	
	func tapAction(index: Int) {
		model.event = .daySelected(index)
	}
}

final class WeatherDetailViewConfig: CultureRxModelOfView {
	@RxPublished var event: Event?
	@RxPublished var weather: Weather?
	@RxPublished var currentIndex = 0
}

extension WeatherDetailViewConfig {
	enum Event {
		case daySelected(Int)
	}
}
