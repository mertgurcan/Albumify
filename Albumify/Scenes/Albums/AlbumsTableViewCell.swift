//
//  AlbumsTableViewCell.swift
//  Albumify
//
//  Created by Mert Gürcan on 13.02.2022.
//

import Foundation
import UIKit

class AlbumsTableViewCell: UITableViewCell {

    var result: ResultPresentation? {
        didSet {
            guard let result = result else {
                return
            }
            ImageDownloader.downloaded(from: result.image) { image in
                self.albumImage.image = image
            }
            albumName.text = result.albumName
        }
    }

    var albumImage : UIImageView = {
        let iv = UIImageView()
        return iv
    }()

    var albumName : UILabel = {
        let l = UILabel()
        l.textColor = .black
        l.numberOfLines = 0
        return l
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    func setupViews() {
        backgroundColor = .white
        addSubview(albumImage)
        albumImage.anchor(top: topAnchor, left: leftAnchor, bot: bottomAnchor, right: nil, topConstant: 10, leftConstant: 10, botConstant: 10, rightConstant: 0, width: 100, height: 0)

        addSubview(albumName)
        albumName.anchor(top: topAnchor, left: albumImage.rightAnchor, bot: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 30, botConstant: 0, rightConstant: 20, width: 0, height: 0)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
