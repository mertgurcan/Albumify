//
//  AlbumsRouter.swift
//  Albumify
//
//  Created by Mert Gürcan on 13.02.2022.
//

import Foundation
import UIKit

class AlbumsRouter : AlbumsRouterProtocol {

    let view : UIViewController

    init(view: UIViewController){
        self.view = view
    }

    func navigate(_ route: AlbumsRoute) {
        switch route {
        case .detail(let result):
            let vc = AlbumDetailBuilder.create(with: result)
            view.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
