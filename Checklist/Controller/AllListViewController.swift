//
//  AllListViewController.swift
//  Checklist
//
//  Created by Hai Vu on 4/27/19.
//  Copyright © 2019 Hai Vu. All rights reserved.
//

import UIKit

class AllListViewController: UITableViewController, ListDetailViewControllerDelegate {
	
	let cellIdentifier = "ChecklistCell"
	var dataModel: DataModel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		//large title
		navigationController?.navigationBar.prefersLargeTitles = true
		//prevent extra empty row
		tableView.tableFooterView = UIView()
		
		//register cell with identify
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
	}
	
	// MARK: - Table view data source
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		return dataModel.allList.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = makeCell(for: tableView, with: cellIdentifier, at: indexPath)
		let checklist = dataModel.allList[indexPath.row]
		cell.textLabel?.text = checklist.name
		cell.accessoryType = .detailDisclosureButton
		return cell
	}
	
	//MARK:- Table view delegate
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let checklist = dataModel.allList[indexPath.row]
		performSegue(withIdentifier: "ShowChecklist", sender: checklist)
	}
	
	override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
		let checklist = dataModel.allList[indexPath.row]
		let controller = storyboard?.instantiateViewController(withIdentifier: "ListDetailViewController") as! ListDetailViewController
		controller.checklistToEdit = checklist
		controller.delegate = self
		navigationController?.pushViewController(controller, animated: true)
	}
	
	//MARK:- Override to support editing the table view.
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			// Delete the row from the data source
			dataModel.allList.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .automatic)
		} else if editingStyle == .insert {
			// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
		}
	}
	
	//MARK:- repare for segue xảy ra sau khi controller được init
	//nhưng trước khi viewdidload. nên thường được dùng để set data cho destination controller
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		switch segue.identifier! {
		case "ShowChecklist":
			let controller = segue.destination as! ChecklistViewController
			controller.checklist = sender as? Checklist
		case "AddChecklist":
			let controller = segue.destination as! ListDetailViewController
			controller.delegate = self
		default:
			break
		}
	}
	
	//MARK:- ListDetailViewController Delegate
	func listDetailViewControllerDidCancel(_ controller: ListDetailViewController) {
		navigationController?.popViewController(animated: true)
	}
	
	func listDetailViewController(_ controller: ListDetailViewController, didFinishAdding checklist: Checklist) {
		//append to data model
		dataModel.allList.append(checklist)
		//tell the table view about this change
		let indexPath = IndexPath(row: dataModel.allList.count - 1, section: 0)
		tableView.insertRows(at: [indexPath], with: .automatic)
		navigationController?.popViewController(animated: true)
	}
	
	func listDetailViewController(_ controller: ListDetailViewController, didfinishEditing checklist: Checklist) {
		if let index = dataModel.allList.lastIndex(of: checklist) {
			let indexPath = IndexPath(row: index, section: 0)
			let cell = tableView.cellForRow(at: indexPath)
			cell?.textLabel?.text = checklist.name
		}
		navigationController?.popViewController(animated: true)
	}
}