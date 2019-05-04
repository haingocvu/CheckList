//
//  ViewController.swift
//  Checklist
//
//  Created by Hai Vu on 4/21/19.
//  Copyright © 2019 Hai Vu. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController, itemDetailViewControllerDelegate {
	
	var checklist: Checklist!
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.largeTitleDisplayMode = .never
		tableView.tableFooterView = UIView()
		title = checklist.name
		//dont know why init checklist item with value of false of checked will cause error when editing
	}
	
	func bindingData(for cell: ChecklistTableViewCell, with item: ChecklistItem) {
		//cell.titleLabel.text = item.text
		cell.titleLabel.text = "\(item.text) \(item.itemID)"
		if item.isChecked {
			cell.statusLabel.text = "√"
		} else {
			//i dont know when i set text to "", then prepare for segue work fail
			cell.statusLabel.text = " "
		}
	}
	
	// MARK:- table view datasource
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return checklist.items.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		//MARK:- Using tags is a handy trick to get a reference to a UI element without having to make an @IBOutlet variable for it.
		let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath) as! ChecklistTableViewCell
		let item = checklist.items[indexPath.row]
		bindingData(for: cell, with: item)
		return cell
	}
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let cell = tableView.cellForRow(at: indexPath) {
			let item = checklist.items[indexPath.row]
			//MARK:- A good object-oriented design principle is that you should let objects change their own state as much as possible
			item.toggle()
			bindingData(for: cell as! ChecklistTableViewCell, with: item)
		}
		tableView.deselectRow(at: indexPath, animated: true)
	}
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		//remove from datasource
		checklist.items.remove(at: indexPath.row)
		//tell the table view about this changes
		tableView.deleteRows(at: [indexPath], with: .automatic)
	}
	//MARK:- AddItemViewController Delegate
	func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController) {
		navigationController?.popViewController(animated: true)
	}
	func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAddingItem item: ChecklistItem) {
		let newRowIndex = checklist.items.count
		//insert into model
		checklist.items.append(item)
		//tell table view that i have insert a new row
		let indexPath = IndexPath(row: newRowIndex, section: 0)
		tableView.insertRows(at: [indexPath], with: .automatic)
		navigationController?.popViewController(animated: true)
	}
	func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditing item: ChecklistItem) {
		//item has updated to model already because it is a reference type
		//we just need update the cell associated to it
		if let index = checklist.items.firstIndex(of: item) {
			let indexPath = IndexPath(row: index, section: 0)
			let cell = tableView.cellForRow(at: indexPath) as! ChecklistTableViewCell
			bindingData(for: cell, with: item)
		}
		navigationController?.popViewController(animated: true)
	}
	//MARK:- Override the segue's prepare method
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "AddItem" {
			let controller = segue.destination as! ItemDetailViewController
			controller.delegate = self
		} else if segue.identifier == "EditItem" {
			let controller = segue.destination as! ItemDetailViewController
			controller.delegate = self
			if let indexPath = tableView.indexPath(for: sender as! ChecklistTableViewCell) {
				controller.itemToEdit = checklist.items[indexPath.row]
			}
		}
	}
}

