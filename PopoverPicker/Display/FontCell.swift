//
//  FontCell.swift
//  PopoverPicker
//
//  Created by Admin on 4/9/21.
//

import Foundation
import UIKit

class FontCell: UITableViewCell {

}

extension FontCell: ListItemDisplay {
	static var reuseId: String {
		return "FontCell"
	}

	func updateUI<T: ListItem>(listItem: T) {
		guard let fontItem = listItem as? UIFont else {
			return
		}
		self.textLabel?.font = fontItem
		self.textLabel?.text = fontItem.representation
	}
}
