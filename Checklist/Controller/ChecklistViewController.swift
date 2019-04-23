//
//  ViewController.swift
//  Checklist
//
//  Created by Hai Vu on 4/21/19.
//  Copyright © 2019 Hai Vu. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {
	
	var checklistItem = Array<ChecklistItem>()
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationController?.navigationBar.prefersLargeTitles = true
		checklistItem.append(ChecklistItem(text: "Walk the dog", checked: true))
		checklistItem.append(ChecklistItem(text: "Brush My Teeth", checked: true))
		checklistItem.append(ChecklistItem(text: "Lear iOS Development", checked: true))
		checklistItem.append(ChecklistItem(text: "Soccer Practice", checked: false))
		checklistItem.append(ChecklistItem(text: "Eat ice Cream", checked: false))
	}
	
	//MARK:- ACTIONS
	@IBAction func addItem() {
		let newRowIndex = checklistItem.count
		checklistItem.append(ChecklistItem(text: "new item", checked: false))
		let indexPath = IndexPath(row: newRowIndex, section: 0)
		let indexPaths = [indexPath]
		//MARK:- I’ve inserted a row at this index, please update yourself
		//Hey table, my data model has a bunch of new items added to it.
		tableView.insertRows(at: indexPaths, with: .automatic)
	}
	
	func bindingData(for cell: ChecklistTableViewCell, with item: ChecklistItem) {
		cell.titleLabel.text = item.text
		if item.checked {
			cell.accessoryType = .checkmark
		} else {
			cell.accessoryType = .none
		}
	}
	
	// MARK:- table view datasource
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return checklistItem.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		//MARK:- Using tags is a handy trick to get a reference to a UI element without having to make an @IBOutlet variable for it.
		let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath) as! ChecklistTableViewCell
		let item = checklistItem[indexPath.row]
		bindingData(for: cell, with: item)
		return cell
	}
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let cell = tableView.cellForRow(at: indexPath) {
			let item = checklistItem[indexPath.row]
			//MARK:- A good object-oriented design principle is that you should let objects change their own state as much as possible
			item.toggle()
			bindingData(for: cell as! ChecklistTableViewCell, with: item)
		}
		tableView.deselectRow(at: indexPath, animated: true)
	}
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		//remove from datasource
		checklistItem.remove(at: indexPath.row)
		//tell the table view about this changes
		tableView.deleteRows(at: [indexPath], with: .automatic)
	}
}

