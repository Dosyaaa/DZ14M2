//
//  MainViewController.swift
//  DZ14M
//
//  Created by User on 27/1/23.
//

import UIKit

//class MainViewController: UIViewController {
//
//    @IBOutlet weak var productColletionView: UICollectionView!
//    
//    private var productArray: [String] = ["TakeAway","Delivery"
//    ]
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        configuteProductCV()
//    }
//    private func configuteProductCV(){
//        productColletionView.delegate = self
//        productColletionView.dataSource = self
//        productColletionView.register(
//            UINib(
//            nibName: String(describing: ProductCollectionViewCell.self),
//            bundle: nil
//        ),
//    forCellWithReuseIdentifier: ProductCollectionViewCell.reuseIdentifier
//        )
//    }
//}
//extension MainViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return productArray.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.reuseIdentifier, for: indexPath) as! ProductCollectionViewCell
//        let model = productArray[indexPath.row]
//        cell.display(item: model)
//        return cell
//    }
//}
//extension MainViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 80, height: 105)
//    }
//}
