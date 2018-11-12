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
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        self.model.dummyData()
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier:GLListCell.glReuseIdentifier, for: indexPath) as? GLListCell else {
            fatalError("The dequeued cell is not an instance of GLListCell.")
        }

        let listElement = model.getElementForList(atIndex: indexPath.row)
        cell.glTitleLabel.text = listElement.title
        //cell.thumbImageView.image = listElement.remoteImage()
        if let imgURL = URL(string: listElement.imageURLString) {
            GLMainTableViewController.loadRemoteImage(fromURL: imgURL, intoView: cell.thumbImageView)
        }
        return cell
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
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
    
    class func loadRemoteImage(fromURL imgURL : URL, intoView imageView : UIImageView) {
        
        let request = URLRequest(url: imgURL)
        let task = URLSession.shared.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
            if error != nil {
                
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
