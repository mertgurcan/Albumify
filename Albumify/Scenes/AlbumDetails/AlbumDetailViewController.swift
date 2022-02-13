//
//  AlbumDetailViewController.swift
//  Albumify
//
//  Created by Mert Gürcan on 13.02.2022.
//

import Foundation
import UIKit

class AlbumDetailViewController: UIViewController ,AlbumDetailViewProtocol {

    var presenter: AlbumDetailPresenterProtocol!

    var albumImage : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    var artistNameLabel : UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.numberOfLines = 0
        l.textColor = .black
        return l
    }()

    var releaseDateLabel : UILabel = {
        let l = UILabel()
        l.textColor = .black
        l.textAlignment = .center
        return l
    }()

    var genreLabel : UILabel = {
        let l = UILabel()
        l.textColor = .black
        l.textAlignment = .center
        l.text = ""
        return l
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        presenter.load()
    }

    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(albumImage)
        albumImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bot: nil, right: view.rightAnchor, topConstant: 30, leftConstant: 30, botConstant: 0, rightConstant: 30, width: 0, height: 200)

        view.addSubview(artistNameLabel)
        artistNameLabel.anchor(top: albumImage.bottomAnchor, left: albumImage.leftAnchor, bot: nil, right: albumImage.rightAnchor, topConstant: 20, leftConstant: 0, botConstant: 0, rightConstant: 0, width: 0, height: 50)

        view.addSubview(releaseDateLabel)
        releaseDateLabel.anchor(top: artistNameLabel.bottomAnchor, left: albumImage.leftAnchor, bot: nil, right: albumImage.rightAnchor, topConstant: 20, leftConstant: 0, botConstant: 0, rightConstant: 0, width: 0, height: 25)

        view.addSubview(genreLabel)
        genreLabel.anchor(top: releaseDateLabel.bottomAnchor, left: albumImage.leftAnchor, bot: nil, right: albumImage.rightAnchor, topConstant: 20, leftConstant: 0, botConstant: 0, rightConstant: 0, width: 0, height: 25)


    }

    func update(_ album: ResultPresentation) {
        ImageDownloader.downloaded(from: album.image) { image in
            self.albumImage.image = image
        }
        artistNameLabel.text = album.artistName + " / " +  album.albumName
        releaseDateLabel.text = album.releaseDate
        for genre in album.genre {
            genreLabel.text! += " \(genre.name)"
        }

    }
}
