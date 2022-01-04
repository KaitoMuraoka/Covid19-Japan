//
//  ChartViewController.swift
//  Covid-19-Japan
//
//  Created by 村岡海人 on 2022/01/03.
//

import UIKit

class ChartViewController: UIViewController, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        appearance()
        segment()
        serchBar()
        
        //uiView
        let uiView = UIView()
        uiView.frame = CGRect(x: 10, y: 560, width: view.frame.size.width - 20, height: 167)
        uiView.layer.cornerRadius = 10
        uiView.backgroundColor = .white
        uiView.layer.shadowColor = UIColor.black.cgColor
        uiView.layer.shadowOffset = CGSize(width: 0, height: 2)
        uiView.layer.shadowOpacity = 0.4
        uiView.layer.shadowRadius = 10
        view.addSubview(uiView)

        bottomLabel(uiView, 1, 10, text: "東京", size: 30, .ultraLight, color: .black)
        bottomLabel(uiView, 0.39, 50, text: "PCR検査数", size: 15, .bold, color: UIColor.init(cgColor: CGColor(red: 112/255, green: 117/255, blue: 248/255, alpha: 1.0)))
        bottomLabel(uiView, 0.39, 85, text: "22222222", size: 30, .bold, color: .blue)
        bottomLabel(uiView, 1, 50, text: "感染者数", size: 15, .bold, color: UIColor.init(cgColor: CGColor(red: 112/255, green: 117/255, blue: 248/255, alpha: 1.0)))
        bottomLabel(uiView, 1, 85, text: "2222222", size: 30, .bold, color: .blue)
        bottomLabel(uiView, 1.61, 50, text: "死者数", size: 15, .bold, color: UIColor.init(cgColor: CGColor(red: 112/255, green: 117/255, blue: 248/255, alpha: 1.0)))
        bottomLabel(uiView, 1.61, 85, text: "22222", size: 30, .bold, color: .blue)
        view.backgroundColor = .systemGroupedBackground
    }
    
    private func appearance(){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.init(cgColor: CGColor(red: 112/255, green: 117/255, blue: 248/255, alpha: 1.0))
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    func segment(){
        let segment = UISegmentedControl(items: ["感染者数", "PCR数", "死者数"])
        segment.frame = CGRect(x: 10, y: 90, width: view.frame.size.width - 20, height: 40)
        segment.selectedSegmentTintColor = .blue
        segment.selectedSegmentIndex = 0
        segment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        segment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: CGColor(red: 112/255, green: 117/255, blue: 248/255, alpha: 1.0)], for: .normal)
        segment.addTarget(self, action: #selector(switchAction), for: .valueChanged)
        view.addSubview(segment)
    }
    
    @objc func switchAction(sender: UISegmentedControl){
        switch sender.selectedSegmentIndex {
        case 0:
            print("感染者数")
        case 1:
            print("PCR数")
        case 2:
            print("死者数")
        default:
            break
        }
    }
    
    //MARK: -serchBar
    func serchBar(){
        let serchBar = UISearchBar()
        serchBar.frame = CGRect(x: 10, y: 130, width: view.frame.size.width - 20, height: 40)
        serchBar.delegate = self
        serchBar.placeholder = "都道府県を感じで入力"
        serchBar.showsCancelButton = true
        serchBar.tintColor = .blue
        view.addSubview(serchBar)
        view.backgroundColor = .systemGroupedBackground
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("検索ボタンが押されました")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("検索ボタンのキャンセルが押されました")
    }
    
    //MARK: -都道府県ごとの診断
    func bottomLabel(_ parentView: UIView, _ x: CGFloat, _ y: CGFloat, text: String, size: CGFloat, _ weight: UIFont.Weight, color: UIColor){

        let label = UILabel()
        label.text = text
        label.textColor = color
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: size, weight: weight)
        label.frame = CGRect(x: 0, y: y, width: parentView.frame.size.width / 3.5, height: 50)
        label.center.x = view.center.x * x - 10
        parentView.addSubview(label)
    }
    

    
    
    
}
