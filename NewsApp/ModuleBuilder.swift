//
//  ModuleBuilder.swift
//  NewsApp
//
//  Created by Pavel Bondar on 07.06.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit.UIViewController

protocol AsselderBuilderProtocol {
    func createNewsModule(router: RouterProtocol) -> UIViewController
    func createDetailModule(article: Article?, router: RouterProtocol) -> UIViewController
}

class AsselderModelBuilder: AsselderBuilderProtocol {    
    func createNewsModule(router: RouterProtocol) -> UIViewController {
        let view = NewsViewController()
        let networkService = NetworkManager()
        let presenter = NewsPresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }
    
    func createDetailModule(article: Article?, router: RouterProtocol) -> UIViewController {
        let view = DetailViewController()
        let networkService = NetworkManager()
        let presenter = DetailPresenter(view: view, networkService: networkService, router: router, article: article)
        view.presenter = presenter
        return view
    }
}
