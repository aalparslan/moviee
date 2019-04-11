//
//  movieeTests.swift
//  movieeTests
//
//  Created by Guest on 4/10/19.
//  Copyright © 2019 Guest. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import moviee

class movieeTests: XCTestCase {
    
     let viewC = MovieeViewController()
    


    

    func testView(){
        
        
        let model1 = jsonModel(json: JSON(dictionaryLiteral: ("name", "name1"),("popularity","25.5"),("profile_path","TABNG8Sw4EVN3xodn2JBdEmBqv.jpgu")))
        let model2 = jsonModel(json: JSON(dictionaryLiteral: ("name", "name2"),("popularity","10"),("profile_path","TABNG8Sw4EVN3xodn2JBdEmBaaa.jpgu")))
        let model3 = jsonModel(json: JSON(dictionaryLiteral: ("name", "name3"),("popularity","30"),("profile_path","TABNG8Sw4EVN3djhaisugduyg2.jpgu")))
        
        let DataArr = [model1,model2,model3]
        
        viewC.arrData = DataArr
        
        viewC.sortByPopularity()
        
        XCTAssertEqual(viewC.arrData[0].actorName,"name3" )
        XCTAssertEqual(viewC.arrData[0].actorPopularity,30)
        XCTAssertEqual(viewC.arrData[0].actorPhoto,"TABNG8Sw4EVN3djhaisugduyg2.jpgu")

        viewC.onResponseSuccess(jsonModelArrayList: [model2])
        XCTAssertEqual(viewC.arrData[0].actorName,"name2" )
        XCTAssertEqual(viewC.arrData[0].actorPopularity,10)
        XCTAssertEqual(viewC.arrData[0].actorPhoto,"TABNG8Sw4EVN3xodn2JBdEmBaaa.jpgu")

        viewC.onResponseImageSuccess(image:UIImage(named: "AppIcon")!, imageString: model1.actorPhoto)
        XCTAssertEqual(viewC.arrImages.count,0)

    }
    
    func testPresenter(){
 
        let presenter = viewC.movieePresenter
        
        presenter?.startFetching()
        
        XCTAssertNotNil(viewC.arrData)
        
        presenter?.startSearchBarFetching(SearchBarText: "Jason")
        XCTAssertNotNil(viewC.arrData)

    }

    func testEntity(){

        let model = jsonModel(json: JSON(dictionaryLiteral: ("name", "name1"),("popularity","25.5"),("profile_path","TABNG8Sw4EVN3xodn2JBdEmBqv.jpgu")))
        
        XCTAssertEqual(model.actorName, "name1")
        XCTAssertEqual(model.actorPopularity, 25.5)
        XCTAssertEqual(model.actorPhoto, "TABNG8Sw4EVN3xodn2JBdEmBqv.jpgu")

        
    }
    func testProtocols(){
        
    }

}
