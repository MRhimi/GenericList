//
//  GenericViewModel.swift
//  GenericListUIKit
//
//  Created by MRhimi on 18/4/2023.
//

import UIKit

class GenericViewModel<U> {
    
    @Published var itemsList: [U] = []
    
    func fetchItems() {
        
    }
    
    
    func numberOfItems() -> Int {
        return itemsList.count
    }
    
    func cellForItem(at indexPath: IndexPath) -> U {
        return itemsList[indexPath.row]
    }
    
    func didSelectItem(at indexPath: IndexPath) -> U {
        return itemsList[indexPath.row]
    }
}
