//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation


class WeatherViewController: UIViewController {

    

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    var weatherManager : WeatherManager  = WeatherManager();
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()

        searchTextField.delegate = self
        weatherManager.delegate = self
        
    }
    
    @IBAction func locationOnPress(_ sender: UIButton) {
        locationManager.requestLocation()
        
    }
}


//MARK  - UITextFieldDelegate

extension WeatherViewController : UITextFieldDelegate{
    @IBAction func searchonPress(_ sender: UIButton) {
        print(searchTextField.text!)
        searchTextField.endEditing(true)

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(searchTextField.text!)
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTextField.text == ""
        {
            searchTextField.placeholder = "Type anything"
        }else
        {
            print("Should End Editing")
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        weatherManager.addCityName(city: searchTextField.text!)
        searchTextField.text = ""
        
    }

}

//MARK - WeatherManagerDelegat

extension WeatherViewController : WeatherManagerDelegat {
    
    func didUpdateUI(weather : WeatherModel) {
        print("This is Ciry ", weather.cityName)
        
        updateUI(weather)
    }
    
    func updateUI(_ weather : WeatherModel){
        DispatchQueue.main.async {
            self.cityLabel.text = weather.cityName
            self.temperatureLabel.text = weather.tempString
            self.conditionImageView.image = UIImage(systemName: weather.conditionalName)
        }
    }
}

//MARK - CLLocationManagerDelegate

extension WeatherViewController :CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        let location = locations.last?.coordinate
        
        self.weatherManager.addLatAndLon(lat: location!.latitude, lon: location!.longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}

