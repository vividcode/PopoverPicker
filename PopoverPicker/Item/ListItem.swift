//
//  ListItem.swift
//  Reader
//
//  Created by Admin on 4/8/21.
//  Copyright © 2021 iPhoneGameZone. All rights reserved.
//

import Foundation
import UIKit

protocol ListItem: Hashable {
	associatedtype T
	associatedtype U: UITableViewCell
	var representation: String { get }
	var selection: T { get }
}

/// Hashable wrapper for a metatype value.
struct HashableType<T: ListItem>: Hashable {
  static func == (lhs: HashableType, rhs: HashableType) -> Bool {
	return lhs.base == rhs.base
  }

  let base: T.Type

  init(_ base: T.Type) {
	self.base = base
  }

  func hash(into hasher: inout Hasher) {
	hasher.combine(ObjectIdentifier(base))
  }
}
