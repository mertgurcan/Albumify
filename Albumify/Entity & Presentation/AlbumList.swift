//
//  AlbumList.swift
//  Albumify
//
//  Created by Mert Gürcan on 12.02.2022.
//
//

import Foundation

// MARK: - AlbumList
class AlbumList: Codable {
    var feed: Feed?

    init(feed: Feed?) {
        self.feed = feed
    }
}

// MARK: - Feed
class Feed: Codable {
    let title: String?
    let id: String?
    let author: Author?
    let links: [Link]?
    let copyright, country: String?
    let icon: String?
    let updated: String?
    var results: [Result]

    init(title: String?, id: String?, author: Author?, links: [Link]?, copyright: String?, country: String?, icon: String?, updated: String?, results: [Result]) {
        self.title = title
        self.id = id
        self.author = author
        self.links = links
        self.copyright = copyright
        self.country = country
        self.icon = icon
        self.updated = updated
        self.results = results
    }
}

// MARK: - Author
class Author: Codable {
    let name: String?
    let url: String?

    init(name: String?, url: String?) {
        self.name = name
        self.url = url
    }
}

// MARK: - Link
class Link: Codable {
    let linkSelf: String?

    enum CodingKeys: String, CodingKey {
        case linkSelf = "self"
    }

    init(linkSelf: String?) {
        self.linkSelf = linkSelf
    }
}

// MARK: - Result
struct Result: Codable, Equatable {

    let artistName, id, name, releaseDate: String
    let kind: Kind?
    let artistID: String?
    let artistURL: String?
    let artworkUrl100: String
    let genres: [Genre]
    let url: String?
    let contentAdvisoryRating: ContentAdvisoryRating?

    enum CodingKeys: String, CodingKey {
        case artistName, id, name, releaseDate, kind
        case artistID = "artistId"
        case artistURL = "artistUrl"
        case artworkUrl100, genres, url, contentAdvisoryRating
    }

    init(artistName: String, id: String, name: String, releaseDate: String, kind: Kind?, artistID: String?, artistURL: String?, artworkUrl100: String , genres: [Genre], url: String?, contentAdvisoryRating: ContentAdvisoryRating?) {
        self.artistName = artistName
        self.id = id
        self.name = name
        self.releaseDate = releaseDate
        self.kind = kind
        self.artistID = artistID
        self.artistURL = artistURL
        self.artworkUrl100 = artworkUrl100
        self.genres = genres
        self.url = url
        self.contentAdvisoryRating = contentAdvisoryRating
    }

    static func == (lhs: Result, rhs: Result) -> Bool {
        return lhs.name == rhs.name
    }
}

enum ContentAdvisoryRating: String, Codable {
    case explict = "Explict"
}

// MARK: - Genre
class Genre: Codable {
    let genreID: String?
    let name: String
    let url: String?

    enum CodingKeys: String, CodingKey {
        case genreID = "genreId"
        case name, url
    }

    // TODO: name can be enum but we have to know all genres
    init(genreID: String?, name: String, url: String?) {
        self.genreID = genreID
        self.name = name
        self.url = url
    }
}

enum Kind: String, Codable {
    case albums = "albums"
}
