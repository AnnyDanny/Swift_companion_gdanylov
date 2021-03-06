//
//  StudentView.swift
//  swiftCompanionGdanylov
//
//  Created by Ganna DANYLOVA on 4/19/19.
//  Copyright © 2019 Ganna DANYLOVA. All rights reserved.
//

import Foundation
import UIKit
import Charts

class Student : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var res : Result?
    var months: [String]!
    var image: UIImageView!
    
    @IBOutlet weak var scroller: UIScrollView!
    
    @IBOutlet weak var projectView: UITableView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var pieChartView: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        projectView.delegate = self
        projectView.dataSource = self
        let nib = UINib.init(nibName: "ProjectTableViewCell", bundle: nil)
        self.projectView.register(nib, forCellReuseIdentifier: "ProjectTableViewCell")
        if res?.imageUrl != nil {
            setRes()
        }
        else {
            print("Error. Enter valid login")
        }
        addForCharts()
    }
    
    func addForCharts() {
        print("\n\nhello charts--->>>\n\n")
        if res?.cursus_users != nil && (res?.cursus_users?.count)! > 0 && (res?.cursus_users?[0].skills?.contains(where: {$0.levelSkill > 0 }))! {
            let dataPoint = res!.cursus_users?[0].skills?.map {$0.nameSkill}
            let values = res!.cursus_users?[0].skills?.map {$0.levelSkill}
            print("\n\ndataPoint--->>> \(dataPoint)\n\n")
            print("values-->>> \(values)\n\n")
            guard dataPoint != nil && values != nil else {
                return
            }
            setCharts(dataPoints: dataPoint!, values: values!)
        }
    }
    
    func setRes() {
        let dataImage = try? Data(contentsOf: (res?.imageUrl)!)
        if dataImage != nil {
            imageView.image = UIImage(data: (dataImage)!)
        }
        firstNameLabel.text = res?.first_name
        lastNameLabel.text = res?.last_name
        phoneLabel.text = res?.phone
        emailLabel.text = res?.email
        if let cursusUsers = res?.cursus_users, cursusUsers.count > 0 {
            if let grade = cursusUsers[0].grade {
                gradeLabel.text = grade
            }
            else {
                gradeLabel.text = "Not graded"
            }
            if let level = cursusUsers[0].level {
                levelLabel.text = "\(String(describing: level))"
            }
        }
        else {
            gradeLabel.text = "Not graded"
            levelLabel.text = "0.0."
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if res?.projects != nil {
            return (res?.projects?.count)!
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if res == nil {
            makeAlert()
            print("Error. This login is not existent")
//            cell.nameProject.text = "This student"
//            cell.statusProject.text = "has not"
//            cell.markProject.text = "projects"
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectTableViewCell", for: indexPath) as! ProjectTableViewCell
        if res?.projects?[indexPath.row].projectName.name != nil && res?.projects?[indexPath.row].status != nil {
            cell.nameProject.text = res?.projects?[indexPath.row].projectName.name
            cell.statusProject.text = res?.projects?[indexPath.row].status
        }
//        cell.markProject.text = res?.projects?[indexPath.section].final_mark
        if let finalMark = res?.projects?[indexPath.row].final_mark {
            cell.markProject.text = String(describing: finalMark)
        }
//        else {
//            makeAlert()
//            print("Error. This login is not existent")
//            cell.nameProject.text = "This student"
//            cell.statusProject.text = "has not"
//            cell.markProject.text = "projects"
//        }
        return cell
    }
    
    func makeAlert() {
        let alert = UIAlertController(title: "Error", message: "This login is not existent", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    func setCharts(dataPoints: [String], values: [Double]) {
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            if values[i] == 0 {
                continue
            }
            let dataEntry = PieChartDataEntry(value: Double(round(1000 * values[i]) / 1000), label: "\(dataPoints[i]) \(values[i])", data:  "test" as AnyObject)
            dataEntries.append(dataEntry)
        }
        
        var colors: [UIColor] = []
        
        for _ in 0..<dataPoints.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }

        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "User's skills")
        let pieChartData = PieChartData(dataSets: [pieChartDataSet])
        
        pieChartView.data = pieChartData
        
        pieChartDataSet.colors = colors
        pieChartDataSet.sliceSpace = 2
        pieChartDataSet.xValuePosition = .outsideSlice
        pieChartDataSet.entryLabelColor = UIColor.black
        
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = " %"
        pieChartData.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        pieChartDataSet.yValuePosition = .outsideSlice
        pieChartData.setValueTextColor(.black)
        pieChartData.setValueFont(.systemFont(ofSize: 9))
        setUpPieChart()
    }
    
    func setUpPieChart() {
        self.pieChartView.drawEntryLabelsEnabled = false
        pieChartView.drawHoleEnabled = false
        pieChartView.rotationAngle = 0
        pieChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
    }
}
