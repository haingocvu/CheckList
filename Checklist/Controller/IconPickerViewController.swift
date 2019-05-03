//
//  IconPickerViewController.swift
//  Checklist
//
//  Created by Hai Vu on 5/2/19.
//  Copyright © 2019 Hai Vu. All rights reserved.
//

import UIKit
class IconPickerViewController: UITableViewController {
	
	weak var delegate: IconPickerViewControllerDelegate?
	let icons = [ "No Icon", "Appointments", "Birthdays", "Chores", "Drinks", "Folder", "Groceries", "Inbox", "Photos", "Trips" ]
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return icons.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "IconCell", for: indexPath)
		let icon = icons[indexPath.row]
		cell.textLabel?.text = icon
		cell.imageView?.image = UIImage(named: icon)
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let delegate = delegate {
			let iconName = icons[indexPath.row]
			delegate.iconPicker(self, didSelect: iconName)
		}
	}
}
