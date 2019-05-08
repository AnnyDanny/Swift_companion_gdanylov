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
    
    @IBOutlet weak var projectView: UITableView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
//    @IBOutlet weak var lineChartView: LineChartView!
//    @IBOutlet weak var barChartView: BarChartView!
    
    @IBOutlet weak var pieChartView: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        projectView.delegate = self
        projectView.dataSource = self
        let nib = UINib.init(nibName: "ProjectTableViewCell", bundle: nil)
        self.projectView.register(nib, forCellReuseIdentifier: "ProjectTableViewCell")
        setRes()
        addForCharts()
        
//        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
//        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0]

//        setChart(dataPoints: months, values: unitsSold)
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
    
//    if userData?.cursusUsers != nil && (userData?.cursusUsers?.count)! > 0 && (userData?.cursusUsers?[0].skills.contains(where: {$0.skillLevel > 0
//    }))! {
//    let dataPoints = userData!.cursusUsers?[0].skills.map { $0.skillName }
//    let values = userData!.cursusUsers?[0].skills.map { $0.skillLevel}
//    guard dataPoints != nil && values != nil else {
//    return
//    }
//    setChart(dataPoints: dataPoints!, values: values!)
//    }
    
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
        return (res?.projects?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectTableViewCell", for: indexPath) as! ProjectTableViewCell
        cell.nameProject.text = res?.projects?[indexPath.row].projectName.name
        cell.statusProject.text = res?.projects?[indexPath.row].status
//        cell.markProject.text = res?.projects?[indexPath.section].final_mark
        if let finalMark = res?.projects?[indexPath.row].final_mark {
            cell.markProject.text = String(describing: finalMark)
        }
        return cell
    }
    
    func setCharts(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            if values[i] == 0 {
                continue
            }
            let dataEntry = PieChartDataEntry(value: Double(round(1000 * values[i]) / 1000), label: "\(dataPoints[i]) \(values[i])", data:  "test" as AnyObject)
//            let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
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
//        for i in 0..<dataPoints.count {
//            if values[i] == 0 {
//                continue
//            }
//            let dataEntry = PieChartDataEntry(value: Double(round(1000 * values[i]) / 1000), label: "\(dataPoints[i]) \(values[i])", data:  "test" as AnyObject)
//            dataEntries.append(dataEntry)
//        }
        
        
//        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "Skills")
//        let pieChartData = PieChartData(dataSet: pieChartDataSet)

        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "User's skills")
        let pieChartData = PieChartData(dataSets: [pieChartDataSet])
        
        pieChartView.data = pieChartData
        
        pieChartDataSet.colors = colors
    }
    
//    func setChart(dataPoints: [String], values: [Double]) {
//        barChartView.noDataText = "You need to provide data for the chart."
//
//        var dataEntries: [BarChartDataEntry] = []
//        for i in 0..<dataPoints.count {
//            let dataEntry = BarChartDataEntry(x: values[i], y: values[i])
//            dataEntries.append(dataEntry)
//        }
//
//        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Units Sold")
//        let chartData = BarChartData
//        barChartView.data = chartData
//    }
    
    
    
    
    
    
    
}
