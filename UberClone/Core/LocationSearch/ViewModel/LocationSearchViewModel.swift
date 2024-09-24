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
    
    //MARK: - Lifecycle
    
    override init() {
        super.init()
        searchComplater.delegate = self
        searchComplater.queryFragment = quaryFragment
    }
    
    //MARK: - Helpers
    
    func selectedLocation(_ localSearch:MKLocalSearchCompletion){
        locationSearch(forLocalSearchCompletion: localSearch) { response, error in
            
            if let error = error{
                print("DEBUG: Location search failed with error \(error.localizedDescription)")
            }
            
            guard let item = response?.mapItems.first else{return}
            let coordinate = item.placemark.coordinate
            self.selectedLocationCoordinate = coordinate
        }
    }
    
    func locationSearch(forLocalSearchCompletion localSearch: MKLocalSearchCompletion,completion: @escaping MKLocalSearch.CompletionHandler) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        let search = MKLocalSearch(request: searchRequest)
        
        search.start(completionHandler: completion)
    }
}

//MARK: - MKLocalSearchCompleterDelegate

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate{
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
