//
//  ViewController.swift
//  moviee
//
//  Created by Guest on 4/3/19.
//  Copyright © 2019 Guest. All rights reserved.
//

import UIKit
import SwiftyJSON
import Foundation
import ChameleonFramework

struct CellData {
    let actorImage : UIImage?
    let name : String?
    let popularity : Int?
}

class MovieeViewController: UITableViewController {
    
    var arrData = [jsonModel]()
    var arrImages = [(UIImage,String)]()
    var randomColor = UIColor.randomFlat()
    
    var movieePresenter : ViewToPresenterMovieeProtocol?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tableView.register(CustomMovieeCell.self, forCellReuseIdentifier: "custom")
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 200
        self.tableView.separatorStyle = .none
        
        movieePresenter?.startFetching()

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "custom") as! CustomMovieeCell
        
        cell.name = arrData[indexPath.row].actorName
        cell.popularityScore =  arrData[indexPath.row].actorPopularity
        
        if let randomColor = randomColor {
            cell.backgroundColor = randomColor.darken(byPercentage: 1 - CGFloat(indexPath.row) / CGFloat(arrData.count))
            cell.backgroundsColor = randomColor.darken(byPercentage:
                CGFloat(indexPath.row) / CGFloat(arrData.count)
            )
        }

        cell.textsColor = ContrastColorOf(backgroundColor:cell.backgroundsColor!, returnFlat: true)
        
        var boolval = false
        for i in arrImages {
            if (i.1 == arrData[indexPath.row].actorPhoto) {
                cell.imageOfActor = i.0
                boolval = true
                break
            }
        }
        if boolval == false {
            
            movieePresenter?.startImageFetching(photoURL: "http://image.tmdb.org/t/p/w500" + arrData[indexPath.row].actorPhoto,actorString: self.arrData[indexPath.row].actorPhoto)// returns an image ,append it to arrImages and reloadtable.
            for i in arrImages {
                if (i.1 == arrData[indexPath.row].actorPhoto) {
                    cell.imageOfActor = i.0
                    boolval = true
                    break
                }
            }
        }
        cell.layoutSubviews()
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
     func sortByPopularity() {
        self.arrData.sort{
            return $0.actorPopularity > $1.actorPopularity
        }
    }

}

extension MovieeViewController : UISearchBarDelegate {
    
   
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    //Implement Querying data depending on API
        
        searchBar.showsCancelButton = true
        
        movieePresenter?.startSearchBarFetching(SearchBarText: searchBar.text ?? "brad")
        
        let alert = UIAlertController(title: "", message: String(self.arrData.count) + " people found", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        searchBar.tintColor = FlatSkyBlue()
        searchBar.endEditing(true)
        randomColor = UIColor.randomFlat()
        

    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        arrData.removeAll()
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
            movieePresenter?.startFetching()
    }
}

extension MovieeViewController:PresenterToViewMovieeProtocol{
    
    func onResponseSuccess(jsonModelArrayList : [jsonModel]) {
        arrData.removeAll()
        self.arrData = jsonModelArrayList
        sortByPopularity()
        DispatchQueue.main.async {
            //#$#$#$
            self.tableView.reloadData()
        }
    }
    
    func onResponseFailed(error: String) {
        
        let alert = UIAlertController(title: "Alert", message: "Problem Fetching Notice", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    func onResponseImageSuccess (image: UIImage,imageString:String) {
        DispatchQueue.main.async {
            self.arrImages.append((image,imageString))
            self.tableView.reloadData()

        }
        arrImages.removeAll()


    }
    
 
}
