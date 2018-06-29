//
//  ListRecipesTableViewCell.swift
//  queComemosHoy
//
//  Created by Gianni on 21/6/18.
//  Copyright © 2018 Gianni. All rights reserved.
//

import UIKit

class ListRecipesTableViewCell: UITableViewCell {

    @IBOutlet weak var photoFood: UIImageView!
    @IBOutlet weak var nameFood: UILabel!
    @IBOutlet weak var caloriesFood: UILabel!
    @IBOutlet weak var timeFood: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
