//
//  TitleTableViewCell.swift
//  Netflix Clone
//
//  Created by Noah Pope on 12/28/22.
//

import UIKit

class TitleTableViewCell: UITableViewCell {

  static let identifier = "TitleTableViewCell"
    
    //initializers are not inherited for subclasses by default; Parent (UITableViewCell) already has this initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "")
    }

}
