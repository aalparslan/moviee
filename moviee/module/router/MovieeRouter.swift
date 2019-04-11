//
//  MovieeRouter.swift
//  moviee
//
//  Created by Guest on 4/9/19.
//  Copyright © 2019 Guest. All rights reserved.
//

import Foundation
import UIKit

class MovieeRouter:PresenterToRouterMovieeProtocol{
    
    static func createMovieeModule() -> MovieeViewController {
        
        let view = MovieeRouter.mainstoryboard.instantiateViewController(withIdentifier: "MovieeViewController") as! MovieeViewController
        
        let presenter: ViewToPresenterMovieeProtocol & InteractorToPresenterMovieeProtocol = MovieePresenter()
        let interactor: PresenterToInteractorMovieeProtocol = MovieeInteractor()
        let router:PresenterToRouterMovieeProtocol = MovieeRouter()
        
        view.movieePresenter = presenter 
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
        
    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
}
