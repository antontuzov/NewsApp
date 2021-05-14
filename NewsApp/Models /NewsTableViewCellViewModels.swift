//
//  NewsTableViewCellViewModels.swift
//  NewsApp
//
//  Created by Anton Tuzov on 14.05.2021.
//

import Foundation

class NewsTableViewCellViewModels {
    let titel: String
    let subtitel: String
    let imageURL: URL?
    var imageData: Data? = nil
    init(titel: String, subtitel: String,imageURL: URL?) {
        self.titel = titel
        self.subtitel = subtitel
        self.imageURL = imageURL
  
    }
}
