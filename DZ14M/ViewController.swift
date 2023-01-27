//
//  ViewController.swift
//  DZ14M
//
//  Created by User on 27/1/23.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate {
    @IBOutlet weak var productColletionView: UICollectionView!
    @IBOutlet weak var productTableView: UITableView!
    @IBOutlet weak var orderCollectionView: UICollectionView!
    
    private var categoryArray: [Products] = [
        Products(imageName: "1", label: "Takeaways"),
        Products(imageName: "2", label: "Grocery"),
        Products(imageName: "3", label: "Convenience"),
        Products(imageName: "4", label: "Pharmacy")
    ]
    
    private var productArray: [ProductsName] = [
        ProductsName(imageTableView: "5", nameTableView: "Burger Craze", timeLabel: "15 - 20min", countryLabel: "American"),
        ProductsName(imageTableView: "6", nameTableView: "Vegetarian Pizza", timeLabel: "10 - 15min", countryLabel: "Italian"),
        ProductsName(imageTableView: "7", nameTableView: "Shaurma", timeLabel: "10-15min", countryLabel: "Kyrgyz")
    ]
    
    private var orderArray: [Order] = [
        Order(label: "Delivery"),
        Order(label: "Pickup"),
        Order(label: "Catering"),
        Order(label: "Carbside")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuteProductCV()
        configuteProductTV()
        configuteOrderCV()
        productColletionView.showsHorizontalScrollIndicator = false
        productTableView.showsVerticalScrollIndicator = false
        orderCollectionView.showsHorizontalScrollIndicator = false
    }
    
    private func configuteProductCV() {
        productColletionView.delegate = self
        productColletionView.dataSource = self
        productColletionView.register(
            UINib(nibName: String(describing: ProductCollectionViewCell.self),
            bundle: nil), forCellWithReuseIdentifier: ProductCollectionViewCell.reuseIdentifier)
    }
    
    private func configuteOrderCV() {
        orderCollectionView.delegate = self
        orderCollectionView.dataSource = self
        orderCollectionView.register(
            UINib(nibName: String(describing: OrderCollectionViewCell.self),
            bundle: nil), forCellWithReuseIdentifier: OrderCollectionViewCell.reuseIdentifier)
    }
    
    private func configuteProductTV() {
        productTableView.delegate = self
        productTableView.dataSource = self
        productTableView.register(
            UINib(nibName: String(describing: ProductNameTableViewCell.self),
            bundle: nil),forCellReuseIdentifier: ProductNameTableViewCell.reuseIdentifier)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == productColletionView {
            return categoryArray.count
        } else {
            return orderArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == productColletionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.reuseIdentifier, for: indexPath) as! ProductCollectionViewCell
            let model = categoryArray[indexPath.row]
            cell.display(item: model)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OrderCollectionViewCell.reuseIdentifier, for: indexPath) as! OrderCollectionViewCell
            let model = orderArray[indexPath.row]
            cell.display(item: model)
            return cell
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == productColletionView {
            return CGSize(width: 80, height: 105)
        } else {
            return CGSize(width: 105, height: 80)
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductNameTableViewCell.reuseIdentifier, for: indexPath) as! ProductNameTableViewCell
        let model = productArray[indexPath.row]
        cell.display(item: model)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
}



    
