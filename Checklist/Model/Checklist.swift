//
//  Checklist.swift
//  Checklist
//
//  Created by Hai Vu on 4/28/19.
//  Copyright © 2019 Hai Vu. All rights reserved.
//

import UIKit

class Checklist: NSObject, Codable {
	var name: String
	var iconName: String
	var items: Array<ChecklistItem>
	
	init(name: String, iconName: String = "No Icon", items: [ChecklistItem] = []) {
		self.name = name
		self.iconName = iconName
		self.items = items
		super.init()
	}
	
	func countUncheckedItem() -> Int {
		return items.reduce(0) {
			count, item in
			count + (item.isChecked ? 0 : 1)
		}
	}
}
