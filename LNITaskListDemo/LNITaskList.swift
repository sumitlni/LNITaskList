//
//  LNITaskList.swift
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


import Foundation

class LNITaskList {
    typealias taskFunc = (Void)->Void
    
    var failed = false
    
    var failureFunc:taskFunc = {}
    var successFunc:taskFunc = {}
    
    var taskList = [taskFunc]()
    
    func onSuccess(doneFunc:taskFunc)->LNITaskList {
        successFunc = doneFunc
        return self
    }
    
    func onFailure(doneFunc:taskFunc)->LNITaskList {
        failureFunc = doneFunc
        return self
    }
    
    func addStep(doneFunc:taskFunc)->LNITaskList {
        taskList.append(doneFunc)
        return self
    }
    
    func start() {
        let firstTask = taskList.removeFirst()
        
        firstTask()
    }
    
    func markDone(success:Bool) {
        if !success {
            failureFunc()
            return
        }
        if taskList.isEmpty {
            successFunc()
            return
        }
        let nextTask = taskList.removeFirst()
        nextTask()
    }
}
