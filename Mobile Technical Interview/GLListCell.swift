//
//  GLListCell.swift
//  Mobile Technical Interview
//
//  Created by Javier Cristóbal González Ovalle on 11/12/18.
//  Copyright © 2018 GlobalLogic. All rights reserved.
//

import UIKit

class GLListCell: UITableViewCell {

    static let glReuseIdentifier = "GLListCell"
    
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var glTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
