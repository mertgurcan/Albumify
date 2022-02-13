//
//  AlbumifyTests.swift
//  AlbumifyTests
//
//  Created by Mert Gürcan on 12.02.2022.
//

import XCTest
@testable import Albumify

class AlbumifyTests: XCTestCase {

    private var presenter : AlbumsPresenter!
    private var interactor : AlbumsInteractor!
    private var service : MockService!
    private var view : MockView!
    private var router : MockRouter!


    override func setUpWithError() throws {
        service = MockService()
        interactor = AlbumsInteractor(service: service)
        view = MockView()
        router = MockRouter()
        presenter = AlbumsPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
    }

    func testLoad() throws {
        guard let resp = Helper.getData() as? AlbumList  else  {
            XCTFail()
            return
        }

        service.response = resp
        presenter.load()

        XCTAssertEqual(view.outputs.count, 2)
        XCTAssertEqual(view.outputs[0], .stopSpin)

        let presentation = AlbumListPresentation(albumList: resp)
        XCTAssertEqual(view.outputs[1], .showAlbumList(presentation))
    }

    func testLoadFail() {
        service.isSuccess = false
        presenter.load()

        XCTAssertEqual(view.outputs.count, 0)
    }

    func testSelectAlbum() {
        guard let resp = Helper.getData() as? AlbumList  else  {
            XCTFail()
            return
        }
        service.response = resp
        presenter.load()
        presenter.selectedAlbum(index: 1)

        XCTAssertEqual(router.routes.count, 1)
        XCTAssertEqual(router.routes[0], .detail((resp.feed?.results[1])!))
    }

    override func tearDownWithError() throws {
        view.reset()
        service.reset()
    }

}

private class MockView : AlbumsViewProtocol {

    var outputs : [AlbumsPresenterOutput] = []

    var presenter : AlbumsPresenter!

    func viewDidLoad() {
        presenter.load()
    }

    func handleOutput(_ output: AlbumsPresenterOutput) {
        outputs.append(output)
    }

    func reset() {
        outputs.removeAll()
    }
}

private class MockRouter : AlbumsRouterProtocol {

    var routes : [AlbumsRoute] = []

    func navigate(_ route: AlbumsRoute) {
        routes.append(route)
    }
}


class MockService: ServiceProtocol  {

    var response: Codable?
    var isSuccess : Bool = true
    var err : Error?


    func load<T>(resource: Resource<T>, completion: @escaping (URLNetworkResponse<T?>) -> ()) where T : Decodable, T : Encodable {
        if isSuccess {
            completion(.succes(response as? T))
        } else {
            if let err = err as? CustomError {
                switch err {
                case .parseError:
                    completion(.failure(CustomError.parseError))
                default:
                    completion(.failure(CustomError.serverError(err)))
                }
            }
        }
    }

    func reset() {
        isSuccess = true
        response = nil
    }

}
