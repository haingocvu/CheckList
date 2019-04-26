//
//  AddItemViewControllerDelegate.swift
//  Checklist
//
//  Created by Hai Vu on 4/25/19.
//  Copyright © 2019 Hai Vu. All rights reserved.
//

import UIKit
//MARK:- use Anyobject or class to indicate that the protocol is only for Class
protocol itemDetailViewControllerDelegate: AnyObject {
	func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController)
	func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAddingItem item: ChecklistItem)
	func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditing item: ChecklistItem)
}
