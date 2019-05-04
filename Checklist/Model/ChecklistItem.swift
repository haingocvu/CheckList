//
//  ChecklistItem.swift
//  Checklist
//
//  Created by Hai Vu on 4/22/19.
//  Copyright © 2019 Hai Vu. All rights reserved.
//
import Foundation

//MARK:- In our case, all of the properties of ChecklistItem are standard Swift types,
//and Swift already knows how to encode/decode those types
class ChecklistItem: NSObject, Codable {
	var text: String
	var isChecked: Bool
	var dueDate = Date()
	var shouldRemind = false
	var itemID = -1
	init(text: String, checked: Bool = true) {
		self.text = text
		self.isChecked = checked
		super.init()
		self.itemID = DataModel.nextChecklistItemID()
	}
}
