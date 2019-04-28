//
//  TableViewHelper.swift
//  Checklist
//
//  Created by Hai Vu on 4/28/19.
//  Copyright © 2019 Hai Vu. All rights reserved.
//

import UIKit

extension UIViewController {
	func makeCell(for tableView: UITableView, with identifier: String, at indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
		return cell
	}
}
