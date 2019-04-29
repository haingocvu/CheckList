//
//  DataModel.swift
//  Checklist
//
//  Created by Hai Vu on 4/29/19.
//  Copyright © 2019 Hai Vu. All rights reserved.
//

import Foundation

class DataModel {
	var allList = [Checklist]()
	init() {
		loadChecklists()
	}
	func documentsDirectory() -> URL {
		let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
		return paths[0]
	}
	func detailFilePath() -> URL {
		return documentsDirectory().appendingPathComponent("Checklist.plist")
	}
	func saveChecklists() {
		let encoder = PropertyListEncoder()
		do {
			let data = try encoder.encode(allList)
			try data.write(to: detailFilePath(), options: .atomic)
		} catch {
			print("error encoding list checklist \(error.localizedDescription)")
		}
	}
	func loadChecklists() {
		let path = detailFilePath()
		if let data = try? Data(contentsOf: path) {
			let decoder = PropertyListDecoder()
			do {
				allList = try decoder.decode([Checklist].self, from: data)
			} catch {
				print("error decoding list array: \(error.localizedDescription)")
			}
		}
	}
}
