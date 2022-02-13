//
//  AlbumDetailContracts.swift
//  Albumify
//
//  Created by Mert Gürcan on 13.02.2022.
//

import Foundation

protocol AlbumDetailPresenterProtocol: AnyObject {
    func load()
}

protocol AlbumDetailViewProtocol: AnyObject {
    func update(_ album: ResultPresentation)
}
