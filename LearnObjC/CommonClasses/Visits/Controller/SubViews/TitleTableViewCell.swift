//
//  TitleTableViewCell.swift
//  LearnObjC
//
//  Created by ARIEL DIAZ on 3/12/19.
//  Copyright © 2019 ARIEL DIAZ. All rights reserved.
//

import UIKit

class TitleTableViewCell: UITableViewCell {

    // MARK: Outlets
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var viewDot: UIView!
    
    // MARK: Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(title: String) {
        self.viewDot.makeViewWith(features: [.roundedView(.full, .clear), .bordered(.white, 1)])
        self.lblTitle.text = title
        
    }
    
}
