//
//  ServiceManager.swift
//  BookApplication
//
//  Created by Babu Gangatharan on 9/16/17.
//  Copyright © 2017 Babu Gangatharan. All rights reserved.
//

import Foundation
import SwiftyJSON

class ServiceManager {
    
    typealias BookResponse = (Error?, APIBooks?) -> Void
    
    class func getBook(for searchText: String, completion onCompletion: @escaping BookResponse) -> Void {
        if let path = Bundle.main.path(forResource: "Books", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = JSON(data: data)
                if jsonObj != JSON.null {
                    let books =  APIBooks(json: jsonObj)
                    onCompletion(nil, books)
                } else {
                    print("Could not get json from file, make sure that file contains valid json.")
                }
            } catch let error {
                onCompletion(error, nil)
            }
        } else {
            print("Invalid filename/path.")
        }
    }
}
