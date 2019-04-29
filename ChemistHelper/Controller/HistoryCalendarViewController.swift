//
//  HistoryCalendarViewController.swift
//  ChemistHelper
//
//  Created by MATTEW MA on 29/4/19.
//  Copyright © 2019 Mathhew MA. All rights reserved.
//

import UIKit
import JTAppleCalendar

class HistoryCalendarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension HistoryCalendarViewController: JTAppleCalendarViewDataSource {
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        print("DataSource run")
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        
        let startDate = formatter.date(from: "2018 01 01")!
        let endDate = Date()
        return ConfigurationParameters(startDate: startDate, endDate: endDate)
    }
}

extension HistoryCalendarViewController: JTAppleCalendarViewDelegate {
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        print("Delegate1 run")
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "dateCell", for: indexPath) as! DateCell
        cell.dateLabel.text = cellState.text
        return cell
    }
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        print("Delegate2 run")
        let cell = cell as! DateCell
        cell.dateLabel.text = cellState.text
    }
}
