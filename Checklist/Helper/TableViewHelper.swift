//
//  TableViewHelper.swift
//  Checklist
//
//  Created by Hai Vu on 4/28/19.
//  Copyright © 2019 Hai Vu. All rights reserved.
//

import UIKit

extension UIViewController {
	func makeCell(for tableView: UITableView, with identifier: String) -> UITableViewCell {
		let cell: UITableViewCell!
		if let c = tableView.dequeueReusableCell(withIdentifier: identifier) {
			cell = c
		} else {
			cell = UITableViewCell(style: .subtitle, reuseIdentifier: identifier)
		}
		return cell
	}
}
