//
//  BookDetailItem.swift
//  BookApplication
//
//  Created by Babu Gangatharan on 9/16/17.
//  Copyright © 2017 Babu Gangatharan. All rights reserved.
//

import Foundation
import UIKit

class BookDetailItem {
    
    //MARK: Properties
    
    var imageUrl: String
    var title: String
    var authors: String
    var subtitle: String
    var description: String
    var textSnippet: String
    var rating: Int
    var previewUrl: String
    
    var url: URL {
        return URL(string: imageUrl)!
    }
    
    //MARK: Initializers
    
    init(imageUrl: String = "",
         title: String = "",
         authors: String = "",
         subtitle: String = "",
         description: String = "",
         textSnippet: String = "",
         rating: Int = 0,
         previewUrl: String = "") {
        self.imageUrl = imageUrl
        self.title = title
        self.authors = authors
        self.subtitle = subtitle
        self.description = description
        self.textSnippet = textSnippet
        self.rating = rating
        self.previewUrl = previewUrl
    }
}
