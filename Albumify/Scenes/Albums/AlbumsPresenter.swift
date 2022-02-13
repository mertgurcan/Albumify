//
//  AlbumsPresenter.swift
//  Albumify
//
//  Created by Mert Gürcan on 13.02.2022.
//

import Foundation

class AlbumsPresenter : AlbumsPresenterProtocol {


    let view : AlbumsViewProtocol
    private let interactor : AlbumsInteractorProtocol
    private let router : AlbumsRouterProtocol

    init (view: AlbumsViewProtocol, interactor: AlbumsInteractorProtocol, router : AlbumsRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.interactor.delegate = self
    }

    func load() {
        interactor.load()
    }

    func selectedAlbum(index: Int) {
        interactor.selectedAlbum(index: index)
    }
}

extension AlbumsPresenter : AlbumsInteractorDelegate{
    func handleOutput(_ output: AlbumsInteractorOutput) {
        switch output {
        case .showAlbumList(let albumList):
            view.handleOutput(.showAlbumList(AlbumListPresentation(albumList: albumList)))
        case .showAlbumDetail(let result):
            router.navigate(.detail(result))
        case .stopSpin:
            view.handleOutput(.stopSpin)
        }
    }
}
