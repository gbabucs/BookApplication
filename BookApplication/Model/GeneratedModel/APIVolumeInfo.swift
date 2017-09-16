//
//  APIVolumeInfo.swift
//
//  Created by Babu Gangatharan on 9/13/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class APIVolumeInfo: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let maturityRating = "maturityRating"
    static let authors = "authors"
    static let imageLinks = "imageLinks"
    static let readingModes = "readingModes"
    static let language = "language"
    static let previewLink = "previewLink"
    static let ratingsCount = "ratingsCount"
    static let industryIdentifiers = "industryIdentifiers"
    static let allowAnonLogging = "allowAnonLogging"
    static let infoLink = "infoLink"
    static let pageCount = "pageCount"
    static let printType = "printType"
    static let categories = "categories"
    static let panelizationSummary = "panelizationSummary"
    static let subtitle = "subtitle"
    static let contentVersion = "contentVersion"
    static let canonicalVolumeLink = "canonicalVolumeLink"
    static let title = "title"
    static let publishedDate = "publishedDate"
    static let averageRating = "averageRating"
  }

  // MARK: Properties
  public var maturityRating: String?
  public var authors: [String]?
  public var imageLinks: APIImageLinks?
  public var readingModes: APIReadingModes?
  public var language: String?
  public var previewLink: String?
  public var ratingsCount: Int?
  public var industryIdentifiers: [APIIndustryIdentifiers]?
  public var allowAnonLogging: Bool? = false
  public var infoLink: String?
  public var pageCount: Int?
  public var printType: String?
  public var categories: [String]?
  public var panelizationSummary: APIPanelizationSummary?
  public var subtitle: String?
  public var contentVersion: String?
  public var canonicalVolumeLink: String?
  public var title: String?
  public var publishedDate: String?
  public var averageRating: Int?

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
    maturityRating = json[SerializationKeys.maturityRating].string
    if let items = json[SerializationKeys.authors].array { authors = items.map { $0.stringValue } }
    imageLinks = APIImageLinks(json: json[SerializationKeys.imageLinks])
    readingModes = APIReadingModes(json: json[SerializationKeys.readingModes])
    language = json[SerializationKeys.language].string
    previewLink = json[SerializationKeys.previewLink].string
    ratingsCount = json[SerializationKeys.ratingsCount].int
    if let items = json[SerializationKeys.industryIdentifiers].array { industryIdentifiers = items.map { APIIndustryIdentifiers(json: $0) } }
    allowAnonLogging = json[SerializationKeys.allowAnonLogging].boolValue
    infoLink = json[SerializationKeys.infoLink].string
    pageCount = json[SerializationKeys.pageCount].int
    printType = json[SerializationKeys.printType].string
    if let items = json[SerializationKeys.categories].array { categories = items.map { $0.stringValue } }
    panelizationSummary = APIPanelizationSummary(json: json[SerializationKeys.panelizationSummary])
    subtitle = json[SerializationKeys.subtitle].string
    contentVersion = json[SerializationKeys.contentVersion].string
    canonicalVolumeLink = json[SerializationKeys.canonicalVolumeLink].string
    title = json[SerializationKeys.title].string
    publishedDate = json[SerializationKeys.publishedDate].string
    averageRating = json[SerializationKeys.averageRating].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = maturityRating { dictionary[SerializationKeys.maturityRating] = value }
    if let value = authors { dictionary[SerializationKeys.authors] = value }
    if let value = imageLinks { dictionary[SerializationKeys.imageLinks] = value.dictionaryRepresentation() }
    if let value = readingModes { dictionary[SerializationKeys.readingModes] = value.dictionaryRepresentation() }
    if let value = language { dictionary[SerializationKeys.language] = value }
    if let value = previewLink { dictionary[SerializationKeys.previewLink] = value }
    if let value = ratingsCount { dictionary[SerializationKeys.ratingsCount] = value }
    if let value = industryIdentifiers { dictionary[SerializationKeys.industryIdentifiers] = value.map { $0.dictionaryRepresentation() } }
    dictionary[SerializationKeys.allowAnonLogging] = allowAnonLogging
    if let value = infoLink { dictionary[SerializationKeys.infoLink] = value }
    if let value = pageCount { dictionary[SerializationKeys.pageCount] = value }
    if let value = printType { dictionary[SerializationKeys.printType] = value }
    if let value = categories { dictionary[SerializationKeys.categories] = value }
    if let value = panelizationSummary { dictionary[SerializationKeys.panelizationSummary] = value.dictionaryRepresentation() }
    if let value = subtitle { dictionary[SerializationKeys.subtitle] = value }
    if let value = contentVersion { dictionary[SerializationKeys.contentVersion] = value }
    if let value = canonicalVolumeLink { dictionary[SerializationKeys.canonicalVolumeLink] = value }
    if let value = title { dictionary[SerializationKeys.title] = value }
    if let value = publishedDate { dictionary[SerializationKeys.publishedDate] = value }
    if let value = averageRating { dictionary[SerializationKeys.averageRating] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.maturityRating = aDecoder.decodeObject(forKey: SerializationKeys.maturityRating) as? String
    self.authors = aDecoder.decodeObject(forKey: SerializationKeys.authors) as? [String]
    self.imageLinks = aDecoder.decodeObject(forKey: SerializationKeys.imageLinks) as? APIImageLinks
    self.readingModes = aDecoder.decodeObject(forKey: SerializationKeys.readingModes) as? APIReadingModes
    self.language = aDecoder.decodeObject(forKey: SerializationKeys.language) as? String
    self.previewLink = aDecoder.decodeObject(forKey: SerializationKeys.previewLink) as? String
    self.ratingsCount = aDecoder.decodeObject(forKey: SerializationKeys.ratingsCount) as? Int
    self.industryIdentifiers = aDecoder.decodeObject(forKey: SerializationKeys.industryIdentifiers) as? [APIIndustryIdentifiers]
    self.allowAnonLogging = aDecoder.decodeBool(forKey: SerializationKeys.allowAnonLogging)
    self.infoLink = aDecoder.decodeObject(forKey: SerializationKeys.infoLink) as? String
    self.pageCount = aDecoder.decodeObject(forKey: SerializationKeys.pageCount) as? Int
    self.printType = aDecoder.decodeObject(forKey: SerializationKeys.printType) as? String
    self.categories = aDecoder.decodeObject(forKey: SerializationKeys.categories) as? [String]
    self.panelizationSummary = aDecoder.decodeObject(forKey: SerializationKeys.panelizationSummary) as? APIPanelizationSummary
    self.subtitle = aDecoder.decodeObject(forKey: SerializationKeys.subtitle) as? String
    self.contentVersion = aDecoder.decodeObject(forKey: SerializationKeys.contentVersion) as? String
    self.canonicalVolumeLink = aDecoder.decodeObject(forKey: SerializationKeys.canonicalVolumeLink) as? String
    self.title = aDecoder.decodeObject(forKey: SerializationKeys.title) as? String
    self.publishedDate = aDecoder.decodeObject(forKey: SerializationKeys.publishedDate) as? String
    self.averageRating = aDecoder.decodeObject(forKey: SerializationKeys.averageRating) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(maturityRating, forKey: SerializationKeys.maturityRating)
    aCoder.encode(authors, forKey: SerializationKeys.authors)
    aCoder.encode(imageLinks, forKey: SerializationKeys.imageLinks)
    aCoder.encode(readingModes, forKey: SerializationKeys.readingModes)
    aCoder.encode(language, forKey: SerializationKeys.language)
    aCoder.encode(previewLink, forKey: SerializationKeys.previewLink)
    aCoder.encode(ratingsCount, forKey: SerializationKeys.ratingsCount)
    aCoder.encode(industryIdentifiers, forKey: SerializationKeys.industryIdentifiers)
    aCoder.encode(allowAnonLogging, forKey: SerializationKeys.allowAnonLogging)
    aCoder.encode(infoLink, forKey: SerializationKeys.infoLink)
    aCoder.encode(pageCount, forKey: SerializationKeys.pageCount)
    aCoder.encode(printType, forKey: SerializationKeys.printType)
    aCoder.encode(categories, forKey: SerializationKeys.categories)
    aCoder.encode(panelizationSummary, forKey: SerializationKeys.panelizationSummary)
    aCoder.encode(subtitle, forKey: SerializationKeys.subtitle)
    aCoder.encode(contentVersion, forKey: SerializationKeys.contentVersion)
    aCoder.encode(canonicalVolumeLink, forKey: SerializationKeys.canonicalVolumeLink)
    aCoder.encode(title, forKey: SerializationKeys.title)
    aCoder.encode(publishedDate, forKey: SerializationKeys.publishedDate)
    aCoder.encode(averageRating, forKey: SerializationKeys.averageRating)
  }

}
