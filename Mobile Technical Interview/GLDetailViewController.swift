//
//  GLDetailViewController.swift
//  Mobile Technical Interview
//
//  Created by Javier Cristóbal González Ovalle on 11/12/18.
//  Copyright © 2018 GlobalLogic. All rights reserved.
//

import UIKit

class GLDetailViewController: UIViewController {

    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var detailsImageView: UIImageView!
    
    var detailsElement : GLListElement? = nil {
        didSet {
            print("details element \(String(describing:detailsElement))")
        }}
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        self.descriptionTextView.textColor = UIColor.darkText
        updateDetailsWithInformation()
    }
    
    func updateDetailsWithInformation() {
        if let information = detailsElement {
            self.title = information.title
            self.descriptionTextView.text = information.description
            if let imgURL = URL(string: information.imageURLString) {
                GLMainTableViewController.loadRemoteImage(fromURL: imgURL, intoView: self.detailsImageView)
            }
        }
    }
}
