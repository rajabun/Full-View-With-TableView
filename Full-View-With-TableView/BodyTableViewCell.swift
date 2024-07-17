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
    internal var shareMenuCallback: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        addDoneButtonOnKeyboard()
        commentTextView.delegate = self
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
        shareMenuCallback?()
    }
    
    @IBAction func bookmarkButtonTapped(_ sender: UIButton) {
    }
    
}

extension BodyTableViewCell: UITextViewDelegate {
    internal func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }

    private func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        commentTextView.inputAccessoryView = doneToolbar
    }

    @objc private func doneButtonAction() {
        commentTextView.resignFirstResponder()
    }
}
