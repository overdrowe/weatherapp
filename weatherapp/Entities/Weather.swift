import Foundation

public struct Weather {
	let name: String
	let forecast: [DayWeather]
	
	init(name: String, forecast: [DayWeather] = []) {
		self.name = name
		self.forecast = forecast
		
		if forecast.isEmpty {
			
		}
	}
}

public struct DayWeather {
	let date: Date
	let temperature: String
}
