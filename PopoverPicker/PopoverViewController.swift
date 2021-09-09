//
//  PopupViewController.swift
//  Reader
//
//  Created by Admin on 4/9/21.
//  Copyright © 2021 iPhoneGameZone. All rights reserved.
//

import UIKit

class PopoverViewController<T: ListItem>: UIViewController, UITableViewDataSource, UITableViewDelegate {
	var tableView: UITableView!
	var listOfItems  = [T]()
	var selectClosure: ((T) -> Void)?

	let cellMap: [AnyHashable: ListItemDisplay.Type] = {
		let k1: HashableType = HashableType<UIFont>(UIFont.self)
		let k2: HashableType = HashableType<UIColor>(UIColor.self)
		let v1: FontCell.Type = FontCell.self
		let v2: ColorCell.Type = ColorCell.self

		let cm = [k1: v1, k2: v2] as! [AnyHashable: ListItemDisplay.Type]
		return cm
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		self.createTableView()
	}

	func createTableView() {
		if self.tableView == nil {
			self.tableView = UITableView(frame: self.view.bounds)
			self.tableView.dataSource = self
			self.tableView.delegate = self
		}
		self.view.addSubview(self.tableView)

		let cellClass = self.cellMap[HashableType<T>(T.self)]
		self.tableView.register((cellClass as! UITableViewCell.Type), forCellReuseIdentifier: cellClass!.reuseId)
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		self.tableView.reloadData()
	}

	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.listOfItems.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let listItem = self.listOfItems[indexPath.row]
		let cellClass = self.cellMap[HashableType<T>(T.self)]
		let cell = tableView.dequeueReusableCell(withIdentifier: cellClass!.reuseId) as? ListItemDisplay
		cell!.updateUI(listItem: listItem)
		return cell as! UITableViewCell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let selectedItem = self.listOfItems[indexPath.row]
		self.dismiss(animated: true) {
			self.selectClosure?(selectedItem)
		}
	}
}
