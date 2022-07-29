//
//  CoinData.swift
//  ByteCoin
//
//  Created by Elif Bihter Kuşçu on 29.07.2022.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation
//Struct yapısını JSON kodunu çözmek için kullanmak için Decodable protokole uygun hale getir 
struct CoinData: Decodable{
    let rate: Double
}
