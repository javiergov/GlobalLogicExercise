//
//  GLMainTableViewController.swift
//  Mobile Technical Interview
//
//  Created by Javier Cristóbal González Ovalle on 11/11/18.
//  Copyright © 2018 GlobalLogic. All rights reserved.
//

import UIKit

class GLMainTableViewController: UITableViewController {
    
    let model = GLRemoteListManager.init()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "GlobalLogic Mobile Interview"
        self.view.backgroundColor = UIColor.groupTableViewBackground
        refreshDataFromModel()
    }
    
    func refreshDataFromModel() {
        self.model.getRemoteJSONData {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return model.numberOfListSections()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return model.amountOfElementsInList()
    }

    @IBAction func updateBarButtonAction(_ sender: UIBarButtonItem) {
        
        print("here update the data")
        refreshDataFromModel()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier:GLListCell.glReuseIdentifier, for: indexPath) as? GLListCell else {
            fatalError("The dequeued cell is not an instance of GLListCell.")
        }

        let listElement = model.getElementForList(atIndex: indexPath.row)
        cell.glTitleLabel.text = listElement.title
        if let imgURL = URL(string: listElement.imageURLString) {
            GLMainTableViewController.loadRemoteImage(fromURL: imgURL, intoView: cell.thumbImageView)
        }
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var elementForRow : GLListElement? = nil

        if let glCell = sender as? GLListCell {
            if let indexPath = self.tableView.indexPath(for: glCell) {
                print("glcell indexpath row \(indexPath.row)")
                elementForRow = model.getElementForList(atIndex: indexPath.row)
            }
        }
        
        if let detailsVC = segue.destination as? GLDetailViewController, let element = elementForRow {
            detailsVC.detailsElement = element
        }
    }
    
    // MARK: - Utility methods
    class func loadRemoteImage(fromURL imgURL : URL, intoView imageView : UIImageView) {
        let request = URLRequest(url: imgURL)
        let task = URLSession.shared.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
            if error != nil {
                print("Error downloading image.")
            } else {
                if let imgData = data {
                    DispatchQueue.main.async {
                        imageView.image = UIImage(data: imgData)
                    }
                }
            }
        }
        task.resume()
    }

}
