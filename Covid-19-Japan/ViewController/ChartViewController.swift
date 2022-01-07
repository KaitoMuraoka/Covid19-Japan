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
    var segment = UISegmentedControl()
    var array: [CovidInfo.Prefecture] = []
    var chartView: HorizontalBarChartView!
    var pattern = "cases"
    
    var serchBar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        appearance()
        segmentView()
        serchBarView()
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
    
    func segmentView(){
        segment = UISegmentedControl(items: ["感染者数", "PCR数", "死者数"])
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
            pattern = "cases"
            print("感染者数")
        case 1:
            pattern = "pcr"
            print("PCR数")
        case 2:
            pattern = "deaths"
            print("死者数")
        default:
            break
        }
        loadView()
        viewDidLoad()
    }
    
    //MARK: -serchBar
    func serchBarView(){
        
        serchBar.frame = CGRect(x: 10, y: 130, width: view.frame.size.width - 20, height: 40)
        serchBar.delegate = self
        serchBar.placeholder = "都道府県を漢字で入力"
        serchBar.showsCancelButton = true
        serchBar.tintColor = .blue
        view.addSubview(serchBar)
        view.backgroundColor = .systemGroupedBackground
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        if let index = array.firstIndex(where: {$0.name_ja == searchBar.text}){
            prefecture.text = "\(array[index].name_ja)"
            pcrCount.text = "\(array[index].pcr)"
            casesCount.text = "\(array[index].cases)"
            deathsCount.text = "\(array[index].deaths)"
        }
        print("検索ボタンが押されました")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        serchBar.text = ""
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
        
        //データをソート
        array = CovidSingleton.shared.prefecture
        array.sort(by: {
            a, b -> Bool in
            
            if pattern == "pcr" {
                return a.pcr > b.pcr
            }else if pattern == "deaths" {
                return a.deaths > b.deaths
            }else{
                return a.cases > b.cases
            }
        })
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
        var entrys: [BarChartDataEntry] = []
        for i in 0...9 {
            if pattern == "cases" {
                segment.selectedSegmentIndex = 0
                entrys += [BarChartDataEntry(x: Double(i), y: Double(self.array[i].cases))]
            }else if pattern == "pcr"{
                segment.selectedSegmentIndex = 1
                entrys += [BarChartDataEntry(x: Double(i), y: Double(self.array[i].pcr))]
            }else if pattern == "deaths"{
                segment.selectedSegmentIndex = 2
                entrys += [BarChartDataEntry(x: Double(i), y: Double(self.array[i].deaths))]
            }
        }
        let set = BarChartDataSet(entries: entrys, label: "県別状況")
        set.colors = [.blue]
        set.valueTextColor = UIColor.init(cgColor: CGColor(red: 112/255, green: 117/255, blue: 248/255, alpha: 1.0))
        set.highlightColor = .white
        chartView.data = BarChartData(dataSet: set)
        view.addSubview(chartView)
    }
    
    
}

//MARK: ChartViewDelegate
extension ChartViewController: ChartViewDelegate{
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        if let dataSet = chartView.data?.dataSets[highlight.dataSetIndex] {
            let index = dataSet.entryIndex(entry: entry)
            prefecture.text = "\(array[index].name_ja)"
            pcrCount.text = "\(array[index].pcr)"
            casesCount.text = "\(array[index].cases)"
            deaths.text = "\(array[index].deaths)"
        }
    }
}
