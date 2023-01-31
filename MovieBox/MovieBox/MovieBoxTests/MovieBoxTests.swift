//
//  MovieBoxTests.swift
//  MovieBoxTests
//
//  Created by Talha Gölcügezli on 20.01.2023.
//

import XCTest
@testable import MovieBox


final class MovieBoxTests: XCTestCase {
    
    private var presenter : MovieListPresenter!
    private var interactor : MovieListInteractor!
    private var view : MockMovieListView!
    private var router : MockMovieListRouter!
    private var service : MockTopMoviesService!
    
    override func setUpWithError() throws {
        service = MockTopMoviesService()
        interactor = MovieListInteractor(service: service)
        view = MockMovieListView()
        router = MockMovieListRouter()
        
       presenter = MovieListPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        
    }
    
    func testLoad() throws {
        //Given:
        let movie1 = try ResourceLoader.loadMovie(resource: .movie1)
        let movie2 = try ResourceLoader.loadMovie(resource: .movie2)
        
        service.movies = [movie1,movie2]
        
        
        //When:
        
        view.viewDidLoad()
        
        //Then:
        
        XCTAssertEqual(view.outputs.elementsEqual(1), MovieListPresenterOutput.setLoading(false))
        
    }


    

}

private final class MockMovieListView : MovieListViewProtocol {
    var presenter : MovieListPresenter!
    var outputs: [MovieListPresenterOutput] = []
    
    func viewDidLoad() {
        presenter.load()
    }
    
    func handleOutput(_ output: MovieListPresenterOutput) {
        outputs.append(output)
    }
}

private final class MockMovieListRouter : MovieListRouterProtocol {
    
    var routes : [MovieListRoute] = []
    
    func navigate(to route: MovieListRoute) {
        routes.append(route)
    }
}
