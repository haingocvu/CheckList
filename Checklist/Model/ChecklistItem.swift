//
//  ChecklistItem.swift
//  Checklist
//
//  Created by Hai Vu on 4/22/19.
//  Copyright © 2019 Hai Vu. All rights reserved.
//
import Foundation
import UserNotifications

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
	
	func scheduleNotification() {
		removeNotification()
		if shouldRemind && dueDate > Date() {
			let content = UNMutableNotificationContent()
			content.title = "Reminder"
			content.body = text
			content.sound = .default
			let calender = Calendar(identifier: .gregorian)
			let dateComponent = calender.dateComponents([.year, .month, .day, .hour, .minute], from: dueDate)
			let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
			let request = UNNotificationRequest(identifier: "\(itemID)", content: content, trigger: trigger)
			let center = UNUserNotificationCenter.current()
			center.add(request, withCompletionHandler: nil)
			print("Schedule \(request) for \(itemID)")
		}
	}
	
	func removeNotification() {
		let center = UNUserNotificationCenter.current()
		center.removePendingNotificationRequests(withIdentifiers: ["\(itemID)"])
	}
	
	deinit {
		removeNotification()
	}
}
