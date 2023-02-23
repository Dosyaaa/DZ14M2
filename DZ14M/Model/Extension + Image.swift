//
//  Extension + Image.swift
//  DZ14M
//
//  Created by User on 23/2/23.
//

import UIKit

extension UIImageView {
    func getImage(_ path: String) {
            guard let url = URL(string: path) else { return }
            Task {
                let (data, _) = try await URLSession.shared.data(from: url)
                DispatchQueue.main.async {
                self.image = UIImage(data: data)
                }
            }
        }
}
