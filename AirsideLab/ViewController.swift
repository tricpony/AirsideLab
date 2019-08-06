//
//  ViewController.swift
//  AirsideLab
//
//  Created by aarthur on 8/5/19.
//  Copyright © 2019 Gigabit LLC. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var outputLabel: UILabel!
    @IBOutlet weak var parseCanvas: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomParseButtonConstraint: NSLayoutConstraint!

    var firstname = ""
    var lastname = ""
    var matchingGithubUsers = [User]()

    // must hang on to the var here or else it gets released and the service fails
    var sessionManager: SessionManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        //this will prevent bogus separator lines from displaying in an empty table
        tableView.tableFooterView = UIView()
        parseCanvas.layer.borderWidth = 0.5
        inputTextField.text = "P<USAROGGER<<MICHAEL<<<<<<<<<<<<<<<<<<<<<<<<"
    }

    @IBAction func parseTapped(_ sender: Any) {
        guard let input = inputTextField.text else { return }
        outputLabel.text = parseMRZ(input)
        if let constraint = bottomParseButtonConstraint {
            constraint.isActive = false
        }
        
        // fire service call
        let arg = firstname.trim().urlEncoded + "+" + lastname.trim().urlEncoded
        sessionManager = ServiceManager().startGitHubSearchService(arg: arg) { [weak self] result in
            switch result {
            case .success(let data):
                guard let root = JsonUtility<Root>.parseJSON(data) else { return }
                let fetchedUsers = root.users
                self?.matchingGithubUsers = fetchedUsers
                self?.tableView.reloadData()
            case .failure(let error):
                print("Service Failed: \(String(describing: error))")
            }
        }
    }

    func parseMRZ(_ mrz: String) -> String? {
        let index = mrz.index(mrz.startIndex, offsetBy: 5)
        let subMrz = mrz.suffix(from: index)
        let lastFirstNames = subMrz.components(separatedBy: "<<")
        guard var lastname = lastFirstNames.first else { return nil }
        var firstname = lastFirstNames[1]
        
        firstname = firstname.replacingOccurrences(of: "<", with: " ")
        lastname = lastname.replacingOccurrences(of: "<", with: " ")
        self.firstname = firstname
        self.lastname = lastname

        return firstname + " " + lastname
    }

    // MARK: - Table View
    
    func nextCellForTableView(_ tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: self)) else
        { return UITableViewCell(style: .subtitle, reuseIdentifier: String(describing: self)) }
        cell.detailTextLabel?.isUserInteractionEnabled = true
        cell.selectionStyle = .none
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingGithubUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.nextCellForTableView(tableView, at: indexPath)
        let user = matchingGithubUsers[indexPath.row]
        cell.textLabel?.text = user.displayUsername
        cell.detailTextLabel?.text = user.displayScore
        cell.fillImage(url: user.avatarUrl, in: tableView, at: indexPath)

        return cell
    }
}
