/*
 * ViewController.swift
 * Created by Michael Michailidis on 01/04/2015.
 * http://blog.karmadust.com/
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 */

import UIKit
import EventKit

class ViewController: UIViewController, CalendarViewDataSource, CalendarViewDelegate {

    
    @IBOutlet weak var calendarView: CalendarView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        CalendarView.Style.CellShape = .Round
        CalendarView.Style.CellColorDefault = UIColor.clear
        CalendarView.Style.CellColorToday = UIColor(red:1.00, green:0.84, blue:0.64, alpha:1.00)
        CalendarView.Style.CellBorderColor = UIColor(red:1.00, green:0.63, blue:0.24, alpha:1.00)
        CalendarView.Style.CellEventColor = UIColor(red:1.00, green:0.63, blue:0.24, alpha:1.00)
        CalendarView.Style.HeaderTextColor = UIColor.white
        CalendarView.Style.CellTextColorDefault = UIColor.white
        CalendarView.Style.CellTextColorToday = UIColor(red:0.31, green:0.44, blue:0.47, alpha:1.00)
        
        calendarView.dataSource = self
        calendarView.delegate = self
        
        calendarView.direction = .horizontal
        
        calendarView.backgroundColor = UIColor(red:0.31, green:0.44, blue:0.47, alpha:1.00)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        EventsLoader.load(from: self.startDate(), to: self.endDate()) { // (events:[CalendarEvent]?) in
            if let events = $0 {
                self.calendarView.events = events
            } else {
                // notify for access not access not granted
            }
        }
        
        
        var tomorrowComponents = DateComponents()
        tomorrowComponents.day = 1
        
        let today = Date()
        
        let tomorrow = self.calendarView.calendar.date(byAdding: tomorrowComponents, to: today)!
        self.calendarView.selectDate(tomorrow)
        
        self.calendarView.setDisplayDate(today)
        self.datePicker.setDate(today, animated: false)
        
    }

    // MARK : KDCalendarDataSource
    
    func startDate() -> Date {
        
        var dateComponents = DateComponents()
        dateComponents.month = -3
        
        let today = Date()
        
        let threeMonthsAgo = self.calendarView.calendar.date(byAdding: dateComponents, to: today)!
        
        return threeMonthsAgo
    }
    
    func endDate() -> Date {
        
        var dateComponents = DateComponents()
      
        dateComponents.year = 2;
        let today = Date()
        
        let twoYearsFromNow = self.calendarView.calendar.date(byAdding: dateComponents, to: today)!
        
        return twoYearsFromNow
  
    }
    
    
    // MARK : KDCalendarDelegate
   
    func calendar(_ calendar: CalendarView, didSelectDate date : Date, withEvents events: [CalendarEvent]) {
        
        print("Did Select: \(date) with \(events.count) events")
        for event in events {
            print("\t\"\(event.title)\" - Starting at:\(event.startDate)")
        }
        
    }
    
    func calendar(_ calendar: CalendarView, didScrollToMonth date : Date) {
    
        self.datePicker.setDate(date, animated: true)
    }
    
    
    // MARK : Events
    
    @IBAction func onValueChange(_ picker : UIDatePicker) {
        self.calendarView.setDisplayDate(picker.date, animated: true)
    }
    
    @IBAction func goToPreviousMonth(_ sender: Any) {
        self.calendarView.goToPreviousMonth()
    }
    @IBAction func goToNextMonth(_ sender: Any) {
        self.calendarView.goToNextMonth()
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}





