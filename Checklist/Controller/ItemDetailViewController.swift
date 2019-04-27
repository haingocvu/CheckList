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
	
	//MARK:- define delegate
	weak var delegate: itemDetailViewControllerDelegate?
	
	@IBOutlet weak var titleTextField: UITextField!
	@IBOutlet weak var doneButton: UIBarButtonItem!
	
	//MARK:- Life Cycles
	override func viewDidLoad() {
		super.viewDidLoad()
		if let itemToEdit = itemToEdit {
			titleTextField.text = itemToEdit.text
			title = "Edit Item"
			doneButton.isEnabled = true
		} else {
			navigationController?.tabBarItem.title = "Add Item"
			doneButton.isEnabled = false
		}
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
			delegate?.itemDetailViewController(self, didFinishEditing: itemToEdit)
		} else {
			let item = ChecklistItem(text: titleTextField.text!, checked: false)
			delegate?.itemDetailViewController(self, didFinishAddingItem: item)
		}
	}
	
	//MARK:- table view delegate
	override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
		return nil
	}
	//MARK:- Text field delegate
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		let oldText = titleTextField.text!
		let stringRange = Range(range, in: oldText)!
		let newText = oldText.replacingCharacters(in: stringRange, with: string)
		doneButton.isEnabled = !newText.isEmpty
		return true
	}
	
	func textFieldShouldClear(_ textField: UITextField) -> Bool {
		doneButton.isEnabled = false
		return true
	}
}
