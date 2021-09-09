# PopoverViewController

`PopoverViewController` is a reusable UIKit based View controller that can be used for picking items such as Font and Color.

## Usage:

```
func showPopoverPicker<T: ListItem>(sourceView: UIView,` sourceVC: UIAdaptivePresentationControllerDelegate, list: [T]) {
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

**In the above code:**

- `sourceView` is the originating view from where popover must be shown, which is usually a `UIButton`.
- `list` is an array of objects whose type implements `ListItem` protocol. In the present repo, `UIFont` and `UIColor` implements it. See `Item` folder in source tree.
- Any `UITableViewCell` subclass to display popover items (font, color in this project) must extend from `ListItemDisplay` to provide the following:
  - `reuseId` - to use as `UITableView reuseIdentifier`
  - `updateUI` - function to customize the cell display
- The parent `ViewController` that displays popup showing buttons must implement the above `showPopoverPicker()` function, and should also conform to `UIPopoverPresentationControllerDelegate`, as below:

```
extension ViewController: UIPopoverPresentationControllerDelegate {
	func adaptivePresentationStyle(for controller: UIPresentationController,
								   traitCollection: UITraitCollection) -> UIModalPresentationStyle {
		return .none
	}
}
```

To change what object you get inside `selectClosure` upon selection in Popover, use an override of `ListItem.selection`.
