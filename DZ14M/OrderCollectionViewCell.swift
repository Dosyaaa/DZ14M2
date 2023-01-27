//
//  OrderCollectionViewCell.swift
//  DZ14M
//
//  Created by User on 28/1/23.
//

import UIKit

class OrderCollectionViewCell: UICollectionViewCell {
    static var reuseIdentifier = String(describing: ProductNameTableViewCell.self)
    
    @IBOutlet private weak var orderLabel: UILabel!
    
    func display(item: Order) {
        orderLabel.text = item.label
        orderLabel.layer.cornerRadius = 15
        orderLabel.layer.borderWidth = 2
        orderLabel.layer.borderColor = UIColor.systemGray.cgColor
    }
}

struct Order {
    let label: String
}
