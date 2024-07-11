//
//  BodyTableViewCell.swift
//  Full-View-With-TableView
//
//  Created by Muhammad Rajab on 10-07-2024.
//

import UIKit

class BodyTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameText: UILabel!
    @IBOutlet weak var checkmark: UIImageView!
    @IBOutlet weak var locationText: UILabel!
    @IBOutlet weak var dotMenuButton: UIButton!
    @IBOutlet weak var contentImage: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var bookmarkButton: UIButton!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var likeCountText: UILabel!

    internal var dotMenuCallback: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func dotMenuTapped(_ sender: UIButton) {
        dotMenuCallback?()
    }
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        likeButton.isEnabled.toggle()
        if likeButton.isEnabled {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    @IBAction func commentButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func shareButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func bookmarkButtonTapped(_ sender: UIButton) {
    }
    
}
