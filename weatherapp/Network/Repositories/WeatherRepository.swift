import Foundation

final class WeatherRepository {
	func fetchWeather(closure: @escaping ([Weather]) -> Void) {
		DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 0.5) {
			var items: [Weather] = []
			items.append(Weather(name: "Уфа", forecast: self.mockForecasst()))
			items.append(Weather(name: "Сургут", forecast: self.mockForecasst()))
			items.append(Weather(name: "Москва", forecast: self.mockForecasst()))
			items.append(Weather(name: "Краснодар", forecast: self.mockForecasst()))
			items.append(Weather(name: "Алматы", forecast: self.mockForecasst()))
			closure(items)
		}
	}
	
	private func mockForecasst() -> [DayWeather] {
		var forecast: [DayWeather] = []
		for i in 0...6 {
			let dayWeather: DayWeather = .init(
				date: Calendar.current.date(byAdding: .day, value: i, to: Date()) ?? Date(),
				temperature: "+\(Int.random(in: 1...30))°"
			)
			
			forecast.append(dayWeather)
		}
		
		return forecast
	}
}

// temperature: "-5°"
// temperature: "-50°"
// temperature: "-2°"
// temperature: "+5°"
// temperature: "0°"
