//
//  CovidSingleton.swift
//  Covid-19-Japan
//
//  Created by 村岡海人 on 2022/01/07.
//

import Foundation

class CovidSingleton {
    private init() {}
    static let shared = CovidSingleton()
    var prefecture: [CovidInfo.Prefecture] = []
}
