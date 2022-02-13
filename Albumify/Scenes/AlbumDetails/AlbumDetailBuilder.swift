//
//  AlbumDetailBuilder.swift
//  Albumify
//
//  Created by Mert Gürcan on 13.02.2022.
//

import Foundation


import Foundation

class AlbumDetailBuilder {
    static func create(with album: Result) -> AlbumDetailViewController {

        let vc = AlbumDetailViewController()

        let presenter = AlbumDetailPresenter(view: vc, album: ResultPresentation(result: album))
        vc.presenter = presenter
        return vc
    }
}
