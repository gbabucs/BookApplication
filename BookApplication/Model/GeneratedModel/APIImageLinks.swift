//
//  APIImageLinks.swift
//
//  Created by Babu Gangatharan on 9/13/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class APIImageLinks: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let thumbnail = "thumbnail"
    static let smallThumbnail = "smallThumbnail"
  }

  // MARK: Properties
  public var thumbnail: String?
  public var smallThumbnail: String?

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
    thumbnail = json[SerializationKeys.thumbnail].string
    smallThumbnail = json[SerializationKeys.smallThumbnail].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = thumbnail { dictionary[SerializationKeys.thumbnail] = value }
    if let value = smallThumbnail { dictionary[SerializationKeys.smallThumbnail] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.thumbnail = aDecoder.decodeObject(forKey: SerializationKeys.thumbnail) as? String
    self.smallThumbnail = aDecoder.decodeObject(forKey: SerializationKeys.smallThumbnail) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(thumbnail, forKey: SerializationKeys.thumbnail)
    aCoder.encode(smallThumbnail, forKey: SerializationKeys.smallThumbnail)
  }

}
