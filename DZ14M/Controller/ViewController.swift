//
//  ViewController.swift
//  DZ14M
//
//  Created by User on 27/1/23.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate {
    
    private var products: [Products] = []
    private var productsName: [ProductsName] = []
    private var orders: [Order] = []
    private var isLoading = false
    public var product1: ProductsName?
    
    @IBOutlet weak var productColletionView: UICollectionView!
    @IBOutlet weak var productTableView: UITableView!
    @IBOutlet weak var orderCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProducts()
        fetchOrders()
        fetchProduct()
        configure()
        productColletionView.showsHorizontalScrollIndicator = false
        productTableView.showsVerticalScrollIndicator = false
        orderCollectionView.showsHorizontalScrollIndicator = false
    }
    
    private func configure() {
        productColletionView.delegate = self
        productColletionView.dataSource = self
        productColletionView.register(
            UINib(
                nibName: String(
                    describing: ProductCollectionViewCell.self
                ),
                bundle: nil),
            forCellWithReuseIdentifier: ProductCollectionViewCell.reuseIdentifier
        )
        orderCollectionView.delegate = self
        orderCollectionView.dataSource = self
        orderCollectionView.register(
            UINib(nibName: String(describing: OrderCollectionViewCell.self),
                  bundle: nil), forCellWithReuseIdentifier: OrderCollectionViewCell.reuseIdentifier)
        productTableView.delegate = self
        productTableView.dataSource = self
        productTableView.register(
            UINib(nibName: String(describing: ProductNameTableViewCell.self),
                  bundle: nil),forCellReuseIdentifier: ProductNameTableViewCell.reuseIdentifier)
    }
    
    private func fetchProducts() {
        do {
            products = try NetworkLayer.shared.fetchProducts()
            productColletionView.reloadData()
        }catch {
            print("error \(error.localizedDescription)")
        }
    }
    
    private func fetchOrders() {
        do {
            orders = try NetworkLayer.shared.fetchOrders()
            orderCollectionView.reloadData()
        }catch {
            print("error \(error.localizedDescription)")
        }
    }
    
    private func fetchProduct() {
        isLoading = true
        Task {
            do {
                let model = try await NetworkLayer.shared.fetchProducts()
                isLoading = false
                products = model
                DispatchQueue.main.async {
                    self.productTableView.reloadData()
                }
            } catch {
                showError(with: error)
            }
        }
    }
    
    private func searchProduct(by word: String) {
        isLoading = true
        Task {
            do {
                let model = try await NetworkLayer.shared.searchProduct(by: word)
                isLoading = false
                products = model
                DispatchQueue.main.async {
                    self.productTableView.reloadData()
                }
            } catch {
                showError(with: error)
            }
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
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        if collectionView == productColletionView {
            return products.count
        } else {
            return orders.count
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        if collectionView == productColletionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.reuseIdentifier,
                                                          for: indexPath
            ) as! ProductCollectionViewCell
            let model = products[indexPath.row]
            cell.display(item: model)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: OrderCollectionViewCell.reuseIdentifier,
                for: indexPath
            ) as! OrderCollectionViewCell
            let model = orders[indexPath.row]
            cell.display(item: model)
            return cell
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        if collectionView == productColletionView {
            return CGSize(width: 80, height: 105)
        } else {
            return CGSize(width: 105, height: 80)
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return productsName.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ProductNameTableViewCell.reuseIdentifier,
            for: indexPath
        ) as! ProductNameTableViewCell
        let model = productsName[indexPath.row]
        cell.display(item: model)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return 350
    }
    
    private func showEror(with message: Error) {
        let alert = UIAlertController(title: "Error", message: message.localizedDescription, preferredStyle: .alert)
        alert.addAction(.init(title: "Okay", style: .cancel))
        present(alert, animated: true)
    }
    
    private func showSucces(with message: ProductsName) {
        let alert = UIAlertController(title: "Succes", message: "Succesed", preferredStyle: .alert)
        alert.addAction(.init(title: "Okay", style: .cancel))
        present(alert, animated: true)
    }

    private func deleteProduct(product: ProductsName) {
        Task {
            do {
                guard let product = product1 else { return }
                let model = try await NetworkLayer.shared.deleteProduct()
                if model {
                    DispatchQueue.main.async {
                        self.showSucces(with: product )
                    }
                }
            } catch {
                showError(with: error)
            }
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "Удалить продукт", message: "Вы действительно хотите удалить продукт?", preferredStyle: .alert)
            
            let succes = UIAlertAction(title: "Да", style: .default) { action in
                self.productsName.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                let delete = self.productsName[indexPath.row]
                self.deleteProduct(product: delete)
                self.productTableView.reloadData()
            }
            let close = UIAlertAction(title: "Нет", style: .cancel)
            alert.addAction(succes)
            alert.addAction(close)
            present(alert, animated: true)
        }
        productTableView.beginUpdates()
        productTableView.endUpdates()
    }
    func tableView(
        _ tableView: UITableView,
        leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(
            style: .destructive,
            title: "Change"
        ) { (action, view, handler) in
            let alert = UIAlertController(
                title: "Изменить продукт",
                message: "Вы действительно хотите изменить продукт?",
                preferredStyle: .alert
            )
            let succes = UIAlertAction(title: "Да", style: .default) { action in
                let secondVC = self.storyboard?.instantiateViewController(
                    withIdentifier: "SecondViewController"
                ) as! SecondViewController
                self.navigationController?.pushViewController(secondVC, animated: true)
                secondVC.product = self.productsName[indexPath.row]
            }
            let close = UIAlertAction(title: "Нет", style: .cancel)
            alert.addAction(succes)
            alert.addAction(close)
            self.present(alert, animated: true)
        }
        deleteAction.backgroundColor = .green
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(
        _ searchBar: UISearchBar,
        textDidChange searchText: String
    ) {
        if !isLoading {
            searchProduct(by: searchText)
        }
    }
}


