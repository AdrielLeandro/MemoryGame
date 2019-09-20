//
//  Service.swift
//  MatchGame
//
//  Created by Adriel on 9/12/19.
//  Copyright © 2019 Adriel Pinzas. All rights reserved.
//

import Foundation
import Alamofire

protocol ProductServiceProtocol: class {
    func getProducts(_ completion: @escaping (([Card]?, String?) -> Void))
}

class ProductService: ProductServiceProtocol {
    private let url = "https://shopicruit.myshopify.com/admin/products.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6"
    private let decoder = JSONDecoder()

    func getProducts(_ completion: @escaping (([Card]?, String?) -> Void)) {
        Alamofire.request(url, method: .get, parameters:nil, encoding: URLEncoding.default).response { (response) in

            do {
                guard let data = response.data, let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary else {
                    completion(nil, response.error?.localizedDescription)
                    return
                }
                let result = Result.from(jsonResult)
                let cards = CardBuilder().build(result: result)
                completion(cards, nil)

            } catch {
                completion(nil, "Error convert to json")
            }
        }
    }
}
