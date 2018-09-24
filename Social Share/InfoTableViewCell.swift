//
//  InfoTableViewCell.swift
//  Social Share
//
//  Created by Andrew Jones and Sam Jimenez on 12/3/17.
//  Copyright © 2017 SS, Inc. All rights reserved.
//

import UIKit

class InfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tableViewImage: UIImageView!
    @IBOutlet weak var tableViewLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
