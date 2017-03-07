//
//  Foundation.swift
//  Additions
//
//  Created by James Froggatt on 27.09.2016.
//
//

import Foundation

public extension IndexPath {
	init(row: Int) {
		self.init(indexes: [0, row])
	}
	init(item: Int) {
		self.init(indexes: [0, item])
	}
}
