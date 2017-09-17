//
//  APIReadingModes.swift
//
//  Created by Babu Gangatharan on 9/16/17.
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class APIReadingModes: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let image = "image"
    static let text = "text"
  }

  // MARK: Properties
  public var image: Bool? = false
  public var text: Bool? = false

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
    image = json[SerializationKeys.image].boolValue
    text = json[SerializationKeys.text].boolValue
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    dictionary[SerializationKeys.image] = image
    dictionary[SerializationKeys.text] = text
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.image = aDecoder.decodeBool(forKey: SerializationKeys.image)
    self.text = aDecoder.decodeBool(forKey: SerializationKeys.text)
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(image, forKey: SerializationKeys.image)
    aCoder.encode(text, forKey: SerializationKeys.text)
  }

}
