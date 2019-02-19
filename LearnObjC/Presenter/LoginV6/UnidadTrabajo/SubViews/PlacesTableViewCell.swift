//
//  PlacesTableViewCell.swift
//  LearnObjC
//
//  Created by ARIEL DIAZ on 2/14/19.
//  Copyright © 2019 ARIEL DIAZ. All rights reserved.
//

import UIKit

class PlacesTableViewCell: UITableViewCell {

    // MARK: Outlets
    @IBOutlet weak var lblAchromym: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    
    // MARK: Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.lblAchromym.makeViewWith(features: [.roundedView(.full, .clear)])

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
