//
//  BookListItem.swift
//  BookApplication
//
//  Created by Babu Gangatharan on 9/16/17.
//  Copyright © 2017 Babu Gangatharan. All rights reserved.
//

import Foundation

class BookListItem {
    
    //MARK: Properties
    
    var id: String
    var title: String
    var bookDetail: BookDetailItem
    var isReaded: Bool
    var imageUrl: String
    
    var url: URL {
        return URL(string: imageUrl)!
    }
    
    //MARK: Initializers
    
    init(id: String = "",
         title: String = "",
         bookDetail: BookDetailItem = BookDetailItem(),
         isReaded: Bool = false,
         imageUrl: String = "") {
        self.id = id
        self.title = title
        self.bookDetail = bookDetail
        self.isReaded = isReaded
        self.imageUrl = imageUrl
    }
}
