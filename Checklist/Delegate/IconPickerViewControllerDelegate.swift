//
//  IconPickerViewControllerDelegate.swift
//  Checklist
//
//  Created by Hai Vu on 5/2/19.
//  Copyright © 2019 Hai Vu. All rights reserved.
//

import Foundation
protocol IconPickerViewControllerDelegate: AnyObject {
	func iconPicker(_ controller: IconPickerViewController, didSelect iconName: String)
}
