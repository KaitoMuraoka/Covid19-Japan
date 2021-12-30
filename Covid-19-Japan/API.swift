//
//  APIAPI.swift
//  Covid-19-Japan
//
//  Created by 村岡海人 on 2021/12/30.
//

import UIKit

struct CovidAPI {
    static func getTotal(completion: @escaping (CovidInfo.Total) -> Void){
        let url = URL(string: "https://covid19-japan-web-api.now.sh/api//v1/total")
        let request = URLRequest(url: url!)
        URLSession.shared.dataTask(with: request) { (data, respones, error) in
            if error != nil {
                print("error: \(error!.localizedDescription)")
            }
            if let data = data {
                let result = try! JSONDecoder().decode(CovidInfo.Total.self, from: data)
                completion(result)
            }
        }.resume()
    }
}