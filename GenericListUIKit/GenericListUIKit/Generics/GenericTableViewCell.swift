//
//  GenericTableViewCell.swift
//  GenericListUIKit
//
//  Created by MRhimi on 18/4/2023.
//

import UIKit

class GenericTableViewCell<U>: UITableViewCell {
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        loadUIElements()
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadUIElements()
    }
    
    func configure(with item: U) {}
    
    func loadUIElements() {}
}


extension UITableViewCell {
    
    class var reuseIdentifier: String {
        return String(describing: self)
    }
}
