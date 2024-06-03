//
//  DetailsViewModel.swift
//  WeatherAppSwiftUI
//
//  Created by Israa Assem on 20/05/2024.
//

//import Foundation
//import MapKit
//
////struct DetailsViewModel2{
////    var location:CLLocation?=nil
////    private let locationManager=LocationManager{[weak self] in
////        self?.location=locationManager.location!
////    }
////    func getCurrentLocation()->CLLocation{
////        return location!
////    }
////}
//class DetailsViewModel {
//    var location: CLLocation? = nil
//    private let locationManager: LocationManager
//
//    init() {
//        locationManager = LocationManager { [weak self] location in
//            self?.location = location
//        }
//    }
//
//    func getCurrentLocation() -> CLLocation? {
//        return location
//    }
//}
//
//class LocationManager:NSObject{
//    let locationManager = CLLocationManager()
//    var location:CLLocation?
//    //var region=MKCoordinateRegion()
//    var locationResult: ((CLLocation) -> Void)?
//     init(locationResult:@escaping (CLLocation)->Void){
//        super.init()
//        self.locationResult=locationResult
//        locationManager.desiredAccuracy=kCLLocationAccuracyBest
//        locationManager.distanceFilter=kCLDistanceFilterNone
//        locationManager.requestAlwaysAuthorization()
//        locationManager.delegate=self
//    }
//}
//extension LocationManager:CLLocationManagerDelegate{
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let lastLocation=locations.last else{return}
//       
//        self.location=lastLocation
//        locationResult?(lastLocation)
//        
//    }
//}


import Foundation
import CoreLocation

class DetailsViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var weatherResponse:WeatherResponse?=nil
    @Published var location: CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
        if location != nil{
            print(location?.coordinate.latitude)
            NetworkManager.fetchWeatherData(for: self.location!) { [weak self]response in
                self?.weatherResponse=response
                print(response)
            }
        }else{
            requestLocation()
            
        }
    }

    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.location = location
        locationManager.stopUpdatingLocation()
        NetworkManager.fetchWeatherData(for: self.location!) { [weak self]response in
            self?.weatherResponse=response
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

  
extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
