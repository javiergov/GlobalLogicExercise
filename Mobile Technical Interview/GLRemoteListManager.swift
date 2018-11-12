//
//  GLRemoteListManager.swift
//  Mobile Technical Interview
//
//  Created by Javier Cristóbal González Ovalle on 11/11/18.
//  Copyright © 2018 GlobalLogic. All rights reserved.
//

import UIKit

struct GLListElement : Decodable {
    var title : String
    var description : String
    var imageURLString : String
    
    //CodingKeys
    private enum CodingKeys: String, CodingKey {
        case imageURLString = "image"
        case title, description
    }
}

class GLRemoteListManager: NSObject {

    let dataURLString = "https://private-f0eea-mobilegllatam.apiary-mock.com/list"
    
    var totalElements : [GLListElement] = Array.init() {
        didSet {
            print("•• new elements: \(totalElements.count)")
        }}
    
    func dummyData() {
        let element1 = GLListElement.init(title: "Laptop 1", description: "bla bla", imageURLString: "https://picsum.photos/100/100?image=0")
        let element2 = GLListElement.init(title: "Laptop 2", description: "ble ble", imageURLString: "https://picsum.photos/200/200?image=1")
        let element3 = GLListElement.init(title: "Laptop 3", description: "bli bli", imageURLString: "https://picsum.photos/300/300?image=2")
        self.totalElements = [element1, element2, element3]
    }
    
    // MARK: - Table View data source.
    
    func numberOfListSections() -> Int {
        var sections = 0
        if totalElements.count > 0 {
            sections = 1
        }
        return sections
    }
    
    func amountOfElementsInList() -> Int {
        print("•• totalElements.count \(totalElements.count)")
        return totalElements.count
    }
    
    func getElementForList(atIndex index : Int) -> GLListElement {
        
        return totalElements[index]
    }
    
    // MARK: - JSON Data.
    
    func getRemoteJSONData(thenCall closure : @escaping () -> Void) {
        if let url = URL(string: dataURLString) {
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
                if error != nil {
                    print("Error obtaining JSON data.")
                } else {
                    if let jsonData = data {
                        self.parseJSON(data: jsonData)
                        closure()
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(data: Data) {
        do {
            let decoder = JSONDecoder()
            self.totalElements = try decoder.decode([GLListElement].self, from: data)
        } catch let error {
            print("\(error)")
        }
    }
}
