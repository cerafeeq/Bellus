//
//  ProductListCell.swift
//  Bellus
//
//  Created by Rafeeq Ebrahim on 02/12/18.
//  Copyright © 2018 Rafeeq Ebrahim. All rights reserved.
//

import UIKit

class ProductListCell: UITableViewCell {

    
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnBuy: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        btnBuy.layer.cornerRadius = 5.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
