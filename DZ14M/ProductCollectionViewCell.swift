//
//  ProductCollectionViewCell.swift
//  DZ14M
//
//  Created by User on 27/1/23.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    static var reuseIdentifier = String(describing: ProductCollectionViewCell.self)
    
    @IBOutlet weak var imageOfProduct: UIImageView!
    @IBOutlet weak var labelOfProduct: UILabel!
    
    func display(item: Products) {
        labelOfProduct.text = item.label
        imageOfProduct.image = UIImage(named: item.imageName)
    }
}

struct Products {
    let imageName: String
    let label: String
}
