//
//  BaseViewController.swift
//  SearchAcronyms
//
//  Created by Carlos Villamizar on 9/11/21.
//

import UIKit

class BaseViewController: UIViewController {
    
    var loadingVC: LoadingIndicatorViewController?
//    var menuIcon = BadgedButtonItem(with: UIImage(named: "menu-icon"))
//    var bellIcon = BadgedButtonItem(with: UIImage(named: "bell-icon"))

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func hideBackButton() {
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    func setupBackButton(title: String) {
        let backButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"),
                                                              style: .plain,
                                                              target: self,
                                                              action: #selector(self.backButtonClickedDismiss(sender:)))
        
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
        let labelText = UILabel()
        
        labelText.text = title.uppercased()
        labelText.textAlignment = .left
        
        self.navigationItem.leftBarButtonItem  = backButtonItem
        
        labelText.frame = CGRect(x: 0, y: 0, width: 300, height: 40)

        titleView.addSubview(labelText)
        titleView.backgroundColor = .clear
        
        self.navigationItem.titleView = titleView
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "statusDisable")
        labelText.textColor = UIColor(named: "statusDisable")
    }
    
    @objc func backButtonClickedDismiss(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func settingsNavBar(title: String) {
        
//        menuIcon.tapAction = {
//            let vc = LottosViewController()
//            vc.sideMenu.menuWidth = vc.view.bounds.width - 70
//            self.present(vc.sideMenu, animated: true)
//        }
        
//        bellIcon.tapAction = {
//            self.navigationController?.pushViewController(NotificationsViewController(), animated: true)
//        }
        
//        navigationController?.setBackground()
//
//        navigationItem.rightBarButtonItems = [bellIcon]
//        navigationItem.leftBarButtonItem = menuIcon
    }
    
    func settingsNavBarImage(number : Int? = nil) {
        let logoImage    = UIImageView(image: UIImage(named: "logo2"))
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 165, height: 40))
        
        navigationController?.setBackground()
        
        logoImage.frame = CGRect(x: 0, y: 0, width: 165, height: 40)
        logoImage.contentMode = .scaleAspectFit

        titleView.addSubview(logoImage)
        titleView.backgroundColor = .clear
        
        navigationItem.titleView = titleView
    }
}

// MARK: - Loading View
extension BaseViewController {
    func showLoading() {
        loadingVC = LoadingIndicatorViewController()
        add(loadingVC!)
        loadingVC?.view.frame = view.bounds
    }

    func showLoading(inside wiew: UIView) {
        loadingVC = LoadingIndicatorViewController()
        add(child: loadingVC!, container: wiew)
        loadingVC?.view.frame = wiew.bounds
    }

    func hideLoading() {
        loadingVC?.remove()
        loadingVC = nil
    }
}

// MARK: - Alert
extension BaseViewController {
    func displaySimpleAlert(with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}

