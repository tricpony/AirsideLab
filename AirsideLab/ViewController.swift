//
//  ViewController.swift
//  AirsideLab
//
//  Created by aarthur on 8/5/19.
//  Copyright © 2019 Gigabit LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var outputLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputTextField.text = "P<USARICHARDS<STEVENS<JR<<GEORGE<MICHAEL<<<<"
    }

    @IBAction func parseTapped(_ sender: Any) {
        guard let input = inputTextField.text else { return }
        outputLabel.text = parseMRZ(input)
    }

    func parseMRZ(_ mrz: String) -> String? {
        let index = mrz.index(mrz.startIndex, offsetBy: 5)
        let subMrz = mrz.substring(from: index)
        let lastFirstNames = subMrz.components(separatedBy: "<<")
        guard var lastname = lastFirstNames.first else { return nil }
        var firstname = lastFirstNames[1]

        firstname = firstname.replacingOccurrences(of: "<", with: " ")
        lastname = lastname.replacingOccurrences(of: "<", with: " ")

        return firstname + " " + lastname
    }
}

