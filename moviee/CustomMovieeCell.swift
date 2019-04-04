//
//  CustomMovieeCell.swift
//  moviee
//
//  Created by Guest on 4/3/19.
//  Copyright © 2019 Guest. All rights reserved.
//

import Foundation
import UIKit
import ChameleonFramework


class CustomMovieeCell : UITableViewCell{
    
    var name : String?
    var popularityScore : Float?
    var imageOfActor : UIImage?
    var backgroundsColor : UIColor?
    var textsColor:UIColor?

    
    
    var nameView : UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        textView.font = UIFont(name: "HelveticaNeue", size: 25)

        return textView
    }()
    
    var actorImageView : UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var popularityView : UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        textView.font = UIFont(name: "HelveticaNeue", size: 15)

        return textView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        self.addSubview(nameView)
        self.addSubview(actorImageView)
        self.addSubview(popularityView)
        
        
        actorImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        actorImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        actorImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        actorImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        actorImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        nameView.leftAnchor.constraint(equalTo: actorImageView.rightAnchor, constant: 15).isActive = true
        nameView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        nameView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        nameView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
        
        
        popularityView.leftAnchor.constraint(equalTo: actorImageView.rightAnchor ,constant: 15).isActive = true
        popularityView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        popularityView.topAnchor.constraint(equalTo: nameView.bottomAnchor ).isActive = true
        popularityView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let textsColor = textsColor {
            nameView.textColor = textsColor
            popularityView.textColor = textsColor
        }
        if let backgroundsColor = backgroundsColor{
            nameView.backgroundColor = backgroundsColor
            popularityView.backgroundColor = backgroundsColor

        }
        if let name = name {
            nameView.text = name
        }
        if let actorImage = imageOfActor {
            actorImageView.image = actorImage
        }
        if let popularity = popularityScore {
            popularityView.text = "Popularity:  " + String(popularity)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
