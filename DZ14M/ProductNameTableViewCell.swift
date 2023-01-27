//
//  ProductNameTableViewCell.swift
//  DZ14M
//
//  Created by User on 28/1/23.
//

import UIKit

class ProductNameTableViewCell: UITableViewCell {
    
    static var reuseIdentifier = String(describing: ProductNameTableViewCell.self)
    
    @IBOutlet weak var imageTableView: UIImageView!
    @IBOutlet weak var openOrCloseLabel: UILabel!
    @IBOutlet weak var nameTableView: UILabel!
    @IBOutlet weak var imageOfRate: UIImageView!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var dotOne: UIImageView!
    @IBOutlet weak var dotTwo: UIImageView!
    @IBOutlet weak var dotThree: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var labelBurgers: UILabel!
    @IBOutlet weak var deliveryLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var navigationImage: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    func display(item: ProductsName) {
        imageTableView.image = UIImage(named: item.imageTableView)
        countryLabel.text = item.countryLabel
        timeLabel.text = item.timeLabel
    }
}

struct ProductsName {
    let imageTableView: String
    let nameTableView: String
    let timeLabel: String
    let countryLabel: String
}
