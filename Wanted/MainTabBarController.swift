//
//  MainTabBarController.swift
//  Wanted
//
//  Created by 平尾健太 on 2021/02/20.
//

import UIKit
import FirebaseAuth

class MainTabBarController:
    UITabBarController ,UITabBarControllerDelegate{
    
//    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//        let index = viewControllers?.firstIndex(of:viewController)
//        if index == 2{//プラスボタンを押した時バーが移動しない
//
//            let layout = UICollectionViewFlowLayout()
//            let photoSelectorController = PhotoSelectorController(collectionViewLayout: layout)
//            let navController = UINavigationController(rootViewController: photoSelectorController)
//            present(navController, animated: true, completion: nil)
//
//            return false//falseだとボタンが反応しない
//        }
//
//        return true
//    }//タブアイテムをタップした時のイベントを拾う
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        if Auth.auth().currentUser == nil{
            DispatchQueue.main.async {
                let loginController = LoginViewController()
                let navController = UINavigationController(rootViewController: loginController)
                navController.modalPresentationStyle = .fullScreen
                self.present(navController, animated: true, completion: nil)
            }
            return
        }
        
        setupViewContoroller()
        
    }
    
    func setupViewContoroller(){
        //home
        let homeNavController = templateNavController(title: "ホーム",unselectedImage: UIImage(systemName: "house")! , selectedImage: UIImage(systemName: "house.fill")!,rootViewController: UICollectionViewController(collectionViewLayout:UICollectionViewFlowLayout()))
        
        //search
        let searchNavController = templateNavController(title: "さがす",unselectedImage: UIImage(systemName: "magnifyingglass")!, selectedImage: UIImage(systemName: "magnifyingglass")!,rootViewController: UICollectionViewController(collectionViewLayout: UICollectionViewFlowLayout()))
       
        //plus
        let plusNavController = templateNavController(title: "逆出品",unselectedImage: UIImage(systemName: "camera")!, selectedImage: UIImage(systemName: "camera.fill")!,rootViewController: UICollectionViewController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        //like
        
        let likeNavController = templateNavController(title: "おしらせ",unselectedImage: UIImage(systemName: "bell")!, selectedImage: UIImage(systemName: "bell.fill")!,rootViewController: UICollectionViewController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        //user profile
        let userProfileNavController = templateNavController(title: "プロフィール",unselectedImage: UIImage(systemName: "person")!, selectedImage: UIImage(systemName: "person.fill")!,rootViewController: UserProfileViewController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        tabBar.tintColor = .black
        tabBar.barTintColor = .white
        
        viewControllers = [homeNavController,
                           searchNavController,
                           plusNavController,
                           likeNavController,
                           userProfileNavController]
        

    }
    
    fileprivate func templateNavController(title:String,unselectedImage:UIImage,
                                           selectedImage:UIImage,rootViewController:UIViewController = UIViewController()) -> UINavigationController{
        let viewContoroller = rootViewController
        let navController = UINavigationController(rootViewController: viewContoroller)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        return navController
    }
}



