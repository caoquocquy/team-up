//
//  DataCenter.swift
//  TeamUp
//
//  Created by Quy Cao on 12/5/19.
//  Copyright © 2019 Quy Cao. All rights reserved.
//

import Foundation

class DataCenter {
    static let shared = DataCenter()
    
    var players: [Player]
    
    init() {
        players = [
            "Tung",
//            "Hao",
//            "Son",
            "Quoc",
            "Quy",
//            "Tinh",
            "Phong",
            "Tuan",
            "Khuong",
            "Thien"
            ].map { Player(id: $0.lowercased(), name: $0) }
    }
}
