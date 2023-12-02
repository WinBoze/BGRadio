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

struct Station: Decodable, Equatable, Encodable {
    var id: Int?
    var radioName: String?
    var radioPic: String?
    var radioUrl: String?
}

