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

    @IBOutlet weak var generalFrameView: UITableView!
    var menuArray: [Menu] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        menuArray = [.body, .body]
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func setTableView() {
        self.generalFrameView.delegate = self
        self.generalFrameView.dataSource = self
        let bodyView = UINib(nibName: "BodyTableViewCell", bundle: nil)
        generalFrameView.register(bodyView, forCellReuseIdentifier: "BodyCell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch menuArray[indexPath.row] {
        case .header:
            return UITableViewCell()
        case .body:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BodyCell", for: indexPath) as? BodyTableViewCell
            cell?.dotMenuCallback = {
                cell?.dotMenuButton.menu = self.setupPopupMenu()
                cell?.dotMenuButton.showsMenuAsPrimaryAction = true
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
}
