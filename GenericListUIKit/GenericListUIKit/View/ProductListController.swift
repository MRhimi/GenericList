//
//  ProductListController.swift
//  GenericListUIKit
//
//  Created by MRhimi on 09/09/2023.
//

import UIKit


class ProductListController: GenericTableVC<ProductTableViewCell, Product> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.title = "Product List"
    }
    
    override func showDetails(with item: Product) {
        showProductDetails(selectedProduct: item)
    }
    
    func showProductDetails(selectedProduct: Product) {
        let alertController = UIAlertController(title: "Product Details", message: nil, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        
        // Customize the alert message with product details.
        alertController.message = """
            Name: \(selectedProduct.name)
            Price: $\(selectedProduct.price)
            """
        
        present(alertController, animated: true, completion: nil)
    }
    
}


