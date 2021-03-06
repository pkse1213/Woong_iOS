//
//  BookmarkData.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 12..
//  Copyright © 2018년 Leess. All rights reserved.
//

import Foundation



struct BookmarkData: Codable {
    let message: String
    let data: [Bookmark]
}

struct Bookmark: Codable {
    let marketId: Int
    let marketName, marketAddress, titleImageKey: String
    
    enum CodingKeys: String, CodingKey {
        case marketId = "market_id"
        case marketName = "market_name"
        case marketAddress = "market_address"
        case titleImageKey = "title_image_key"
    }
}

