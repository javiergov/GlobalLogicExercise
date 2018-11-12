//
//  GLRemoteListManager.swift
//  Mobile Technical Interview
//
//  Created by Javier Cristóbal González Ovalle on 11/11/18.
//  Copyright © 2018 GlobalLogic. All rights reserved.
//

import UIKit

struct GLListElement {
    var title : String
    var description : String
    var imageURLString : String
    
    func remoteImage() -> UIImage? {
        return nil
    }
}

class GLRemoteListManager: NSObject {

    var totalElements : [GLListElement] = Array.init() {
        didSet {
        print("new elements \(totalElements)")
        }}
    
    func dummyData(){
        
        let element1 = GLListElement.init(title: "Laptop 1", description: "bla bla", imageURLString: "https://picsum.photos/100/100?image=0")
        let element2 = GLListElement.init(title: "Laptop 2", description: "ble ble", imageURLString: "https://picsum.photos/200/200?image=1")
        let element3 = GLListElement.init(title: "Laptop 3", description: "bli bli", imageURLString: "https://picsum.photos/300/300?image=2")
        
        self.totalElements = [element1, element2, element3]
        
    }
    
    func numberOfListSections() -> Int {
        var sections = 0
        if totalElements.count > 0 {
            sections = 1
        }
        print("sections \(sections)")
        return sections
    }
    
    func amountOfElementsInList() -> Int {
        print("totalElements.count \(totalElements.count)")
        return totalElements.count
    }
    
    func getElementForList(atIndex index : Int) -> GLListElement {
        
        return totalElements[index]
    }
    
}
