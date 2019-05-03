//
//  AllListViewController.swift
//  Checklist
//
//  Created by Hai Vu on 4/27/19.
//  Copyright © 2019 Hai Vu. All rights reserved.
//

import UIKit

class AllListViewController: UITableViewController, ListDetailViewControllerDelegate, UINavigationControllerDelegate {
	
	let cellIdentifier = "ChecklistCell"
	var dataModel: DataModel!
	
	//MARK:- Life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		//large title
		navigationController?.navigationBar.prefersLargeTitles = true
		//prevent extra empty row
		tableView.tableFooterView = UIView()
	}
	
	//ta hook việc gán delegate cho navigationcontroller vào viewDidload vì
	//khi lần đầu tiên được load thì tránh việc nó sẽ gọi cái willShow viewController của navagationDelegate
	//khi khó thì code sẽ chạy sai logic. vì lúc nào nó cũng set cái ChecklistIndex = -1
	//và sẽ không thể nào performSegue showChecklist được
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidLoad()
		navigationController?.delegate = self
		let index = dataModel.indexOfSelectedChecklist
		if index >= 0 && index < dataModel.allList.count {
			let item = dataModel.allList[index]
			performSegue(withIdentifier: "ShowChecklist", sender: item)
		}
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewDidAppear(true)
		tableView.reloadData()
	}
	
	// MARK: - Table view data source
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		return dataModel.allList.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = makeCell(for: tableView, with: cellIdentifier)
		let checklist = dataModel.allList[indexPath.row]
		cell.textLabel?.text = checklist.name
		cell.imageView?.image = UIImage(named: checklist.iconName)
		if checklist.items.count == 0 {
			cell.detailTextLabel?.text = "No items"
		} else {
			let count = checklist.countUncheckedItem()
			cell.detailTextLabel?.text = count == 0 ? "All done" : "\(count) Remaining"
		}
		cell.accessoryType = .detailDisclosureButton
		return cell
	}
	
	//MARK:- Table view delegate
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		dataModel.indexOfSelectedChecklist = indexPath.row
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
		dataModel.sortChecklists()
		tableView.reloadData()
		navigationController?.popViewController(animated: true)
	}
	
	func listDetailViewController(_ controller: ListDetailViewController, didfinishEditing checklist: Checklist) {
		dataModel.sortChecklists()
		tableView.reloadData()
		navigationController?.popViewController(animated: true)
	}
	
	//MARK:- UINavigationController Delegates
	func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
		//was the back button tapped?
		if viewController === self {
			dataModel.indexOfSelectedChecklist = -1
		}
	}
}
