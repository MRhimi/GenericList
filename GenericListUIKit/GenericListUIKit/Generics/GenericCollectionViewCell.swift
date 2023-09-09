//
//  GenericCollectionViewCell.swift
//  GenericListUIKit
//
//  Created by MRhimi on 18/4/2023.
//

import UIKit

class GenericCollectionViewCell<U>: UICollectionViewCell {
    
    func configure(with item: U) {
        // Configure cell with item data
    }
    
    func loadUIElements(){
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadUIElements()
    }
   
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadUIElements()
    }
}


extension UICollectionViewCell {
    
    class var reuseIdentifier: String {
        return String(describing: self)
    }
}

