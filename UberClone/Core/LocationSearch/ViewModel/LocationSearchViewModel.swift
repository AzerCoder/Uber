//
//  LocationSearchViewModel.swift
//  UberClone
//
//  Created by A'zamjon Abdumuxtorov on 24/09/24.
//

import Foundation
import MapKit

class LocationSearchViewModel:NSObject,ObservableObject{
    
    //MARK: - Preperties
    
    @Published var results = [MKLocalSearchCompletion]()
    @Published var selectedUberLocation: UberLocation?
    @Published var pickupTime:String?
    @Published var dropOffTime:String?
    
    private let searchComplater = MKLocalSearchCompleter()
    var quaryFragment:String = ""{
        didSet{
            searchComplater.queryFragment = quaryFragment
        }
    }
    
    var userLocation: CLLocationCoordinate2D?
    
    //MARK: - Lifecycle
    
    override init() {
        super.init()
        searchComplater.delegate = self
        searchComplater.queryFragment = quaryFragment
    }
    
    //MARK: - Helpers
    
    func selectLocation(_ localSearch:MKLocalSearchCompletion){
        locationSearch(forLocalSearchCompletion: localSearch) { response, error in
            
            if let error = error{
                print("DEBUG: Location search failed with error \(error.localizedDescription)")
                return
            }
            
            guard let item = response?.mapItems.first else{return}
            let coordinate = item.placemark.coordinate
            print("DEBUG: Location coordinate \(coordinate)")
            self.selectedUberLocation = UberLocation(title: localSearch.title, coordinate: coordinate)
        }
    }
    
    func locationSearch(forLocalSearchCompletion localSearch: MKLocalSearchCompletion,completion: @escaping MKLocalSearch.CompletionHandler) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        let search = MKLocalSearch(request: searchRequest)
        
        search.start(completionHandler: completion)
    }
    
    func computeRidePrice(forType type:RideType) -> Double{
        guard let destCoordinate = selectedUberLocation?.coordinate else{ return 0.0}
        guard let userCoordinate = self.userLocation else{ return 0.0}
        
        let userLocation = CLLocation(latitude: userCoordinate.latitude, longitude: userCoordinate.longitude)
        let destination = CLLocation(latitude: destCoordinate.latitude, longitude: destCoordinate.longitude)
        
        let tripDistanceInMEters = userLocation.distance(from: destination)
        return type.computePrice(for: tripDistanceInMEters)
    }
    
    func getDestinationRoute(from userLocation: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D,completion:@escaping (MKRoute) -> Void){
        
        let userPlaceMark = MKPlacemark(coordinate: userLocation)
        let destPlaceMark = MKPlacemark(coordinate: destination)
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: userPlaceMark)
        request.destination = MKMapItem(placemark: destPlaceMark)
        let directions = MKDirections(request: request)
        
        directions.calculate { response, error in
            if let error = error{
                print("ERROR: Failed to get directions error \(error.localizedDescription)")
                return
            }
            guard let route = response?.routes.first else{return}
            self.configurePickupAndDropoffTimes(with: route.expectedTravelTime)
            completion(route)
        }
    }
    
    func configurePickupAndDropoffTimes(with expectedTravelTime: Double){
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        
        pickupTime = formatter.string(from: Date())
        dropOffTime = formatter.string(from: Date() + expectedTravelTime)
    }
}

//MARK: - MKLocalSearchCompleterDelegate

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate{
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
