import Foundation

struct MainModel {
	// TODO: пока что не нужно
	var cities: [Weather]
	
	init(cities: [Weather]) {
		self.cities = cities
	}
}
