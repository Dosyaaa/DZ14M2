//
//  SecondViewController.swift
//  DZ14M
//
//  Created by User on 7/2/23.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var nameOfProductLabel: UITextField!
    @IBOutlet weak var companyLabel: UITextField!
    @IBOutlet weak var amountLabel: UITextField!
    @IBOutlet weak var categoryLabel: UITextField!
    @IBAction private func changeProduct() {
        guard let  product = product else {return}
        NetworkLayer.shared.changeProduct(with: product) { result in
            switch result {
            case .success( _):
                DispatchQueue.main.async {
                    self.showSucces(with: product)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showEror(with: error)
                }
            }
        }
    }
    public var product: ProductsName?
    
    func configureSV() {
        nameOfProductLabel.text = product?.title
        companyLabel.text = product?.brand
        amountLabel.text = "\(product?.price ?? 0)"
        categoryLabel.text = product?.category
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureSV()
    }
    
    func changeProducts(_ product: ProductsName) {
        NetworkLayer.shared.changeProduct(with: product) { result in
            DispatchQueue.main.async {
                let alert = UIAlertController(
                    title: "Succes",
                    message: "Succesed",
                    preferredStyle: .alert
                )
                alert.addAction(.init(title: "Okay", style: .cancel))
                self.present(alert, animated: true)
            }
        }
    }
    
    private func showEror(with message: Error) {
        let alert = UIAlertController(
            title: "Error",
            message: message.localizedDescription,
            preferredStyle: .alert
        )
        alert.addAction(.init(title: "Okay", style: .cancel))
        present(alert, animated: true)
    }
    
    private func showSucces(with message: ProductsName) {
        let alert = UIAlertController(
            title: "Succes",
            message: "Succesed",
            preferredStyle: .alert
        )
        alert.addAction(.init(title: "Okay", style: .cancel))
        present(alert, animated: true)
    }
}

extension String {
    var isNotEmpty: Bool {
        !isEmpty
    }
}
