//
//  AlbumListPresentation.swift
//  Albumify
//
//  Created by Mert Gürcan on 13.02.2022.
//

import Foundation

// MARK: - AlbumListPresentation
class AlbumListPresentation: NSObject {
    var results : [ResultPresentation]

    init(results: [ResultPresentation]) {
        self.results = results
    }

    convenience init(albumList : AlbumList) {
        self.init(results: (albumList.feed?.results.map(ResultPresentation.init))!)
    }

    static func ==(left: AlbumListPresentation, right : AlbumListPresentation) -> Bool {
        return left.results == right.results
    }

    override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? AlbumListPresentation else { return false}
        return self == other
    }
}

// MARK: - ResultPresentation
class ResultPresentation: NSObject {
    var genre : [GenrePresentation]
    var releaseDate : String
    var artistName : String
    var albumName : String
    var image: String

    init(genre : [GenrePresentation] , releaseDate : String, artistName : String,albumName : String , image: String) {
        self.genre = genre
        self.releaseDate = releaseDate
        self.artistName = artistName
        self.albumName = albumName
        self.image = image
    }

    convenience init(result: Result) {
        self.init(genre: result.genres.map(GenrePresentation.init), releaseDate: result.releaseDate, artistName: result.artistName, albumName: result.name, image: result.artworkUrl100)
    }

    static func ==(left: ResultPresentation, right : ResultPresentation) -> Bool {
        return left.releaseDate == right.releaseDate
    }

    override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? ResultPresentation else { return false}
        return self == other
    }
}

// MARK: - GenrePresentation
class GenrePresentation : NSObject {
    var name : String

    init(name : String){
        self.name = name
    }

    convenience init(genre : Genre) {
        self.init(name: genre.name)
    }

    static func ==(left: GenrePresentation, right : GenrePresentation) -> Bool {
        return left.name == right.name
    }

    override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? GenrePresentation else { return false}
        return self == other
    }
}
