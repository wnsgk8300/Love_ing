//
//  SceneDelegate.swift
//  LoveIngAPP
//
//  Created by 신민희 on 2021/02/28.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let rootVC = ViewController()
        let settingVC = DDayViewController()
        rootVC.tabBarItem = UITabBarItem(title: "D-day", image: UIImage(systemName: "heart.circle"), tag: 0)
        settingVC.tabBarItem = UITabBarItem(title: "Setting", image: UIImage(systemName: "gearshape"), tag: 1)
        
        //        UINavigationBar.appearance().barTintColor = UIColor(red: 0, green: 0/255, blue: 205/255, alpha: 1) // 네비게이션바 색상 변경
        //        UITabBar.appearance().barTintColor = UIColor(red: 255/255, green: 204/255, blue: 204/255, alpha: 1.0) // 텝바 색상 변경
        UINavigationBar.setTransparentTabbar()
        UITabBar.setTransparentTabbar()
        
        let tabBarController = UITabBarController()
        let tabBarControllerWL = UITabBarController()
        
        tabBarController.title = "D-day"
        tabBarControllerWL.title = "Setting"
        
        let settingViewController = UINavigationController(rootViewController: settingVC)
        let rootNaviController = UINavigationController(rootViewController: rootVC)
        
        tabBarController.viewControllers = [rootNaviController, settingViewController]
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
    }
    func sceneDidBecomeActive(_ scene: UIScene) {
    }
    func sceneWillResignActive(_ scene: UIScene) {
    }
    func sceneWillEnterForeground(_ scene: UIScene) {
    }
    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}

extension UITabBar {
    static func setTransparentTabbar() {
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().shadowImage     = UIImage()
        UITabBar.appearance().clipsToBounds   = true
    }
} // 텝바 투명하게 처리

extension UINavigationBar {
    static func setTransparentTabbar() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage     = UIImage()
        UINavigationBar.appearance().clipsToBounds   = true
    }
}
