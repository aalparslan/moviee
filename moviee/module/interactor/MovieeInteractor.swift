//
//  MovieeInteractor.swift
//  moviee
//
//  Created by Guest on 4/9/19.
//  Copyright © 2019 Guest. All rights reserved.
//

import Foundation
import SwiftyJSON



class MovieeInteractor:PresenterToInteractorMovieeProtocol{
    
    var presenter: InteractorToPresenterMovieeProtocol?
    var dataArr =  [jsonModel]()
    
    
    func fetch() {
        
        let url = URL(string: "https://api.themoviedb.org/3/person/popular?page=1&language=en-US&api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else {return}
            do{
                let json = try JSON(data:data)
                let results = json ["results"]
                for arr in results.arrayValue{
                    
                    self.dataArr.append(jsonModel(json: arr))
                }
            }catch{
                print(error.localizedDescription)
                self.presenter?.FetchFailed()
            }
            self.presenter?.FetchSuccess(arrDatA: self.dataArr)

            }.resume()
    }
    func imageFetch (photoURL : String ,actorString :String ) {
        
        if let imageURL = URL(string:photoURL ) {

          //  DispatchQueue.main.async {
                let data = try? Data(contentsOf: imageURL)
                if let data = data {
                    if  let image = UIImage(data: data) {
                        self.presenter?.FetchImageSuccess(image: image, imageString: actorString)
                    }else{
                        print("Error with image")
                    }

                }
           // }
        }
    }
    
    func searchBarFetch(SearchBarText:String){
        dataArr.removeAll() //since  an empty array is needed
        let url = URL(string: "https://api.themoviedb.org/3/search/person?include_adult=false&page=1&query=" + (SearchBarText) + "&language=en-US&api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")//defaulted to brad
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else {return}
            do{
                let json = try JSON(data:data)
                let results = json ["results"]
                
                for arr in results.arrayValue{
                    
                    self.dataArr.append(jsonModel(json: arr))
                }

            }catch{
                print(error.localizedDescription)
                self.presenter?.FetchFailed()
            }
            self.presenter?.FetchSuccess(arrDatA: self.dataArr)

            }.resume()
    }
 
}
