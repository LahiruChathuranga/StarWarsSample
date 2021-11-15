//
//  BaseVC.swift
//  StarWarsSample
//
//  Created by Lahiru Chathuranga on 2021-11-14.
//

import UIKit
import PullToRefreshKit

class BaseVC: UIViewController, UIScrollViewDelegate, LoadingIndicatorDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func configureLoadMoreFooter() -> DefaultRefreshFooter {
        let footer = DefaultRefreshFooter.footer()
        footer.setText("", mode: .pullToRefresh)
        footer.setText("", mode: .noMoreData)
        footer.setText("Load more...", mode: .refreshing)
        footer.setText("Tap to load more", mode: .tapToRefresh)
        footer.tintColor = .gray
        footer.textLabel.textColor  = .black
        footer.refreshMode = .scroll
        
        return footer
    }
    
    func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
    
    func getPageFromURL(urlString: String?) -> String? {
        if urlString != nil {
            guard let pageComponent = urlString?.split(separator: "?")[1] else {return nil}
            let pageNumber = pageComponent.split(separator: "=")[1]
            return String(pageNumber)
        } else {
            return nil
        }
        
    }

}
