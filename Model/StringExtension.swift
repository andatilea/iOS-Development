//
//  StringExtension.swift
//  Pandemify
//
//  Created by Anda Tilea on 30.08.2021.
//

import Foundation
import UIKit

extension String {
    var isBlank: Bool {
        // when typing two spaces -> the table view becomes empty (no search found)
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
