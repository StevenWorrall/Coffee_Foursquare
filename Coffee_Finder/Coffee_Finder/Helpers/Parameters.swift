//
//  Parameters.swift
//  Coffee_Finder
//
//  Created by Steven Worrall on 6/8/20.
//  Copyright © 2020 Steven Worrall. All rights reserved.
//

import Foundation

enum FoursquareVenueKeys: String {
    case limit
    case ll
    case query
}

struct FoursquareVenueParameters {
    let limit: String
    let ll: String
    let query: String
    let equal = "="
    let endParameter = "&"
    
    init(limit: String, lat: String, long: String, query: String) {
        self.limit = limit
        self.ll = lat + "," + long
        self.query = query
    }
    
    public func toString() -> String {
        var returnString = self.endParameter
        returnString += FoursquareVenueKeys.limit.rawValue + self.equal + self.limit + self.endParameter
        returnString += FoursquareVenueKeys.ll.rawValue + self.equal + self.ll + self.endParameter
        returnString += FoursquareVenueKeys.query.rawValue + self.equal + self.query
        
        return returnString
    }
}

enum FoursquareKeys: String {
    case v
    case client_id
    case client_secret
}

struct FoursquareParameters {
    let clientID: String
    let clientSecret: String
    let v = "20200609"
    let equal = "="
    let endParameter = "&"
    
    init(clientID: String, clientSecret: String) {
        self.clientID = clientID
        self.clientSecret = clientSecret
    }
    
    public func toString() -> String {
        var returnString = "?"
        
        returnString += FoursquareKeys.client_id.rawValue + self.equal + self.clientID + self.endParameter
        returnString += FoursquareKeys.client_secret.rawValue + self.equal + self.clientSecret + self.endParameter
        returnString += FoursquareKeys.v.rawValue + self.equal + self.v
        
        return returnString
    }
}
