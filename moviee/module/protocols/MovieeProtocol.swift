//
//  MovieeProtocol.swift
//  moviee
//
//  Created by Guest on 4/9/19.
//  Copyright © 2019 Guest. All rights reserved.
//

import Foundation
import UIKit


protocol ViewToPresenterMovieeProtocol:class{
    
    var view: PresenterToViewMovieeProtocol? {get set}
    var interactor: PresenterToInteractorMovieeProtocol? {get set}
    var router: PresenterToRouterMovieeProtocol? {get set}
    func startFetching()
    func startImageFetching(photoURL : String,actorString :String)
    func startSearchBarFetching(SearchBarText:String)
    
}

protocol PresenterToViewMovieeProtocol:class {
    
    func onResponseSuccess(jsonModelArrayList:Array<jsonModel>)
    func onResponseFailed(error:String)
    
    func onResponseImageSuccess(image: UIImage,imageString:String)
    
}

protocol PresenterToRouterMovieeProtocol:class {
    
    static func createMovieeModule()->MovieeViewController
    
}

protocol PresenterToInteractorMovieeProtocol:class {
    
    var presenter:InteractorToPresenterMovieeProtocol? {get set}
    func fetch()//this may cause a problem! Check twice!!!
    func imageFetch(photoURL : String ,actorString :String )
    func searchBarFetch(SearchBarText:String)
    
}

protocol InteractorToPresenterMovieeProtocol:class {
    
    func FetchSuccess(arrDatA:Array<jsonModel>)
    func FetchFailed()
    func FetchImageSuccess(image : UIImage,imageString: String)
    
}
