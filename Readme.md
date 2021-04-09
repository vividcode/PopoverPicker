# PopoverViewController

`PopoverViewController` is a reusable UIKit based View controller that can be used for picking items such as Font and Color.

## Usage:

```
func showPopoverPicker<T: ListItem>(sourceView: UIView,`
										sourceVC: UIAdaptivePresentationControllerDelegate, list: [T]) {
		let popupVC = PopoverViewController<T>.init()
		popupVC.preferredContentSize = CGSize(width: 400, height: 500)
		popupVC.modalPresentationStyle = .popover

		popupVC.listOfItems = list

		popupVC.selectClosure = { listItem in
			print("Selected: \(listItem.representation) - \(listItem.selection)")
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
```

`sourceView` is the originating view from where popover must be shown, which is usually a UIButton.

# How to change display of the pickable items (UIFont UIColor in this example):

In the file `ListItem.swift`, update the `updateUI` function:

```
func updateUI(cell: UITableViewCell) {
		cell.textLabel?.text = self.representation
	}
```

For data items other than `UIFont` or `UIColor`, override `ListItem.representation`.

To change what object you get inside `selectClosure`, override `ListItem.selection`.
