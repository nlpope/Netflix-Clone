//
//  Extensions.swift
//  Netflix Clone
//
//  Created by Noah Pope on 12/20/22.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
