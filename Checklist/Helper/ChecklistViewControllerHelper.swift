//
//  ChecklistViewControllerHelper.swift
//  Checklist
//
//  Created by Hai Vu on 4/27/19.
//  Copyright © 2019 Hai Vu. All rights reserved.
//

import Foundation
extension ChecklistViewController {
	func documentsDirectory() -> URL {
		let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
		return paths[0]
	}
	func detailFilePath() -> URL {
		return documentsDirectory().appendingPathComponent("Checklist.plist")
	}
	func saveChecklistItems() {
		let encoder = PropertyListEncoder()
		do {
			let data = try encoder.encode(checklistItem)
			try data.write(to: detailFilePath(), options: .atomic)
		} catch {
			print("error encoding items checklist \(error.localizedDescription)")
		}
	}
	func loadChecklistItems() {
		let path = detailFilePath()
		if let data = try? Data(contentsOf: path) {
			let decoder = PropertyListDecoder()
			do {
				checklistItem = try decoder.decode([ChecklistItem].self, from: data)
			} catch {
				print("error decoding item array: \(error.localizedDescription)")
			}
		}
	}
}
