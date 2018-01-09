/*
 * CalendarHeaderView.swift
 * Created by Michael Michailidis on 07/04/2015.
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

class CalendarHeaderView: UIView {
    
    lazy var monthLabel : UILabel = {
        
        let lbl = UILabel()
        lbl.textAlignment = NSTextAlignment.center
        lbl.font = UIFont.systemFont(ofSize: 20)
        lbl.textColor = CalendarView.Style.HeaderTextColor
        
        self.addSubview(lbl)
        
        return lbl
    }()
    
    lazy var dayLabelContainerView : UIView = {
        
        let v = UIView()
        
        let formatter = DateFormatter()
        
        for index in 1...7 {
            
            let weekdayLabel = UILabel()
            
            weekdayLabel.font = UIFont.systemFont(ofSize: 14)
            
            weekdayLabel.text = formatter.shortWeekdaySymbols[(index % 7)].uppercased()
            weekdayLabel.textColor = CalendarView.Style.HeaderTextColor
            weekdayLabel.textAlignment = NSTextAlignment.center
            
            v.addSubview(weekdayLabel)
        }
        
        self.addSubview(v)
        
        return v
        
    }()
    
    lazy var borderView : UIView = {
        
        let v = UIView()
        
        v.backgroundColor = UIColor.lightGray
        
        self.addSubview(v)
        
        return v
        
    }()
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        var frm = self.bounds
        frm.origin.y += 5.0
        frm.size.height = 40.0
        
        self.monthLabel.frame = CGRect.zero
        
        var labelFrame = CGRect(
            x: 0.0,
            y: self.bounds.size.height / 2.0,
            width: self.bounds.size.width / 7.0,
            height: self.bounds.size.height / 2.0
        )
        
        for lbl in self.dayLabelContainerView.subviews {
            
            lbl.frame = labelFrame
            labelFrame.origin.x += labelFrame.size.width
        }
        
        borderView.frame = CGRect.init(x: 0, y: self.bounds.maxY + 4, width: self.bounds.size.width, height: 1)
        self.addSubview(borderView)
    }
    
}

