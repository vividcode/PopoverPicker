//
//  ListItemDisplay.swift
//  PopoverPicker
//
//  Created by Admin on 9/9/21.
//

import Foundation

protocol ListItemDisplay {
	static var reuseId: String { get }
	func updateUI<T: ListItem>(listItem: T)
}
