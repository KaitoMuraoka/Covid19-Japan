//
//  HealthCheckViewController.swift
//  Covid-19-Japan
//
//  Created by 村岡海人 on 2021/12/30.
//

import UIKit
import FSCalendar
import CalculateCalendarLogic

class HealthCheckViewController: UIViewController {
    
    let scrollView = UIScrollView()
    var point = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView(scrollView)
        calendar()
        checkLabel()
        
        
        //uiView
        let uiView1 = createView(y: 380)
        scrollView.addSubview(uiView1)
        createImage(parentView: uiView1, imageName: "check1")
        createLabel(parentView: uiView1, text: "37.5度以上の熱がある")
        createUISwitch(parentView: uiView1, action: #selector(switchAction))
        
        let uiView2 = createView(y: 465)
        scrollView.addSubview(uiView2)
        createImage(parentView: uiView2, imageName: "check2")
        createLabel(parentView: uiView2, text: "のどの痛みがある")
        createUISwitch(parentView: uiView2, action: #selector(switchAction))
        
        let uiView3 = createView(y: 550)
        scrollView.addSubview(uiView3)
        createImage(parentView: uiView3, imageName: "check3")
        createLabel(parentView: uiView3, text: "匂いを感じない")
        createUISwitch(parentView: uiView3, action: #selector(switchAction))
        
        let uiView4 = createView(y: 635)
        scrollView.addSubview(uiView4)
        createImage(parentView: uiView4, imageName: "check4")
        createLabel(parentView: uiView4, text: "味を感じない")
        createUISwitch(parentView: uiView4, action: #selector(switchAction))
        
        let uiView5 = createView(y: 720)
        scrollView.addSubview(uiView5)
        createImage(parentView: uiView5, imageName: "check5")
        createLabel(parentView: uiView5, text: "倦怠感がある")
        createUISwitch(parentView: uiView5, action: #selector(switchAction))
        
        resultButton()
    }
    
    func scrollView(_ scrollView: UIScrollView){
        
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height
        )
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: 1000)
        view.addSubview(scrollView)
    }
    
    //カレンダー
    func calendar(){
        let calendar = FSCalendar()
        calendar.frame = CGRect(x: 20, y: 10, width: view.frame.size.width - 40, height: 300)
        scrollView.addSubview(calendar)
        
        calendar.delegate = self
    }
    
    func checkLabel(){
        let checkLabel = UILabel()
        checkLabel.text = "健康チェック"
        checkLabel.textColor = .white
        checkLabel.frame = CGRect(x: 0, y: 340, width: view.frame.size.width, height: 21)
        checkLabel.backgroundColor = #colorLiteral(red: 0.4781777263, green: 0.5065305829, blue: 0.9997205138, alpha: 1)
        checkLabel.textAlignment = .center
        checkLabel.center.x = view.center.x
        scrollView.addSubview(checkLabel)
    }
    
    
    //診断リスト
    func createView(y: CGFloat) -> UIView{
        let uiView = UIView()
        uiView.frame = CGRect(x: 20, y: y, width: view.frame.size.width - 40, height: 70)
        uiView.backgroundColor = .white
        uiView.layer.cornerRadius = 20
        uiView.layer.shadowColor = UIColor.black.cgColor
        uiView.layer.shadowOpacity = 0.3
        uiView.layer.shadowRadius = 4
        uiView.layer.shadowOffset = CGSize(width: 0, height: 2)
        return uiView
    }
    
    func createLabel(parentView: UIView, text: String){
        let label = UILabel()
        label.text = text
        label.frame = CGRect(x: 60, y: 15, width: 200, height: 40)
        parentView.addSubview(label)
    }
    
    func createImage(parentView: UIView, imageName: String){
        let imageView = UIImageView()
        imageView.image = UIImage(named: imageName)
        imageView.frame = CGRect(x: 10, y: 12, width: 40, height: 40)
        parentView.addSubview(imageView)
    }
    
    //スイッチ
    @objc func switchAction(sender: UISwitch){
        if sender.isOn{
            point += 1
        }else{
            point -= 1
        }
        print("point:\(point)")
    }
    
    func createUISwitch(parentView: UIView, action: Selector){
        let uiSwitch = UISwitch()
        uiSwitch.frame = CGRect(x: parentView.frame.size.width - 70, y: 20, width: 50, height: 30)
        uiSwitch.addTarget(self, action: action, for: .valueChanged)
        parentView.addSubview(uiSwitch)
    }
    
    //診断完了ボタン
    func resultButton(){
        let resultButton = UIButton(type: .system)
        resultButton.frame = CGRect(x: 0, y: 820, width: 200, height: 40)
        resultButton.center.x = scrollView.center.x
        resultButton.titleLabel?.font = .systemFont(ofSize: 20)
        resultButton.layer.cornerRadius = 5
        resultButton.setTitle("診断完了", for: .normal)
        resultButton.setTitleColor(.white, for: .normal)
        resultButton.backgroundColor = #colorLiteral(red: 0.4781777263, green: 0.5065305829, blue: 0.9997205138, alpha: 1)
        resultButton.addTarget(self, action: #selector(resultButtonAction), for: [.touchUpInside, .touchUpOutside])
        scrollView.addSubview(resultButton)
    }
    @objc func resultButtonAction(){
        //アラート
        let alert = UIAlertController(title: "診断を完了しますか？", message: "診断は1日1回までです", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "完了", style: .default, handler: { action in
            var resultTitle = ""
            var resultMessage = ""
            
            if self.point >= 4{
                resultTitle = "高"
                resultMessage = "感染している可能性が比較的高いです"
            }else if self.point >= 2{
                resultTitle = "中"
                resultMessage = "感染している可能性があります"
            }else{
                resultTitle = "低"
                resultMessage = "感染している可能性は低いです"
            }
            let alert = UIAlertController(title: "感染している可能性:\(resultTitle)", message: resultMessage, preferredStyle: .alert)
            self.present(alert, animated: true, completion: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    self.dismiss(animated: true, completion: nil)
                }
            })
        })
        let noAction = UIAlertAction(title: "キャンセル", style: .default, handler: nil)
        alert.addAction(yesAction)
        alert.addAction(noAction)
        present(alert, animated: true, completion: nil)
        
        print("resultButton tapped")
    }
    

}

extension HealthCheckViewController: FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance{
    
