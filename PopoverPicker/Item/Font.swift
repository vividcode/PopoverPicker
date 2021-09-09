//
//  Font.swift
//  PopoverPicker
//
//  Created by Admin on 9/9/21.
//

import UIKit

extension UIFont: ListItem {
	typealias T = UIFont
	typealias U = FontCell

	var representation: String {
		return self.familyName
	}

	var selection: UIFont {
		return UIFont.init(name: representation, size: 17.0) ?? UIFont.systemFont(ofSize: 17)
	}
}
