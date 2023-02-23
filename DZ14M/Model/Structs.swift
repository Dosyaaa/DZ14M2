//
//  Structs.swift
//  DZ14M
//
//  Created by User on 23/2/23.
//

import Foundation

struct ProductsName: Codable {
    let thumbnail: String
    let price: Int
    let discountPercentage: Double
    let rating: Double
    let stock: Int
    let description: String
    let title: String
    let brand: String
    let category: String
}

struct ProductsSearch: Codable {
    let products: [ProductsName]
}

let orderJSON = """
[
{
 "label": "Delivery"
},
{
 "label": "Pickup"
},
{
 "label": "Catering"
},
{
 "label": "Carbside"
},
]
"""

struct Order: Codable {
    let label: String
}

let productsJSON = """
[
{
"imageName": "1",
"label": "Takeaways"
},
{
"imageName": "2",
"label": "Grocery"
},
{
"imageName": "3",
"label": "Convenience"
},
{
"imageName": "4",
"label": "Pharmacy"
}
]
"""

struct Products: Codable {
    let imageName: String
    let label: String
}