    //delegateで紐づけた関数
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        return .clear
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderDefaultColorFor date: Date) -> UIColor? {
        if dateFormatter(day: date) == dateFormatter(day: Date()) {
            return .purple
        }
        return .clear
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderRadiusFor date: Date) -> CGFloat {
        return 0.5
    }
    
    //ロジックのための自作関数
    func dateFormatter(day: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: day)
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        //weekend
        if judgeWeekday(date) == 1{
            return UIColor(red: 150/255, green: 30/255, blue: 0/255, alpha: 0.9)
        }else if judgeWeekday(date) == 7{
            return UIColor(red: 0/255, green: 30/255, blue: 150/255, alpha: 0.9)
        }
        //Holiday
        if judgeHoliday(date) {
            return UIColor(red: 150/255, green: 30/255, blue: 0/255, alpha: 0.9)
        }
        return .black
    }
    
    //曜日判定
    func judgeWeekday(_ date: Date) -> Int{
        let calendar = Calendar(identifier: .gregorian)
        return calendar.component(.weekday, from: date)
    }
    
    //祝日判定
    func judgeHoliday(_ date: Date) -> Bool{
        let calendear = Calendar(identifier: .gregorian)
        let year = calendear.component(.year, from: date)
        let month = calendear.component(.month, from: date)
        let day = calendear.component(.day, from: date)
        let holiday = CalculateCalendarLogic()
        let judgeHoliday = holiday.judgeJapaneseHoliday(year: year, month: month, day: day)
        return judgeHoliday
    }
}
