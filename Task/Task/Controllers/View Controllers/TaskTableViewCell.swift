//
//  TaskTableViewCell.swift
//  Task
//
//  Created by stanley phillips on 1/13/21.
//

import UIKit

protocol TaskTableViewCellDelegate: AnyObject {
    func taskCellButtonTapped(_ sender: TaskTableViewCell)
}

class TaskTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var completionButton: UIButton!
    
    // MARK: - Properties
    var task: Task? {
        didSet {
            updateViews()
        }
    }
    
    weak var delegate: TaskTableViewCellDelegate?

    // MARK: - Lifecycle
    
    
    // MARK: - Actions
    @IBAction func completionButtonTapped(_ sender: Any) {
        if let delegate = delegate {
            delegate.taskCellButtonTapped(self)
        }
    }
    
    // MARK: - Functions
    func updateViews() {
        //update the button image
        guard let taskDetails = task else {return}
        taskNameLabel.text = taskDetails.name
        if taskDetails.isComplete {
            completionButton.setBackgroundImage(UIImage(named: "complete") , for: .normal)
        } else {
            completionButton.setBackgroundImage(UIImage(named: "incomplete") , for: .normal)
        }
    }
}
