//
//  ChecklistItem.swift
//  Checklist
//
//  Created by Hai Vu on 4/22/19.
//  Copyright © 2019 Hai Vu. All rights reserved.
//

class ChecklistItem: Equatable {
	static func == (lhs: ChecklistItem, rhs: ChecklistItem) -> Bool {
		if lhs.text == rhs.text { return true }
		return false
	}
	var text: String!
	var checked: Bool!
	init(text: String, checked: Bool) {
		self.text = text
		self.checked = checked
	}
}
