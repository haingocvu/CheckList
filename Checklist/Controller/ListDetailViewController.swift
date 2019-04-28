//
//  ListDetailViewController.swift
//  Checklist
//
//  Created by Hai Vu on 4/28/19.
//  Copyright © 2019 Hai Vu. All rights reserved.
//

import UIKit

class ListDetailViewController: UITableViewController, UITextFieldDelegate {
	
	//MARK:- Outlets
	@IBOutlet var textField: UITextField!
	@IBOutlet var doneBarButton: UIBarButtonItem!
	
	//MARK:- Actions
	@IBAction func cancel() {
		delegate?.listDetailViewControllerDidCancel(self)
	}
	
	@IBAction func done() {
		if let checklist = checklistToEdit {
			checklist.name = textField.text!
			delegate?.listDetailViewController(self, didfinishEditing: checklist)
		} else {
			let checklist = Checklist(name: textField.text!)
			delegate?.listDetailViewController(self, didFinishAdding: checklist)
		}
	}
	
	//MARK:- Properties
	var delegate: ListDetailViewControllerDelegate?
	var checklistToEdit: Checklist?
	
	//MARK:- life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.largeTitleDisplayMode = .never
		if let checklist = checklistToEdit {
			title = checklist.name
			textField.text = checklist.name
			doneBarButton.isEnabled = true
		} else {
			doneBarButton.isEnabled = false
		}
		textField.delegate = self
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		textField.becomeFirstResponder()
	}
	
	//MARK- table view delegate
	override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
		return nil
	}
	
	//MARK:- text field delegate
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		let oldText = textField.text!
		let stringRange = Range(range, in: oldText)!
		let newText = oldText.replacingCharacters(in: stringRange, with: string)
		doneBarButton.isEnabled = !newText.isEmpty
		return true
	}
	
	//when click "x" button on the textfield
	func textFieldShouldClear(_ textField: UITextField) -> Bool {
		doneBarButton.isEnabled = false
		return true
	}
}
