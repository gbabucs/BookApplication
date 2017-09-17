//
//  APIPanelizationSummary.swift
//
//  Created by Babu Gangatharan on 9/16/17.
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class APIPanelizationSummary: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let containsEpubBubbles = "containsEpubBubbles"
    static let containsImageBubbles = "containsImageBubbles"
  }

  // MARK: Properties
  public var containsEpubBubbles: Bool? = false
  public var containsImageBubbles: Bool? = false

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
    containsEpubBubbles = json[SerializationKeys.containsEpubBubbles].boolValue
    containsImageBubbles = json[SerializationKeys.containsImageBubbles].boolValue
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    dictionary[SerializationKeys.containsEpubBubbles] = containsEpubBubbles
    dictionary[SerializationKeys.containsImageBubbles] = containsImageBubbles
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.containsEpubBubbles = aDecoder.decodeBool(forKey: SerializationKeys.containsEpubBubbles)
    self.containsImageBubbles = aDecoder.decodeBool(forKey: SerializationKeys.containsImageBubbles)
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(containsEpubBubbles, forKey: SerializationKeys.containsEpubBubbles)
    aCoder.encode(containsImageBubbles, forKey: SerializationKeys.containsImageBubbles)
  }

}
