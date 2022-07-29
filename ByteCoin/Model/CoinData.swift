//
//  CoinData.swift
//  ByteCoin
//
//  Created by Elif Bihter Kuşçu on 29.07.2022.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation
//Make the struct conform to the Decodable protocol to use it to decode our JSON.
struct CoinData: Decodable{
    let rate: Double
}
