//
//  WeatherViewModel.swift
//  WeatherApp
//
// Created by Naresh on 10/04/23.
//

import Foundation

class WeatherViewModel {
    
    private var data: WeatherDataModel?
    private var weather: [WeatherModel]?
    private let service: NetworkProtocol?
    
    init(service: NetworkProtocol? = APIServices()) {
        self.service = service
    }
    
    func fetchWeatherData(city: String, completionHandler: @escaping (Bool, String) -> Void) {
        let cityName = city.replacingOccurrences(of: " ", with: "%20")
        let url = AppURL.geoURL + "\(cityName)&appid=\(AppConstants.appID)"
        self.service?.request(urlString: url, model: [WeatherModel].self, completionHandler: { response in
            switch response {
            case .success(let data):
                self.weather = data
                if !data.isEmpty,
                   data[0].country == "US" {
                    guard let lat = data.first?.lat else { return }
                    guard let lng = data.first?.lon else { return }
                    self.fetchWeatherData(lat: lat, lng: lng) { status, error in
                        Defaults.lastCity = city
                        completionHandler(status, error)
                    }
                }else {
                    completionHandler(false, "Searched city/state not in US")
                }
            case .failure(let error):
                completionHandler(false, error.localizedDescription)
            }
        })
    }
    
    func fetchWeatherData(lat: Double, lng: Double, completionHandler: @escaping (Bool, String) -> Void) {
        let url = AppURL.weatherURL + "lat=\(lat)&lon=\(lng)&appid=\(AppConstants.appID)"
        self.service?.request(urlString: url, model: WeatherDataModel.self, completionHandler: { response in
            switch response {
            case .success(let data):
                self.data = data
                completionHandler(true, "")
            case .failure(let error):
                completionHandler(false, error.localizedDescription)
            }
        })
    }
    
    func getWeatherData() -> WeatherDataModel? {
        return data
    }
    
    func getWeather() -> [WeatherModel]? {
        return weather
    }
    
}
