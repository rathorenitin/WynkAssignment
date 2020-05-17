//
//  NavigationRouter.swift
//  WynkAssignment
//
//  Created by Admin on 17/05/20.
//  Copyright © 2020 Nitin Singh Rathore. All rights reserved.
//

import UIKit

class NavigationRouter {
    
    static let shared  = NavigationRouter()
    var navigationController = UINavigationController()
    
    private init() {
        
    }
    
    func initialViewController(window: UIWindow?) {
        
        let searchImageVCScene =  SearchImageVC.instantiate(fromAppStoryboard: .Main)
        navigationController = UINavigationController(rootViewController: searchImageVCScene)
        window?.rootViewController = navigationController
    }
    
    func navigateToSearchImageDetailsViewController(listData: [Hit], index: Int)-> SearchImageDetailVC {
        let searchImageDetailScene = SearchImageDetailVC.instantiate(fromAppStoryboard: .Main)
        searchImageDetailScene.backgroundColor = UIColor.black
        searchImageDetailScene.viewModel.imageList = listData
        navigationController.present(searchImageDetailScene, animated: true, completion: { () -> Void in
            searchImageDetailScene.currentPage = index
        })
        return searchImageDetailScene
    }
    
    func popViewController() {
        self.navigationController.popViewController(animated: true)
    }
    
    func dismissViewController() {
        self.navigationController.dismiss(animated: true, completion: nil)
    }
    
}
