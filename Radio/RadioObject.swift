//
//  RadioObject.swift
//  Radio
//
//  Created by Petko Tankov on 2.12.23.
//

import Foundation

struct RadioObject: Decodable {
    var stations: [Station]?
}

class Station: Decodable, Equatable, Encodable {
    static func == (lhs: Station, rhs: Station) -> Bool {
        return lhs.id ?? 0 == rhs.id ?? 0
    }
    
    var id: Int?
    var radioName: String?
    var radioPic: String?
    var radioUrl: String?
    
    init?(id: Int?, radioName: String?, radioPic: String?, radioUrl: String? ) {
        self.id = id
        self.radioName = radioName
        self.radioPic = radioPic
        self.radioUrl = radioUrl
    }
}

