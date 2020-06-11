//
//  PhotoDataModels.swift
//  Coffee_Finder
//
//  Created by Steven Worrall on 6/9/20.
//  Copyright © 2020 Steven Worrall. All rights reserved.
//

import Foundation


struct VenuePhoto {
    let prefix: String?
    let suffix: String?
    let urlString: String?
    
    enum CodingKeys: String, CodingKey {
        case prefix
        case suffix
    }
}

extension VenuePhoto: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.prefix = try values.decode(String.self, forKey: .prefix)
        self.suffix = try values.decode(String.self, forKey: .suffix)
        
        if let pre = self.prefix, let suf = self.suffix{
            self.urlString = pre + "300x500" + suf
            
        } else {
            self.urlString = ""
        }
    }
}

struct PhotoGroups: Decodable {
    let count: Int?
    let items: [VenuePhoto]
}

struct PhotosArray: Decodable {
    let groups: [PhotoGroups]?
}
