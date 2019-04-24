//
//  AddItemViewController.swift
//  Checklist
//
//  Created by Hai Vu on 4/23/19.
//  Copyright © 2019 Hai Vu. All rights reserved.
//

import UIKit

class AddItemViewController: UITableViewController, UITextFieldDelegate {
	
	@IBOutlet weak var titleTextField: UITextField!
	@IBOutlet weak var doneButton: UIBarButtonItem!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		titleTextField.delegate = self
		navigationItem.largeTitleDisplayMode = .never
	}
	
	//MARK:- Life Cycles
	override func viewWillAppear(_ animated: Bool) {
		super.viewDidAppear(true)
		titleTextField.becomeFirstResponder()
		doneButton.isEnabled = false
	}
	
	//MARK:- IB Action
	@IBAction func cancel() {
		navigationController?.popViewController(animated: true)
	}
	
	@IBAction func done() {
		print(titleTextField.text!)
		navigationController?.popViewController(animated: true)
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
