//
//  BookListDataSource.swift
//  BookApplication
//
//  Created by Babu Gangatharan on 9/16/17.
//  Copyright © 2017 Babu Gangatharan. All rights reserved.
//

import Foundation
import UIKit
import Simple_KeychainSwift

class BookListDataSource {
    
    // MARK: Types
    
    typealias SourceData = APIBooks
    typealias Item = BookListItem
    
    // MARK: Properties
    
    var data: [Item]
    var sourceData: SourceData?
    
    var readedItems: [Item] {
        return data.filter { (item) -> Bool in
            item.isReaded == true
        }
    }
    
    var pendingItems: [Item] {
        return data.filter { (item) -> Bool in
            item.isReaded == false
        }
    }
    
    var showAllItems: [Item] {
        return data
    }
    
    var topRatedItems: [Item] {
        return data.filter { (item) -> Bool in
            item.bookDetail.rating >= 4
        }
    }
    
    // MARK: Events
    
    var onUpdated: ExecutionBlock?
    
    // MARK: Initializers
    
    init(data: SourceData) {
        self.data = []
        self.sourceData = data
        load()
    }
}

extension BookListDataSource {
    
    // MARK: Functions
    
    func load() {
        guard let items = sourceData?.items,
            items.count > 0 else {
                return
        }
        
        var bookItems = [Item]()
        
        items.forEach { item in
            let isReaded = checkReadingStatus(for: item)
            bookItems.append(makeItem(from: item, isReaded: isReaded))
        }
        
        data = bookItems
    }
    
    func filterTopRatedItems() {
        data = data.filter { (item) -> Bool in
            item.bookDetail.rating >= 4
        }
    }
    
    func filterReadingItems() {
        data = data.filter { (item) -> Bool in
            item.isReaded == true
        }
    }
    
    func filterPendingItems() {
        data = data.filter { (item) -> Bool in
            item.isReaded == false
        }
    }
    
    func update(isReaded readed: Bool, at indexPath: IndexPath, tableView: UITableView) {
        let item = self.item(at: indexPath)
        
        item.isReaded = readed
        _ = Keychain.set(readed, forKey: item.id)
        
        tableView.reloadData()
    }
    
    func checkReadingStatus(for item: APIItems) -> Bool {
        if let id = item.id,
            Keychain.bool(forKey: id) {
            return true
        }
        
        return false
    }
    
    // MARK: Helpers
    
    private func makeItem(from book: APIItems, isReaded readed: Bool) -> Item {
        let item = Item()
        let bookDetail = BookDetailItem()
        
        if let id = book.id {
            item.id = id
        }
        
        if let title = book.volumeInfo?.title {
            item.title = title
        }
        
        if let title = book.volumeInfo?.title {
            bookDetail.title = title
        }
        
        if let imageUrl = book.volumeInfo?.imageLinks?.thumbnail {
            bookDetail.imageUrl = imageUrl
            item.imageUrl = imageUrl
        }
        
        if let authors = book.volumeInfo?.authors?.joined(separator: ",") {
            bookDetail.authors = authors
        }
        
        if let subtitle = book.volumeInfo?.subtitle {
            bookDetail.subtitle = subtitle
        }
        
        if let rating = book.volumeInfo?.averageRating {
            bookDetail.rating = rating
        }
        
        if let previewUrl = book.volumeInfo?.previewLink {
            bookDetail.previewUrl = previewUrl
        }
        
        item.isReaded = readed
        item.bookDetail = bookDetail
        
        return item
    }
    
    func item(at indexPath: IndexPath)  -> Item {
        guard indexPath.section >= 0 else {
            return Item()
        }
        
        let items = data
        
        guard indexPath.row <= items.count - 1 else {
            return Item()
        }
        
        return items[indexPath.row]
    }
    
}
