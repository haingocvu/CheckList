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
	var indexOfSelectedChecklist: Int {
		get {
			let index = UserDefaults.standard.integer(forKey: "ChecklistIndex")
			return index
		}
		set {
			UserDefaults.standard.set(newValue, forKey: "ChecklistIndex")
		}
	}
	init() {
		loadChecklists()
		registerDefaults()
		handleFirstTime()
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
				sortChecklists()
			} catch {
				print("error decoding list array: \(error.localizedDescription)")
			}
		}
	}
	//UserDefaults will use the values from this dictionary if you ask it for a key and it cannot find a value for that key.
	func registerDefaults() {
		let dictionary = ["ChecklistIndex" : -1, "FirstTime" : true] as [String : Any]
		UserDefaults.standard.register(defaults: dictionary)
	}
	
	func handleFirstTime() {
		let userDefault = UserDefaults.standard
		let firstTime = userDefault.bool(forKey: "FirstTime")
		if firstTime {
			let checkList = Checklist(name: "List")
			allList.append(checkList)
			indexOfSelectedChecklist = 0
			userDefault.set(false, forKey: "FirstTime")
			userDefault.synchronize()
		}
	}
	
	func sortChecklists() {
		allList.sort() { ckl1, ckl2 in
			ckl1.name.localizedCompare(ckl2.name) == .orderedAscending
		}
	}
	
	class func nextChecklistItemID() -> Int {
		let userDefault = UserDefaults.standard
		let itemID = userDefault.integer(forKey: "ChecklistItemID")
		userDefault.set(itemID + 1, forKey: "ChecklistItemID")
		return itemID
	}
}
