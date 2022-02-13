//
//  AlbumDetailPresenter.swift
//  Albumify
//
//  Created by Mert Gürcan on 13.02.2022.
//

import Foundation

final class AlbumDetailPresenter: AlbumDetailPresenterProtocol {

    unowned var view: AlbumDetailViewProtocol
    private let album: ResultPresentation

    init(view: AlbumDetailViewProtocol, album: ResultPresentation) {
        self.view = view
        self.album = album
    }

    func load() {
        view.update(album)
    }
}
