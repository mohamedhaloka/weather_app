


struct WeatherData : Decodable{
    var weather : [Weather]
    var name : String
    var main: Main
    
}


struct Weather : Decodable{
    var id : Int
}


struct Main :Decodable{
    var temp:Float
}


