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
    
    // MARK: Types
    
    typealias BookResponse = (Error?, APIBooks?) -> Void
    
    // MARK: Struct
    
    struct Request {
        static let bookUrl = "https://www.googleapis.com/books/v1/volumes?filter=free-ebooks&q=a"
    }
    
    //MARK: Static
    
    static let shared = ServiceManager()
    
    // MARK: Functions
    
    func getBook(completion onCompletion: @escaping BookResponse) -> Void {
        
        //If want to run local JSON file please rename Books12 to Books
        if let path = Bundle.main.path(forResource: "Books12", ofType: "json") {
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
        }
        else {
            guard let url = NSURL(string: Request.bookUrl) else {
                return
            }
            
            let searchTask = URLSession.shared.dataTask(with: url as URL, completionHandler: { data, response, error  in
                if error != nil {
                    print("Error: \(error.debugDescription)")
                    
                    onCompletion(error as NSError?, nil)
                    return
                }
                
                do {
                    let resultsDictionary = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject]
                    
                    guard let results = resultsDictionary else {
                        return
                    }
                    
                    let books = APIBooks(object: results)
                    
                    onCompletion(nil, books)
                    
                }
                catch let error as NSError {
                    print("Error parsing JSON: \(error)")
                    
                    onCompletion(error, nil)
                    return
                }
            })
            searchTask.resume()
        }
    }
}
