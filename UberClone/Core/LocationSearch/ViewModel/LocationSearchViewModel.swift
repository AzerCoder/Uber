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
    @Published var selectedLocationCoordinate: CLLocationCoordinate2D?
    
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
            self.selectedLocationCoordinate = coordinate
        }
    }
    
    func locationSearch(forLocalSearchCompletion localSearch: MKLocalSearchCompletion,completion: @escaping MKLocalSearch.CompletionHandler) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        let search = MKLocalSearch(request: searchRequest)
        
        search.start(completionHandler: completion)
    }
    
    func computeRidePrice(forType type:RideType) -> Double{
        guard let destCoordinate = selectedLocationCoordinate else{ return 0.0}
        guard let userCoordinate = self.userLocation else{ return 0.0}
        
        let userLocation = CLLocation(latitude: userCoordinate.latitude, longitude: userCoordinate.longitude)
        let destination = CLLocation(latitude: destCoordinate.latitude, longitude: destCoordinate.longitude)
        
        let tripDistanceInMEters = userLocation.distance(from: destination)
        return type.computePrice(for: tripDistanceInMEters)
    }
}

//MARK: - MKLocalSearchCompleterDelegate

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate{
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
