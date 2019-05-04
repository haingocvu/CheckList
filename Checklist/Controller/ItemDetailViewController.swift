//
//  AddItemViewController.swift
//  Checklist
//
//  Created by Hai Vu on 4/23/19.
//  Copyright © 2019 Hai Vu. All rights reserved.
//

import UIKit

class ItemDetailViewController: UITableViewController, UITextFieldDelegate {
	//MARK:- Variable
	var itemToEdit: ChecklistItem?
	//sử dụng biến cho duedate mà không tạo biến cho shouldremind bởi vì shouldremind có thể dễ dàng đọc được
	//từ control switcher. còn duedate khó đọc được từ label content (string) nên để dễ dàng lưu ra v 
	var dueDate = Date()
	var datepickerVisible = false
	
	//MARK:- define delegate
	weak var delegate: itemDetailViewControllerDelegate?
	
	@IBOutlet weak var titleTextField: UITextField!
	@IBOutlet weak var doneButton: UIBarButtonItem!
	@IBOutlet weak var shouldRemindSwitch: UISwitch!
	@IBOutlet weak var dueDateLabel: UILabel!
	@IBOutlet weak var datePicker: UIDatePicker!
	@IBOutlet weak var datePickerCell: UITableViewCell!
	
	//MARK:- Life Cycles
	override func viewDidLoad() {
		super.viewDidLoad()
		if let itemToEdit = itemToEdit {
			titleTextField.text = itemToEdit.text
			title = "Edit Item"
			doneButton.isEnabled = true
			shouldRemindSwitch.isOn = itemToEdit.shouldRemind
			dueDate = itemToEdit.dueDate
		} else {
			navigationController?.tabBarItem.title = "Add Item"
			doneButton.isEnabled = false
		}
		updateDueDateLabel()
		titleTextField.delegate = self
		navigationItem.largeTitleDisplayMode = .never
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewDidAppear(true)
		titleTextField.becomeFirstResponder()
	}
	
	//MARK:- IB Action
	@IBAction func cancel() {
		delegate?.itemDetailViewControllerDidCancel(self)
	}
	
	@IBAction func done() {
		if let itemToEdit = itemToEdit {
			itemToEdit.text = titleTextField.text!
			itemToEdit.shouldRemind = shouldRemindSwitch.isOn
			itemToEdit.dueDate = dueDate
			delegate?.itemDetailViewController(self, didFinishEditing: itemToEdit)
		} else {
			let item = ChecklistItem(text: titleTextField.text!, checked: false)
			item.shouldRemind = shouldRemindSwitch.isOn
			item.dueDate = dueDate
			delegate?.itemDetailViewController(self, didFinishAddingItem: item)
		}
	}
	
	@IBAction func dateChanged(_ datePicker: UIDatePicker) {
		dueDate = datePicker.date
		updateDueDateLabel()
	}
	
	//MARK:- talbe view data source
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.section == 1 && indexPath.row == 2 {
			return datePickerCell
		}
		return super.tableView(tableView, cellForRowAt: indexPath)
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if section == 1 && datepickerVisible{
			return 3
		}
		return super.tableView(tableView, numberOfRowsInSection: section)
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if indexPath.row == 2 && indexPath.section == 1 {
			return 217
		}
		return super.tableView(tableView, heightForRowAt: indexPath)
	}
	
	//MARK:- table view delegate
	override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
		if indexPath.section == 1 && indexPath.row == 1 {
			return indexPath
		}
		return nil
	}
	
	override func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
		var newIndexPath = indexPath
		if indexPath.section == 1 && indexPath.row == 2 {
			newIndexPath = IndexPath(row: 0, section: indexPath.section)
		}
		return super.tableView(tableView, indentationLevelForRowAt: newIndexPath)
	}
	
	//MARK:- Text field delegate
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		let oldText = titleTextField.text!
		let stringRange = Range(range, in: oldText)!
		let newText = oldText.replacingCharacters(in: stringRange, with: string)
		doneButton.isEnabled = !newText.isEmpty
		return true
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		titleTextField.resignFirstResponder()
		if indexPath.section == 1 && indexPath.row == 1 {
			if datepickerVisible {
				hideDatePicker()
			} else {
				showDatePicker()
			}
		}
	}
	
	func textFieldShouldClear(_ textField: UITextField) -> Bool {
		doneButton.isEnabled = false
		return true
	}
	
	func textFieldDidBeginEditing(_ textField: UITextField) {
		hideDatePicker()
	}
	
	func updateDueDateLabel() {
		let dateFormater = DateFormatter()
		dateFormater.dateStyle = .medium
		dateFormater.timeStyle = .short
		dueDateLabel.text = dateFormater.string(from: dueDate)
	}
	
	func showDatePicker() {
		datepickerVisible = true
		let indexPathDatePicker = IndexPath(row: 2, section: 1)
		tableView.insertRows(at: [indexPathDatePicker], with: .fade)
		datePicker.setDate(dueDate, animated: true)
		dueDateLabel.textColor = dueDateLabel.tintColor
	}
	
	func hideDatePicker() {
		if datepickerVisible {
			datepickerVisible = false
			let indexPath = IndexPath(row: 2, section: 1)
			tableView.deleteRows(at: [indexPath], with: .fade)
			dueDateLabel.textColor = .black
		}
	}
}
