//
//  WebViewController.swift
//  Covid-19-Japan
//
//  Created by 村岡海人 on 2022/01/08.
//

import UIKit
import WebKit
import Accounts

class WebViewController: UIViewController {
    
    let link = "https://www.covid19-yamanaka.com"

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: link)
        let request = URLRequest(url: url!)
        webView.load(request)
    }
    
    @IBAction func goBackButton(_ sender: Any) {
        webView.goBack()
    }
    
    @IBAction func goFrontButton(_ sender: Any) {
        webView.goForward()
    }
    
    @IBAction func shareButton(_ sender: Any) {
        let shareWebSite = NSURL(string: link)
        let activityItems = [shareWebSite]
        
        let activityVC = UIActivityViewController(activityItems: activityItems as [Any], applicationActivities: nil)

        self.present(activityVC, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func safariButton(_ sender: Any) {
        if UIApplication.shared.canOpenURL(webView.url!){
            UIApplication.shared.open(webView.url!)
        }else{
            print("ブラウザ起動失敗")
        }
    }
    
}
