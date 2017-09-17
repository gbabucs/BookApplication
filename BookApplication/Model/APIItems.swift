//
//  APIItems.swift
//
//  Created by Babu Gangatharan on 9/16/17.
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class APIItems: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let selfLink = "selfLink"
    static let kind = "kind"
    static let id = "id"
    static let accessInfo = "accessInfo"
    static let etag = "etag"
    static let saleInfo = "saleInfo"
    static let volumeInfo = "volumeInfo"
  }

  // MARK: Properties
  public var selfLink: String?
  public var kind: String?
  public var id: String?
  public var accessInfo: APIAccessInfo?
  public var etag: String?
  public var saleInfo: APISaleInfo?
  public var volumeInfo: APIVolumeInfo?

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
    selfLink = json[SerializationKeys.selfLink].string
    kind = json[SerializationKeys.kind].string
    id = json[SerializationKeys.id].string
    accessInfo = APIAccessInfo(json: json[SerializationKeys.accessInfo])
    etag = json[SerializationKeys.etag].string
    saleInfo = APISaleInfo(json: json[SerializationKeys.saleInfo])
    volumeInfo = APIVolumeInfo(json: json[SerializationKeys.volumeInfo])
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = selfLink { dictionary[SerializationKeys.selfLink] = value }
    if let value = kind { dictionary[SerializationKeys.kind] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = accessInfo { dictionary[SerializationKeys.accessInfo] = value.dictionaryRepresentation() }
    if let value = etag { dictionary[SerializationKeys.etag] = value }
    if let value = saleInfo { dictionary[SerializationKeys.saleInfo] = value.dictionaryRepresentation() }
    if let value = volumeInfo { dictionary[SerializationKeys.volumeInfo] = value.dictionaryRepresentation() }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.selfLink = aDecoder.decodeObject(forKey: SerializationKeys.selfLink) as? String
    self.kind = aDecoder.decodeObject(forKey: SerializationKeys.kind) as? String
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? String
    self.accessInfo = aDecoder.decodeObject(forKey: SerializationKeys.accessInfo) as? APIAccessInfo
    self.etag = aDecoder.decodeObject(forKey: SerializationKeys.etag) as? String
    self.saleInfo = aDecoder.decodeObject(forKey: SerializationKeys.saleInfo) as? APISaleInfo
    self.volumeInfo = aDecoder.decodeObject(forKey: SerializationKeys.volumeInfo) as? APIVolumeInfo
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(selfLink, forKey: SerializationKeys.selfLink)
    aCoder.encode(kind, forKey: SerializationKeys.kind)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(accessInfo, forKey: SerializationKeys.accessInfo)
    aCoder.encode(etag, forKey: SerializationKeys.etag)
    aCoder.encode(saleInfo, forKey: SerializationKeys.saleInfo)
    aCoder.encode(volumeInfo, forKey: SerializationKeys.volumeInfo)
  }

}
