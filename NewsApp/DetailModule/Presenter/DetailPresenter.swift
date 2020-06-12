//
//  DetailPresenter.swift
//  NewsApp
//
//  Created by Pavel Bondar on 07.06.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import Foundation
import UIKit.UIApplication

protocol DetailViewProtocol: class {
    func setArticle(article: Article?)
}

protocol DetailViewPresenterProtocol: class {
    init(view: DetailViewProtocol, networkService: NetworkManager, router: RouterProtocol, article: Article?)
    func setArticle()
    func goToWeb()
}

class DetailPresenter: DetailViewPresenterProtocol {
    
    weak var view: DetailViewProtocol?
    var router: RouterProtocol?
    let networkService: NetworkServiceProtocol!
    var article: Article?
    
    required init(view: DetailViewProtocol, networkService: NetworkManager, router: RouterProtocol, article: Article?) {
        self.view = view
        self.networkService = networkService
        self.article = article
        self.router = router
    }
    
    public func setArticle() {
        self.view?.setArticle(article: article)
    }
    
    func goToWeb() {
        if let url = article?.url {
            UIApplication.shared.open(url)
        }
    }
}
