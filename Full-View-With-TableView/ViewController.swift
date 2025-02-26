//
//  ViewController.swift
//  Full-View-With-TableView
//
//  Created by Muhammad Rajab on 08-07-2024.
//

import UIKit

enum Menu {
    case header
    case body
}

class ViewController: UIViewController {

    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var generalFrameView: UITableView!
    var menuArray: [Menu] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        menuArray = [.header, .body]
        addGestureForDismissKeyboard()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func setTableView() {
        self.generalFrameView.delegate = self
        self.generalFrameView.dataSource = self
        let headerView = UINib(nibName: "HeaderTableViewCell", bundle: nil)
        generalFrameView.register(headerView, forCellReuseIdentifier: "HeaderCell")
        let bodyView = UINib(nibName: "BodyTableViewCell", bundle: nil)
        generalFrameView.register(bodyView, forCellReuseIdentifier: "BodyCell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch menuArray[indexPath.row] {
        case .header:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as? HeaderTableViewCell
            cell?.iconSelectedCallback = { iconIndex in
                self.showAlertUserIconTapped(selectedIndex: iconIndex)
            }
            return cell ?? UITableViewCell()
        case .body:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BodyCell", for: indexPath) as? BodyTableViewCell
            cell?.dotMenuCallback = {
                cell?.dotMenuButton.menu = self.setupPopupMenu()
                cell?.dotMenuButton.showsMenuAsPrimaryAction = true
            }
            cell?.shareMenuCallback = {
                self.overlayView.isHidden = false
                let newViewController = BottomSheetViewController()
                newViewController.modalPresentationStyle = .overFullScreen
                newViewController.overlayViewCallback = {
                    self.overlayView.isHidden = true
                }
                self.navigationController?.present(newViewController, animated: true)
            }
            return cell ?? UITableViewCell()
        }
    }
}

extension ViewController {
    func setupPopupMenu() -> UIMenu {
        let usersItem = UIAction(title: "Users", image: UIImage(systemName: "person.fill")) { (action) in
            print("Users action was tapped")
        }
        let addUserItem = UIAction(title: "Add User", image: UIImage(systemName: "person.badge.plus")) { (action) in
            print("Add User action was tapped")
        }
        let removeUserItem = UIAction(title: "Remove User", image: UIImage(systemName: "person.fill.xmark.rtl")) { (action) in
            print("Remove User action was tapped")
        }
        let menu = UIMenu(title: "My Menu", options: .displayInline, children: [usersItem , addUserItem , removeUserItem])
        return menu
    }

    private func addGestureForDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
    }

    @objc internal func dismissKeyboard(gestureRecognizer: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    private func showAlertUserIconTapped(selectedIndex: String) {
        // create the alert
        let alert = UIAlertController(title: "Icon \(selectedIndex) Selected", message: "This is my message.", preferredStyle: UIAlertController.Style.alert)

        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
}
