//
//  AlbumsInteractor.swift
//  Albumify
//
//  Created by Mert Gürcan on 13.02.2022.
//

import Foundation

class AlbumsInteractor : AlbumsInteractorProtocol {

    weak var delegate : AlbumsInteractorDelegate?

    private let url = "https://rss.applemarketingtools.com/api/v2/us/music/most-played/50/albums.json"

    private let service : ServiceProtocol
    private var loadResources : Resource<AlbumList>?

    private var albumList : AlbumList?

    init(service: ServiceProtocol) {
        self.service = service
    }

    func load() {
        loadResources = Resource<AlbumList>(url: url, param: nil)
        guard let loadResources = loadResources else {
            return
        }
        service.load(resource: loadResources) { result in
            self.delegate?.handleOutput(.stopSpin)
            switch result {
            case .succes(let data):
                if let data = data {
                    self.albumList = data
                    self.delegate?.handleOutput(.showAlbumList(data))

                }
            case .failure(let err):
                // FIXME: Errors should handle
                print("Failed")
            }
        }
    }

    func selectedAlbum(index: Int) {
        if let album = albumList?.feed?.results[index] {
            delegate?.handleOutput(.showAlbumDetail(album))
        }
    }
}
