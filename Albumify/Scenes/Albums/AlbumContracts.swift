//
//  AlbumContracts.swift
//  Albumify
//
//  Created by Mert Gürcan on 12.02.2022.
//

import Foundation

// MARK: Interactor
protocol AlbumsInteractorProtocol: AnyObject {
    var delegate : AlbumsInteractorDelegate?  { get set }
    func load()
    func selectedAlbum(index: Int)
}

enum AlbumsInteractorOutput  {
    case showAlbumList(AlbumList)
    case showAlbumDetail(Result)
    case stopSpin
}

protocol AlbumsInteractorDelegate : AnyObject {
    func handleOutput(_ output: AlbumsInteractorOutput )
}

// MARK: Presenter
protocol AlbumsPresenterProtocol: AnyObject {
    func load()
    func selectedAlbum(index: Int)
}

enum AlbumsPresenterOutput: Equatable {
    case showAlbumList(AlbumListPresentation)
    case stopSpin
}

// MARK: View
protocol AlbumsViewProtocol: AnyObject {
    func handleOutput(_ output: AlbumsPresenterOutput)
}

// MARK: Router
protocol AlbumsRouterProtocol : AnyObject {
    func navigate(_ route : AlbumsRoute)
}

enum AlbumsRoute: Equatable {
    case detail(Result)
}
