//
//  UITableViewCell+Extension.swift
//  AirsideLab
//
//  Created by aarthur on 8/5/19.
//  Copyright © 2019 Gigabit LLC. All rights reserved.
//

import UIKit

extension UITableViewCell {
    /// Fills the image view with the git hub avatar
    /// - Parameters:
    ///   - url: Github user's avatar url
    ///   - tableView: Tableview that this cell belongs to
    ///   - indexPath: Indexpath where this cell is located in the table
    func fillImage(url: URL?, in tableView: UITableView, at indexPath: IndexPath) {
        guard let url = url else { return }
        URLImage.fetchImageURL(url) { [weak self] image, _, _ in
            if let image = image {
                self?.imageView?.image = image
                tableView.reloadRows(at: [indexPath], with: .none)
            }
        }
    }
}
