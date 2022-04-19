import Foundation

import CoreLocation

protocol WeatherManagerDelegat{
    
    func didUpdateUI( weather : WeatherModel)
}

struct WeatherManager{
    
    let baseUrl = "https://api.openweathermap.org/data/2.5/weather?&appid=5c913069b81a658a156360aa07ea9786"

    var delegate : WeatherManagerDelegat?
    
    func addCityName(city:String)
    {
        let url:String = baseUrl + "&q="+city;
        
        print("URL IS ", url)
        
        preparUrl(url: url)
    }
    
    
    func addLatAndLon(lat:CLLocationDegrees,lon:CLLocationDegrees)
    {
        let url:String = baseUrl + "&lat=\(lat)&lon=\(lon)";
        
        print("URL IS ", url)
        
        preparUrl(url: url)
    }
    
    
    func preparUrl(url:String)
    {
        let url = URL( string: url)
        
        
        let seesion = URLSession(configuration: .default)
        
        
        let task = seesion.dataTask(with: url!, completionHandler: handler(data:urlresponse:error:))
        
        
        task.resume()
    }
    
    
    func handler(data:Data?,urlresponse:URLResponse?,error:Error?){
        
        let decode = JSONDecoder();
        do {
            
            
            let contactUSData = try decode.decode(WeatherData.self, from: data!);
            
            let weather  = WeatherModel(cityName: contactUSData.name, temp: contactUSData.main.temp, weatherId: contactUSData.weather[0].id);
            
            print(weather.cityName)
            
            delegate!.didUpdateUI(weather: weather);

        }catch{
            print(error)
        }
    }
    
    
}
