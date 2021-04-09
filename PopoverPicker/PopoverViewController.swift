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
		T.registerTableViewCell(tableView: self.tableView)
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
		let cell = listItem.getTableViewCell(tableView: tableView)
		listItem.updateUI(cell: cell!)
		return cell!
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let selectedItem = self.listOfItems[indexPath.row]
		self.dismiss(animated: true) {
			self.selectClosure?(selectedItem)
		}
	}
}
