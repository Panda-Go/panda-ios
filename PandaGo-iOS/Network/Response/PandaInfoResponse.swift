//
//  PandaInfoResponse.swift
//  PandaGo-iOS
//
//  Created by Suji Kim on 3/29/20.
//  Copyright © 2020 sjkim. All rights reserved.
//

import Foundation

struct PandaInfoResponse: Codable{
    let _id: String
    let weapon: String
    let points: String
    let lat: String
    let lng: String
    let lastSeen: String
    let name: String
}
