//
//  APIBooks.swift
//
//  Created by Babu Gangatharan on 9/16/17.
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class APIBooks: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let totalItems = "totalItems"
    static let kind = "kind"
    static let itemsValue = "items"
  }

  // MARK: Properties
  public var totalItems: Int?
  public var kind: String?
  public var items: [APIItems]?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    totalItems = json[SerializationKeys.totalItems].int
    kind = json[SerializationKeys.kind].string
    if let itemsValue = json[SerializationKeys.itemsValue].array { items = itemsValue.map { APIItems(json: $0) } }
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = totalItems { dictionary[SerializationKeys.totalItems] = value }
    if let value = kind { dictionary[SerializationKeys.kind] = value }
    if let value = items { dictionary[SerializationKeys.itemsValue] = value.map { $0.dictionaryRepresentation() } }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.totalItems = aDecoder.decodeObject(forKey: SerializationKeys.totalItems) as? Int
    self.kind = aDecoder.decodeObject(forKey: SerializationKeys.kind) as? String
    self.items = aDecoder.decodeObject(forKey: SerializationKeys.itemsValue) as? [APIItems]
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(totalItems, forKey: SerializationKeys.totalItems)
    aCoder.encode(kind, forKey: SerializationKeys.kind)
    aCoder.encode(items, forKey: SerializationKeys.itemsValue)
  }

}
