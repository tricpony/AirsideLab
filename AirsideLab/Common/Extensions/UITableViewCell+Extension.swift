//
//  UITableViewCell+Extension.swift
//  AirsideLab
//
//  Created by aarthur on 8/5/19.
//  Copyright © 2019 Gigabit LLC. All rights reserved.
//

import UIKit

extension UITableViewCell {
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
