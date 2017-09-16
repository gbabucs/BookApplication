//
//  APIAccessInfo.swift
//
//  Created by Babu Gangatharan on 9/13/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class APIAccessInfo: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let viewability = "viewability"
    static let publicDomain = "publicDomain"
    static let webReaderLink = "webReaderLink"
    static let quoteSharingAllowed = "quoteSharingAllowed"
    static let pdf = "pdf"
    static let accessViewStatus = "accessViewStatus"
    static let epub = "epub"
    static let textToSpeechPermission = "textToSpeechPermission"
    static let embeddable = "embeddable"
    static let country = "country"
  }

  // MARK: Properties
  public var viewability: String?
  public var publicDomain: Bool? = false
  public var webReaderLink: String?
  public var quoteSharingAllowed: Bool? = false
  public var pdf: APIPdf?
  public var accessViewStatus: String?
  public var epub: APIEpub?
  public var textToSpeechPermission: String?
  public var embeddable: Bool? = false
  public var country: String?

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
    viewability = json[SerializationKeys.viewability].string
    publicDomain = json[SerializationKeys.publicDomain].boolValue
    webReaderLink = json[SerializationKeys.webReaderLink].string
    quoteSharingAllowed = json[SerializationKeys.quoteSharingAllowed].boolValue
    pdf = APIPdf(json: json[SerializationKeys.pdf])
    accessViewStatus = json[SerializationKeys.accessViewStatus].string
    epub = APIEpub(json: json[SerializationKeys.epub])
    textToSpeechPermission = json[SerializationKeys.textToSpeechPermission].string
    embeddable = json[SerializationKeys.embeddable].boolValue
    country = json[SerializationKeys.country].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = viewability { dictionary[SerializationKeys.viewability] = value }
    dictionary[SerializationKeys.publicDomain] = publicDomain
    if let value = webReaderLink { dictionary[SerializationKeys.webReaderLink] = value }
    dictionary[SerializationKeys.quoteSharingAllowed] = quoteSharingAllowed
    if let value = pdf { dictionary[SerializationKeys.pdf] = value.dictionaryRepresentation() }
    if let value = accessViewStatus { dictionary[SerializationKeys.accessViewStatus] = value }
    if let value = epub { dictionary[SerializationKeys.epub] = value.dictionaryRepresentation() }
    if let value = textToSpeechPermission { dictionary[SerializationKeys.textToSpeechPermission] = value }
    dictionary[SerializationKeys.embeddable] = embeddable
    if let value = country { dictionary[SerializationKeys.country] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.viewability = aDecoder.decodeObject(forKey: SerializationKeys.viewability) as? String
    self.publicDomain = aDecoder.decodeBool(forKey: SerializationKeys.publicDomain)
    self.webReaderLink = aDecoder.decodeObject(forKey: SerializationKeys.webReaderLink) as? String
    self.quoteSharingAllowed = aDecoder.decodeBool(forKey: SerializationKeys.quoteSharingAllowed)
    self.pdf = aDecoder.decodeObject(forKey: SerializationKeys.pdf) as? APIPdf
    self.accessViewStatus = aDecoder.decodeObject(forKey: SerializationKeys.accessViewStatus) as? String
    self.epub = aDecoder.decodeObject(forKey: SerializationKeys.epub) as? APIEpub
    self.textToSpeechPermission = aDecoder.decodeObject(forKey: SerializationKeys.textToSpeechPermission) as? String
    self.embeddable = aDecoder.decodeBool(forKey: SerializationKeys.embeddable)
    self.country = aDecoder.decodeObject(forKey: SerializationKeys.country) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(viewability, forKey: SerializationKeys.viewability)
    aCoder.encode(publicDomain, forKey: SerializationKeys.publicDomain)
    aCoder.encode(webReaderLink, forKey: SerializationKeys.webReaderLink)
    aCoder.encode(quoteSharingAllowed, forKey: SerializationKeys.quoteSharingAllowed)
    aCoder.encode(pdf, forKey: SerializationKeys.pdf)
    aCoder.encode(accessViewStatus, forKey: SerializationKeys.accessViewStatus)
    aCoder.encode(epub, forKey: SerializationKeys.epub)
    aCoder.encode(textToSpeechPermission, forKey: SerializationKeys.textToSpeechPermission)
    aCoder.encode(embeddable, forKey: SerializationKeys.embeddable)
    aCoder.encode(country, forKey: SerializationKeys.country)
  }

}
