//
//  HeaderTableViewCell.swift
//  Full-View-With-TableView
//
//  Created by Muhammad Rajab on 17-07-2024.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var iconCollectionView: UICollectionView!
    internal var iconSelectedCallback: ((String) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        setCollectionView()
    }
}

extension HeaderTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    private func setCollectionView() {
        self.iconCollectionView.delegate = self
        self.iconCollectionView.dataSource = self
        let iconView = UINib(nibName: "IconCollectionViewCell", bundle: nil)
        iconCollectionView.register(iconView, forCellWithReuseIdentifier: "IconView")
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = iconCollectionView.dequeueReusableCell(withReuseIdentifier: "IconView", for: indexPath) as? IconCollectionViewCell
        cell?.houseSelectedCallback = {
            self.iconSelectedCallback?("\(indexPath.item)")
        }
        return cell ?? UICollectionViewCell()
    }
}
