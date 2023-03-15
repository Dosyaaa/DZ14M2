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
        Task {
            do {
                let result = try await NetworkLayer.shared.changeProduct(with: product)
                if result {
                    DispatchQueue.main.async {
                        self.showSucces(with: product)
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.showError(with: error)
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
        guard product != nil else {
            Task {
                do {
                    let result = try await NetworkLayer.shared.changeProduct(with: product)
                    if result  {
                        DispatchQueue.main.async {
                            self.showSucces(with: product)
                        }
                        
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.showError(with: error)
                    }
                }
            }
            return
        }
    }
    
    private func showError(with message: Error) {
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
