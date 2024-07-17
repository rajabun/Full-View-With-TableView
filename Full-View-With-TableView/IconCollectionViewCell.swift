//
//  IconCollectionViewCell.swift
//  Full-View-With-TableView
//
//  Created by Muhammad Rajab on 17-07-2024.
//

import UIKit

class IconCollectionViewCell: UICollectionViewCell {

    internal var houseSelectedCallback: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func houseTapped(_ sender: UIButton) {
        houseSelectedCallback?()
    }
}
