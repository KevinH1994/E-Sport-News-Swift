//
//  HomeTableViewCell.swift
//  E-Sport-News
//
//  Created by Kevin Hering on 18.10.22.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var discription: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var bild: UIImageView!
    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   
}
