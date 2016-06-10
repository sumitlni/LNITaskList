//
//  ViewController.swift
//  LNITaskListDemo
//
//  Created by Sumit Chawla on 6/9/16.
//
//    The MIT License (MIT)
//
//    Copyright © 2016 Loud Noise Inc.
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//    SOFTWARE.

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var switch1: UISwitch!
    @IBOutlet weak var switch2: UISwitch!
    @IBOutlet weak var switch3: UISwitch!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.textView.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func log(text:String) {
        let newText = "\(self.textView.text)\n\(text)"
        self.textView.text = newText
    }
    
    func asyncTaskWithAnswer(name:String, taskList:LNITaskList, answer:Bool) {
        dispatch_async(dispatch_get_main_queue()) {
            self.log("Now executing \(name) with answer = \(answer)")
            taskList.markDone(answer)
        }
    }

    @IBAction func startTasks(sender: AnyObject) {
        textView.text = ""
        
        // Form the task list
        let taskList = LNITaskList()
        taskList.onSuccess { () in
            self.log("Success!")
        }.onFailure { () in
            self.log("Failed!")
        }.addStep { () in
            self.asyncTaskWithAnswer("Task 1", taskList: taskList, answer: self.switch1.on)
            }.addStep { () in
                self.asyncTaskWithAnswer("Task 2", taskList: taskList, answer: self.switch2.on)
            }.addStep { () in
                self.asyncTaskWithAnswer("Task 3", taskList: taskList, answer: self.switch3.on)
        }.start()
        
    }

}

