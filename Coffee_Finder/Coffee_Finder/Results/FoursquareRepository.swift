//
//  FoursquareRepository.swift
//  Coffee_Finder
//
//  Created by Steven Worrall on 6/8/20.
//  Copyright © 2020 Steven Worrall. All rights reserved.
//

import Foundation
import PromiseKit


class FoursquareRepository {
    
    let service = Service()
    
    // Add your clientID and secret
    private let clientID = ""
    private let clientSecret = ""
    
    private lazy var baseParameters = FoursquareParameters(clientID: self.clientID, clientSecret: self.clientSecret).toString()
    
    private let returnLimit = "15"
    
    private let envoyLat = "37.775410"
    private let envoyLong = "-122.398220"
    
    private let queryString = "coffee"
    
    private let baseUrlString = "https://api.foursquare.com/v2/venues"
    private let exploreString = "/explore"
    private var photoString = "/photos"
    
    
    private func createUrlStringForVenueFetch() -> String {
        var returnString = ""
        
        let parameters = FoursquareVenueParameters(limit: self.returnLimit, lat: envoyLat, long: envoyLong, query: queryString).toString()
        
        returnString += self.baseUrlString + self.exploreString
        returnString += self.baseParameters
        returnString += parameters
        
        return returnString
    }
    
    private func createUrlStringForVenueByIDFetch(venueID: String) -> String {
        var returnString = ""
        
        returnString += self.baseUrlString
        returnString += "/\(venueID)"
        returnString += self.baseParameters
        
        return returnString
    }
    
    public func getVenues() -> Promise<VenueResponseData> {
        return Promise { seal in
            let urlString = self.createUrlStringForVenueFetch()
            service.fetchGenericData(urlString: urlString) { (result: Swift.Result<VenueResponseData, Error>) in
                switch result{
                case .success(let photoData):
                    seal.fulfill(photoData)
                case .failure(let error):
                    print(error)
                    seal.reject(error)
                }
            }
        }
    }
    
    public func getVenueByID(id: String) -> Promise<VenueDetailResponseData> {
        return Promise { seal in
            let urlString = self.createUrlStringForVenueByIDFetch(venueID: id)
            service.fetchGenericData(urlString: urlString) { (result: Swift.Result<VenueDetailResponseData, Error>) in
                switch result{
                case .success(let data):
                    seal.fulfill(data)
                case .failure(let error):
                    print(error)
                    seal.reject(error)
                }
            }
        }
    }
}
