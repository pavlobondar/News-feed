//
//  ModuleBuilder.swift
//  NewsApp
//
//  Created by Pavel Bondar on 07.06.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit.UIViewController

protocol Builder {
    static func createNewsModule() -> UIViewController
}

class ModelBuilder: Builder {
    static func createNewsModule() -> UIViewController {
        let view = NewsViewController()
        let networkService = NetworkService()
        let presenter = NewsPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        return view
    }
}