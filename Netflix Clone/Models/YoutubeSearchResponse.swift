//
//  YoutubeSearchResponse.swift
//  Netflix Clone
//
//  Created by Noah Pope on 1/10/23.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: IdVideoElement
}

struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}
