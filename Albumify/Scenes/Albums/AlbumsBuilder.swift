//
//  AlbumsBuilder.swift
//  Albumify
//
//  Created by Mert Gürcan on 13.02.2022.
//

import Foundation

class AlbumsBuilder {
    static func create() -> AlbumsViewController {
        let service = Service()
        
        let vc = AlbumsViewController()
        let router = AlbumsRouter(view: vc)
        let interactor = AlbumsInteractor(service: service)
        let presenter = AlbumsPresenter(view: vc, interactor: interactor, router: router)
        vc.presenter = presenter
        return vc
    }
}
