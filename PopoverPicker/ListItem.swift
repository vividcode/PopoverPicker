//
//  ListItem.swift
//  Reader
//
//  Created by Admin on 4/8/21.
//  Copyright © 2021 iPhoneGameZone. All rights reserved.
//

import Foundation
import UIKit

protocol ListItem {
	associatedtype T
	associatedtype U: UITableViewCell
	var representation: String { get }
	var selection: T { get }

	func getTableViewCell(tableView: UITableView) -> U?
	static func registerTableViewCell(tableView: UITableView)
	func updateUI(cell: UITableViewCell)
}

extension UIFont: ListItem {
	typealias T = UIFont
	typealias U = FontCell

	var representation: String {
		return self.familyName
	}

	var selection: UIFont {
		return UIFont.init(name: representation, size: 17.0) ?? UIFont.systemFont(ofSize: 17)
	}

	func getTableViewCell(tableView: UITableView) -> U? {
		return tableView.dequeueReusableCell(withIdentifier: FontCell.reuseIdentifier) as? FontCell
	}

	static func registerTableViewCell(tableView: UITableView) {
		tableView.register(FontCell.classForCoder(), forCellReuseIdentifier: FontCell.reuseIdentifier)
	}

	func updateUI(cell: UITableViewCell) {
		cell.textLabel?.font = self
		cell.textLabel?.text = self.representation
	}
}

extension UIColor: ListItem {
	typealias T = UIColor
	typealias U = ColorCell

	var representation: String {
		return self.toHex() ?? "#FFFFFF"
	}

	var selection: UIColor {
		return UIColor(hex: representation) ?? UIColor.white
	}

	func getTableViewCell(tableView: UITableView) -> U? {
		return tableView.dequeueReusableCell(withIdentifier: ColorCell.reuseIdentifier) as? ColorCell
	}

	static func registerTableViewCell(tableView: UITableView) {
		tableView.register(ColorCell.classForCoder(), forCellReuseIdentifier: ColorCell.reuseIdentifier)
	}

	func updateUI(cell: UITableViewCell) {
		cell.contentView.backgroundColor = self.withAlphaComponent(0.7)
		cell.textLabel?.text = self.representation
	}
}

// MARK: - From UIColor to String
extension UIColor {
	convenience init?(hex: String) {
		var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
		hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

		var rgb: Int64 = 0

		var r: CGFloat = 0.0
		var g: CGFloat = 0.0
		var b: CGFloat = 0.0
		var a: CGFloat = 1.0

		let length = hexSanitized.count

		guard Scanner(string: hexSanitized).scanInt64(&rgb) else { return nil }

		if length == 6 {
			r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
			g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
			b = CGFloat(rgb & 0x0000FF) / 255.0
		} else if length == 8 {
			r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
			g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
			b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
			a = CGFloat(rgb & 0x000000FF) / 255.0

		} else {
			return nil
		}

		self.init(red: r, green: g, blue: b, alpha: a)
	}

	// MARK: - Computed Properties
	var toHex: String? {
		return toHex()
	}

	func toHex(alpha: Bool = false) -> String? {
		guard let components = cgColor.components, components.count >= 3 else {
			return nil
		}

		let r = Float(components[0])
		let g = Float(components[1])
		let b = Float(components[2])
		var a = Float(1.0)

		if components.count >= 4 {
			a = Float(components[3])
		}

		if alpha {
			return String(format: "%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
		} else {
			return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
		}
	}
}
