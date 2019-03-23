//
//  ViewController.swift
//  todoList
//
//  Created by Igor Chernyshov on 23/03/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

import UIKit

class ToDoListViewController: UIViewController {

  // MARK: Outlets
  
  @IBOutlet weak var tableView: UITableView!
  
  // MARK: Variables
  
  var task = Task(name: "", subtasks: [])
  
  // MARK: ViewControllers methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    tableView.reloadData()
  }
  
  // MARK: Buttons methods
  
  @IBAction func addTaskButtonWasPressed(_ sender: Any) {
    displayNameInputAlertController()
  }
  
  func displayNameInputAlertController() {
    let alertController = UIAlertController(title: "Add new task", message: nil, preferredStyle: .alert)
    alertController.addTextField {(_ textField: UITextField) -> Void in
    }
    
    let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
      guard let taskName = alertController.textFields?[0].text, taskName != "" else { return }
      let newTask = Task(name: taskName, subtasks: [])
      self?.task.subtasks?.append(newTask)
      self?.tableView.reloadData()
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
    
    alertController.addAction(addAction)
    alertController.addAction(cancelAction)
    present(alertController, animated: true, completion: nil)
  }
  
}

// MARK: TableView Delegate

extension ToDoListViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return task.subtasks?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "toDoListCell") else { return UITableViewCell() }
    cell.textLabel?.text = task.subtasks?[indexPath.row].name
    cell.detailTextLabel?.text = "Has \(task.subtasks?[indexPath.row].subtasks?.count ?? 0) subtasks"
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let subtaskVC = storyboard?.instantiateViewController(withIdentifier: "ToDoListViewController") as? ToDoListViewController,
      let selectedTask = task.subtasks?[indexPath.row]
      else { return }
    
    subtaskVC.title = selectedTask.name
    subtaskVC.task = selectedTask
    navigationController?.pushViewController(subtaskVC, animated: true)
  }
  
}
