//
//  MovieePresenter.swift
//  moviee
//
//  Created by Guest on 4/9/19.
//  Copyright © 2019 Guest. All rights reserved.
//

import Foundation
import UIKit

class MovieePresenter:ViewToPresenterMovieeProtocol{

    
    
    var view: PresenterToViewMovieeProtocol?
    
    var interactor: PresenterToInteractorMovieeProtocol?
    
    var router: PresenterToRouterMovieeProtocol?
    
    func startFetching() {
        interactor?.fetch()
    }
    func startImageFetching(photoURL : String ,actorString :String ) {
        interactor?.imageFetch(photoURL: photoURL, actorString: actorString)
    }
    func startSearchBarFetching(SearchBarText:String){
        interactor?.searchBarFetch(SearchBarText: SearchBarText)
    }
}

extension MovieePresenter:InteractorToPresenterMovieeProtocol{
    
    func FetchSuccess(arrDatA: [jsonModel]) {
        view?.onResponseSuccess(jsonModelArrayList: arrDatA)
    }
    
    func FetchFailed() {
        view?.onResponseFailed(error: "Some Error message from api response")
    }
    func FetchImageSuccess(image : UIImage,imageString: String) {
        view?.onResponseImageSuccess(image:image, imageString: imageString)
    }
    
    
}
