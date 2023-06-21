//
//  HomeModel.swift
//  KedaTech Project
//
//  Created by Ricky Austin on 20/06/23.
//

import Foundation

struct HomeModel: Codable {
    let id: Int
    let name: String
    let icon: String
    var isFavourite = false
}
