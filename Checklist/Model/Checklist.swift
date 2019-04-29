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
	var items: Array<ChecklistItem>
	
	init(name: String, items: [ChecklistItem] = []) {
		self.name = name
		self.items = items
		super.init()
	}
}
