//
//  ColorCell.swift
//  PopoverPicker
//
//  Created by Admin on 4/9/21.
//

import Foundation
import UIKit

class ColorCell: UITableViewCell {
}

extension ColorCell: ListItemDisplay {
	static var reuseId: String {
		return "ColorCell"
	}

	func updateUI<T: ListItem>(listItem: T) {
		guard let colorItem = listItem as? UIColor else {
			return
		}
		self.contentView.backgroundColor = colorItem.withAlphaComponent(0.7)
		self.textLabel?.text = listItem.representation
	}
}
