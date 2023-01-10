//
//  YoutubeSearchResponse.swift
//  Netflix Clone
//
//  Created by Noah Pope on 1/10/23.
//

import Foundation

/*
 items =     (
             {
         etag = "P2jDTzRinVnvlXgJGuJY617r_7Q";
         id =             {
             kind = "youtube#video";
             videoId = Qd1LOkXBBQs;
         };
         kind = "youtube#searchResult";
     },
 */

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
