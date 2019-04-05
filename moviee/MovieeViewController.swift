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


    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        self.tableView.register(CustomMovieeCell.self, forCellReuseIdentifier: "custom")
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 200
        
        jsonParsing()
        tableView.separatorStyle = .none
      
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
            if let imageURL = URL(string:"http://image.tmdb.org/t/p/w500" + arrData[indexPath.row].actorPhoto ) {
                
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: imageURL)
                    if let data = data {
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            if  let cacheImage = image{
                                self.arrImages.append((cacheImage,self.arrData[indexPath.row].actorPhoto ))
                            }
                            cell.imageOfActor = image
                            tableView.reloadData()
                        }
                    }
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
    
    func jsonParsing () {
        let url = URL(string: "https://api.themoviedb.org/3/person/popular?page=1&language=en-US&api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else {return}
            do{
                let json = try JSON(data:data)
                let results = json ["results"]
                for arr in results.arrayValue{
                
                    self.arrData.append(jsonModel(json: arr))
                }
                self.sortByPopularity()
            }catch{
                print(error.localizedDescription)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }.resume()
        
        randomColor = UIColor.randomFlat()
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
        arrData.removeAll() //since  an empty array is needed
        arrImages.removeAll()
        
        let url = URL(string: "https://api.themoviedb.org/3/search/person?include_adult=false&page=1&query=" + (searchBar.text ?? "brad") + "&language=en-US&api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")//defaulted to brad
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else {return}
            do{
                let json = try JSON(data:data)
                let results = json ["results"]
                for arr in results.arrayValue{
                    
                    self.arrData.append(jsonModel(json: arr))
                    
                }
                self.sortByPopularity()
                
                let alert = UIAlertController(title: "", message: String(self.arrData.count) + " people found", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                searchBar.tintColor = FlatSkyBlue()
              
  

            }catch{
                print(error.localizedDescription)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            }.resume()
        searchBar.endEditing(true)
        randomColor = UIColor.randomFlat()

    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        arrData.removeAll() //since  an empty array is needed
        arrImages.removeAll()
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
        jsonParsing()
    }
    
    
}
