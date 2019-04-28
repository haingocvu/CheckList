//
//  ListDetailViewControllerDelegate.swift
//  Checklist
//
//  Created by Hai Vu on 4/28/19.
//  Copyright © 2019 Hai Vu. All rights reserved.
//

import UIKit

protocol ListDetailViewControllerDelegate: class {
	func listDetailViewControllerDidCancel(_ controller: ListDetailViewController)
	func listDetailViewController(_ controller: ListDetailViewController, didFinishAdding checklist: Checklist)
	func listDetailViewController(_ controller: ListDetailViewController, didfinishEditing checklist: Checklist)
}
