//
//  DataModels.swift
//  Coffee_Finder
//
//  Created by Steven Worrall on 6/8/20.
//  Copyright © 2020 Steven Worrall. All rights reserved.
//

import Foundation

struct HereNow: Decodable {
    let count: Int?
    let summary: String?
}

struct Hours: Decodable {
    let status: String?
    let isOpen: Bool?
    let isLocalHoliday: Bool?
}

struct Price: Decodable {
    let tier: Int?
    let message: String?
    let currency: String?
}

struct Stats: Decodable {
    let checkinsCount: Int?
    let usersCount: Int?
    let tipCount: Int?
}

struct Icon: Decodable {
    let prefix: String?
    let suffix: String?
}

struct Categories: Decodable {
    let id: String
    let name: String?
    let pluralName: String?
    let shortName: String?
    let icon: Icon?
    let primary: Bool?
}

struct Location: Decodable {
    let address: String?
    let crossStreet: String?
    let lat: Float?
    let lng: Float?
    let distance: Float?
    let postalCode: String?
    let cc: String?
    let city: String?
    let state: String?
    let country: String?
    let formattedAddress: [String]?
}

struct Venue: Decodable {
    let id: String
    let name: String?
    let location: Location?
    let categories: [Categories]?
    let stats: Stats?
    let url: String?
    let price: Price?
    let rating: Float?
    let hours: Hours?
    let hereNow: HereNow?
    let bestPhoto: VenuePhoto?
    let tips: TipWrapper?
}

struct TipUser: Decodable {
    let id: String?
    let firstName: String?
    let photo: VenuePhoto?
}

struct Tip: Decodable {
    let createdAt: Int?
    let text: String?
    let type: String?
    let canonicalUrl: String?
    let agreeCount: Int?
    let user: TipUser?
}

struct TipArray: Decodable {
    let count: Int?
    let items: [Tip]?
}

struct TipWrapper: Decodable {
    let groups: [TipArray]?
}

struct Establishment: Decodable {
    var venue: Venue?
    let tips: [Tip]?
    let referralId: String?
}

struct Items: Decodable {
    let items: [Establishment]?
}

struct Response: Decodable {
    let query: String?
    let totalResults: Int?
    let groups: [Items]?
}

struct VenueResponseData: Decodable {
    let response: Response?
}

struct VenueDetail: Decodable {
    let venue: Venue?
}

struct VenueDetailResponseData: Decodable {
    let response: VenueDetail?
}
