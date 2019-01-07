//
//  ViewController.swift
//  WeatherApp
//
//  Created by Angela Yu on 23/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    
    //Constants
    let WEATHER_URL = "https://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "ab2cdb76ced93287a645bf7a94a94e6d"
    /***Get your own App ID at https://openweathermap.org/appid ****/
    

    //TODO: Declare instance variables here
    let locationManager = CLLocationManager()

    
    //Pre-linked IBOutlets
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO:Set up the location manager here.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    
    
    //MARK: - Networking
    /***************************************************************/
    
    //Write the getWeatherData method here:
    func getWeatherData(url: String, parameters: [String: String]) {
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { (response) in
            if response.result.isSuccess {
                print("Success! Got the weather data")
                let weatherJson : JSON = JSON(response.result.value!)
                
                self.updateWeatherData(json: weatherJson)
            } else {
                print("error \(response.result.error ?? "error default" as! Error)")
                self.cityLabel.text = "Connection Issues"
            }
        }
    }
    
    //MARK: - JSON Parsing
    /***************************************************************/
    //Write the updateWeatherData method here:
    func updateWeatherData(json: JSON) {
        let weatherModel = WeatherDataModel(json: json)
        updateUIWithWeatherData(weatherModel: weatherModel)
    }

    //MARK: - UI Updates
    /***************************************************************/
    //Write the updateUIWithWeatherData method here:
    func updateUIWithWeatherData(weatherModel: WeatherDataModel) {
        cityLabel.text = weatherModel.city
        temperatureLabel.text = String(weatherModel.temperature)
        weatherIcon.image = UIImage(named: weatherModel.weatherIconName)
    }
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    //Write the didUpdateLocations method here:
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            print("longtitude: \(location.coordinate.longitude) latitude: \(location.coordinate.latitude)")
            
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            
            let param: [String : String] = ["lon": longitude, "lat": latitude, "appid": APP_ID]
            getWeatherData(url: WEATHER_URL, parameters: param)
        }
    }
    
    
    //Write the didFailWithError method here:
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("can't get location")
    }
    
    //MARK: - Change City Delegate methods
    /***************************************************************/
    //Write the userEnteredANewCityName Delegate method here:
    
    
    //Write the PrepareForSegue Method here
    
}


