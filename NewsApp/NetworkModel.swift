//
//  NetworkModel.swift
//  NewsApp
//
//  Created by FIRDOUS UR RASOOL on 01/07/22.
//

import Foundation
struct APIResponse: Codable{
    let articles:[Articles]
}
struct Articles:Codable{
    let source:Source
    let title:String
    let description:String?
    let url:String
    let urlToImage:String?
    let publishedAt:String
}
struct Source:Codable {
    let name:String
}
