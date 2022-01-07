//
//  ChartViewController.swift
//  Covid-19-Japan
//
//  Created by 村岡海人 on 2022/01/03.
//

import UIKit
import Charts

class ChartViewController: UIViewController, UISearchBarDelegate {
    
    var prefecture = UILabel()
    var pcr = UILabel()
    var pcrCount = UILabel()
    var cases = UILabel()
    var casesCount = UILabel()
    var deaths = UILabel()
    var deathsCount = UILabel()
    
    //charts
    var array: [CovidInfo.Prefecture] = []
    var chartView: HorizontalBarChartView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        appearance()
        segment()
        serchBar()
        grafView()
        
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

        bottomLabel(uiView, prefecture, 1, 10, text: "東京", size: 30, .ultraLight, color: .black)
        bottomLabel(uiView, pcr, 0.39, 50, text: "PCR検査数", size: 15, .bold, color: UIColor.init(cgColor: CGColor(red: 112/255, green: 117/255, blue: 248/255, alpha: 1.0)))
        bottomLabel(uiView, pcrCount, 0.39, 85, text: "22222222", size: 30, .bold, color: .blue)
        bottomLabel(uiView, cases, 1, 50, text: "感染者数", size: 15, .bold, color: UIColor.init(cgColor: CGColor(red: 112/255, green: 117/255, blue: 248/255, alpha: 1.0)))
        bottomLabel(uiView, casesCount, 1, 85, text: "2222222", size: 30, .bold, color: .blue)
        bottomLabel(uiView, deaths, 1.61, 50, text: "死者数", size: 15, .bold, color: UIColor.init(cgColor: CGColor(red: 112/255, green: 117/255, blue: 248/255, alpha: 1.0)))
        bottomLabel(uiView, deathsCount, 1.61, 85, text: "22222", size: 30, .bold, color: .blue)
        view.backgroundColor = .systemGroupedBackground
        
        for i in 0..<CovidSingleton.shared.prefecture.count {
            if CovidSingleton.shared.prefecture[i].name_ja == "東京" {
                prefecture.text = CovidSingleton.shared.prefecture[i].name_ja
                pcrCount.text = "\(CovidSingleton.shared.prefecture[i].pcr)"
                casesCount.text = "\(CovidSingleton.shared.prefecture[i].cases)"
                deathsCount.text = "\(CovidSingleton.shared.prefecture[i].deaths)"
            }
        }
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
    func bottomLabel(_ parentView: UIView,_ label: UILabel, _ x: CGFloat, _ y: CGFloat, text: String, size: CGFloat, _ weight: UIFont.Weight, color: UIColor){

        label.text = text
        label.textColor = color
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: size, weight: weight)
        label.frame = CGRect(x: 0, y: y, width: parentView.frame.size.width / 3.5, height: 50)
        label.center.x = view.center.x * x - 10
        parentView.addSubview(label)
    }
    
    //MARK: -グラフ
    func grafView(){
        chartView = HorizontalBarChartView(frame: CGRect(x: 0, y: 180, width: view.frame.size.width, height: 350))
        chartView.animate(yAxisDuration: 1.0, easingOption: .easeOutCirc)
        chartView.xAxis.labelCount = 10
        chartView.xAxis.labelTextColor = UIColor.init(cgColor: CGColor(red: 112/255, green: 117/255, blue: 248/255, alpha: 1.0))
        chartView.doubleTapToZoomEnabled = false
        chartView.delegate = self
        chartView.pinchZoomEnabled = false
        chartView.leftAxis.labelTextColor = UIColor.init(cgColor: CGColor(red: 112/255, green: 117/255, blue: 248/255, alpha: 1.0))
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.legend.enabled = false
        chartView.rightAxis.enabled = false
        
        array = CovidSingleton.shared.prefecture
        dataSet()
    }
    
    func dataSet(){
        //縦軸名
        var names: [String] = []
        for i in 0...9 {
            names += ["\(self.array[i].name_ja)"]
        }
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: names)
        
        //データの値
        var entries: [BarChartDataEntry] = []
        for i in 0...9 {
            entries += [BarChartDataEntry(x: Double(i), y: Double(array[i].cases))]
        }
        let set = BarChartDataSet(entries: entries, label: "県別状況")
        set.colors = [.blue]
        set.valueTextColor = UIColor.init(cgColor: CGColor(red: 112/255, green: 117/255, blue: 248/255, alpha: 1.0))
        set.highlightColor = .white
        chartView.data = BarChartData(dataSet: set)
        view.addSubview(chartView)
    }
    
    
}

//MARK: ChartViewDelegate
extension ChartViewController: ChartViewDelegate{
    
}
