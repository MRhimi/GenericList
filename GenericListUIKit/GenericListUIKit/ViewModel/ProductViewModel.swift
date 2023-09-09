//
//  ProductViewModel.swift
//  GenericListUIKit
//
//  Created by MRhimi on 09/09/2023.
//

import Foundation
import Combine

//MARK: - View Model
class ProductViewModel: GenericViewModel<Product> {
  
    override func fetchItems() {
        
        self.itemsList = [
            Product(name: "Laptop", price: 1299.99),
            Product(name: "Smartphone", price: 799.99),
            Product(name: "Smartphone", price: 799.99),
            Product(name: "Smartwatch", price: 299.99)
        ]
       
    }
}
