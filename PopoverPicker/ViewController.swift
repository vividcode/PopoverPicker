//
//  ViewController.swift
//  PopoverPicker
//
//  Created by Admin on 4/9/21.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	@IBAction func showColorPicker(_ sender: Any) {
		let colors: [UIColor] = [.red, .green, .blue, .purple, .yellow, .gray, .magenta, .brown, .cyan, .black]
		self.showPopoverPicker(sourceView: (sender as! UIButton), sourceVC: self, list: colors)
	}

	@IBAction func showFontPicker(_ sender: Any) {
		let fonts = UIFont.familyNames.map { (fontName) -> UIFont in
			return (UIFont.init(name: fontName, size: 17) ?? UIFont.systemFont(ofSize: 17))
		}

		let numberOfFontsToShow = 12
		let fontsToShow = Array(fonts.dropLast((fonts.count > numberOfFontsToShow) ? fonts.count - numberOfFontsToShow : 0))
		self.showPopoverPicker(sourceView: (sender as! UIButton), sourceVC: self, list: fontsToShow)
	}

	func showPopoverPicker<T: ListItem>(sourceView: UIView,
										sourceVC: UIAdaptivePresentationControllerDelegate, list: [T]) {
		let popupVC = PopoverViewController<T>.init()
		popupVC.preferredContentSize = CGSize(width: 400, height: 500)
		popupVC.modalPresentationStyle = .popover

		popupVC.listOfItems = list

		let itemType: String = {
			if T.self == UIFont.self {
				return "Font:"
			}

			if T.self == UIColor.self {
				return "Color:"
			}

			return "Unknown type:"
		}()

		popupVC.selectClosure = { listItem in
			print("Selected \(itemType): \(listItem.representation) - \(listItem.selection)")
		}

		if let pC = popupVC.presentationController {
			pC.delegate = sourceVC
		}

		self.present(popupVC, animated: true)

		if let pop = popupVC.popoverPresentationController {
			pop.sourceView = sourceView
			pop.sourceRect = sourceView.bounds
		}
	}
}

extension ViewController: UIPopoverPresentationControllerDelegate {
	func adaptivePresentationStyle(for controller: UIPresentationController,
								   traitCollection: UITraitCollection) -> UIModalPresentationStyle {
		return .none
	}
}
