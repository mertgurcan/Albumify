//
//  AlbumsViewController.swift
//  Albumify
//
//  Created by Mert Gürcan on 13.02.2022.
//

import Foundation
import UIKit

class AlbumsViewController: UIViewController, AlbumsViewProtocol {

    private let BASICCELLIDENTIFIER = "BasicCellIdentifier"

    var presenter : AlbumsPresenterProtocol!

    private var albums : AlbumListPresentation?

    lazy var tableView : UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .white
        tv.delegate = self
        tv.dataSource = self
        tv.register(AlbumsTableViewCell.self, forCellReuseIdentifier: BASICCELLIDENTIFIER)
        return tv
    }()

    lazy var refresher : UIRefreshControl = {
        let r = UIRefreshControl()
        r.layer.zPosition = -1
        r.tintColor = .green
        r.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        return r
    }()

    lazy var loadingView : UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView()
        ai.hidesWhenStopped = true
        ai.style = .large
        ai.color = .green
        return ai
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.load()
        loadingView.startAnimating()
        setupViews()
    }

    func setupViews() {
        self.navigationController?.navigationBar.topItem?.title = "Most Played 50 Albums"
        self.navigationController?.navigationBar.tintColor = .white

        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bot: view.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, botConstant: 0, rightConstant: 0, width: 0, height: 0 )

        tableView.addSubview(refresher)
        refresher.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bot: nil, right: view.rightAnchor, topConstant: 10, leftConstant: 0, botConstant: 0, rightConstant: 0, width: 0, height: 30)

        view.addSubview(loadingView)
        loadingView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bot: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, botConstant: 0, rightConstant: 0, width: 0, height: 0)
    }

    func handleOutput(_ output: AlbumsPresenterOutput) {
        switch output {
        case .showAlbumList(let albumListPresentation):
            albums = albumListPresentation
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        case .stopSpin:
            DispatchQueue.main.async {
                self.loadingView.stopAnimating()
                self.refresher.endRefreshing()
            }
        }
    }

    @objc func refreshTableView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(Int(0.5))) {
            self.presenter.load()
        }
    }
}

extension AlbumsViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums?.results.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BASICCELLIDENTIFIER, for: indexPath) as? AlbumsTableViewCell
        cell?.result = albums?.results[indexPath.row]
        cell?.selectionStyle = .none
        return cell ?? UITableViewCell()
    }
}

extension AlbumsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectedAlbum(index: indexPath.row)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
