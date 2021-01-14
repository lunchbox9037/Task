//
//  TaskDetailViewController.swift
//  Task
//
//  Created by stanley phillips on 1/13/21.
//

import UIKit

class TaskDetailViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskNotesTextView: UITextView!
    @IBOutlet weak var taskDueDatePicker: UIDatePicker!
    
    // MARK: - Properties
    var task: Task?
    var date: Date?
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        taskNotesTextView.layer.borderWidth = 0.5
        taskNotesTextView.layer.borderColor = UIColor.systemFill.cgColor
        taskNotesTextView.layer.cornerRadius = 8
        updateViews()
    }
    
    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = taskNameTextField.text, !name.isEmpty else {return}
        //these values are not required to create a task
        let notes = taskNotesTextView.text
        
        if let taskToUpdate = task {
            //update the task if one was sent over from the list view
            TaskController.shared.update(task: taskToUpdate, name: name, notes: notes, dueDate: date)
        } else {
            TaskController.shared.createTaskWith(name: name, notes: notes, dueDate: date)
        }
    
        //returns back to the tableview controller
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func dueDatePickerDateChanged(_ sender: Any) {
        date = taskDueDatePicker.date
    }
    
    // MARK: - Functions
    func updateViews() {
        guard let taskDetails = task else {return}
        taskNameTextField.text = taskDetails.name
        taskNotesTextView.text = taskDetails.notes
        //unwrap the date
        guard let dueDate = taskDetails.dueDate else {return}
        taskDueDatePicker.date = dueDate
    }
}
