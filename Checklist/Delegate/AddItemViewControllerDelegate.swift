//
//  AddItemViewControllerDelegate.swift
//  Checklist
//
//  Created by Hai Vu on 4/25/19.
//  Copyright © 2019 Hai Vu. All rights reserved.
//

import UIKit
//MARK:- use Anyobject or class to indicate that the protocol is only for Class
protocol AddItemViewControllerDelegate: AnyObject {
	func addItemViewControllerDidCancel(_ controller: AddItemViewController)
	func addItemViewController(_ controller: AddItemViewController, didFinishAddingItem item: ChecklistItem)
}
