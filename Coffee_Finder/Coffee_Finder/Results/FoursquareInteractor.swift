//
//  FoursquareInteractor.swift
//  Coffee_Finder
//
//  Created by Steven Worrall on 6/8/20.
//  Copyright © 2020 Steven Worrall. All rights reserved.
//

import Foundation
import PromiseKit

protocol FoursquareInteractorDelegate: class {
    func dataSuccess(data: [Venue])
    func dataFailure(error: Error)
}

class FoursquareInteractor {
    weak var delegate: FoursquareInteractorDelegate?
    
    private let foursquareRepo = FoursquareRepository()
    
    private var data: [Venue] = []
    
    public func getVenueDataWithPhotoURL() {
        firstly {
            self.foursquareRepo.getVenues()
        }.done { venues in
            self.getVenues(venueData: venues)
        }.catch { error in
            self.data = []
            print("in fail")
            self.delegate?.dataFailure(error: error)
        }
    }
    
    private func getVenues(venueData: VenueResponseData) {
        guard let establishmentArray = venueData.response?.groups?[0].items else {
            self.data = []
            return
        }
        
        establishmentArray.forEach { (establishment) in
            guard let id = establishment.venue?.id else {
                return
            }
            self.getVenueWithID(id: id, establishment: establishment)
        }
    }
    
    private func getVenueWithID(id: String, establishment: Establishment) {
        firstly {
            self.foursquareRepo.getVenueByID(id: id)
        }.done { data in
            if let unwrappedData = data.response?.venue {
                self.data.append(unwrappedData)
            }
            self.delegate?.dataSuccess(data: self.data)
        }.catch { error in
            guard let venue = establishment.venue else { return }
            self.data.append(venue)
        }
    }
}
