//
//  PlaceCell.swift
//  Burlington Tour
//
//  Created by Matthew Fortier on 3/20/18.
//  Copyright © 2018 Matthew Fortier. All rights reserved.
//

import UIKit

class PlaceCell: UITableViewCell {

    @IBOutlet weak var CellImage: UIImageView!
    @IBOutlet weak var CellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //CellLabel.adjustsFontForContentSizeCategory = true
        CellLabel.adjustsFontSizeToFitWidth = false
        CellLabel.lineBreakMode = NSLineBreakMode.byTruncatingTail
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
