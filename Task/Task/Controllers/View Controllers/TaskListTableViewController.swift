//
//  TaskListTableViewController.swift
//  Task
//
//  Created by stanley phillips on 1/13/21.
//

import UIKit
class TaskListTableViewController: UITableViewController {
    // MARK: - Properties
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        TaskController.shared.loadFromPersistentStorage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskController.shared.tasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? TaskTableViewCell else {return UITableViewCell()}
        
        cell.delegate = self
        cell.task = TaskController.shared.tasks[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let taskToDelete = TaskController.shared.tasks[indexPath.row]
            TaskController.shared.delete(task: taskToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTaskDetailVC" {
            guard let index = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? TaskDetailViewController else {return}
            
            let taskToSend = TaskController.shared.tasks[index.row]
            destination.task = taskToSend
        }
    }
}

// MARK: - Extensions
extension TaskListTableViewController: TaskTableViewCellDelegate {
    func taskCellButtonTapped(_ sender: TaskTableViewCell) {
        guard let task = sender.task else {return}
        TaskController.shared.toggleIsComplete(task: task)
        sender.updateViews()
    }
}
