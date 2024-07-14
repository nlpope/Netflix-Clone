//
//  UITableView+Ext.swift
//  Netflix Clone
//
//  Created by Noah Pope on 7/14/24.
//

import UIKit

extension UITableView {
    
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
}
