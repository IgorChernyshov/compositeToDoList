//
//  Task.swift
//  todoList
//
//  Created by Igor Chernyshov on 23/03/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

import Foundation

class Task {
  
  var name: String?
  var subtasks: [Task]?
  
  init(name: String?, subtasks: [Task]?) {
    self.name = name
    self.subtasks = subtasks
  }
  
}
