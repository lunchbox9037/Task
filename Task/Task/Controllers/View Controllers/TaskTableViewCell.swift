//
//  TaskTableViewCell.swift
//  Task
//
//  Created by stanley phillips on 1/13/21.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var completionButton: UIButton!
    
    // MARK: - Properties
    var task: Task? {
        didSet {
            
        }
    }

    // MARK: - Lifecycle
    
    
    // MARK: - Actions
    @IBAction func completionButtonTapped(_ sender: Any) {
        delegate?
    }
    
    // MARK: - Functions
    func updateViews() {
        guard let taskDetails = task else {return}
        
        taskNameLabel.text = taskDetails.name
         
        if taskDetails.isComplete {
            completionButton.setBackgroundImage(UIImage(named: "complete") , for: .normal)
        } else {
            completionButton.setBackgroundImage(UIImage(named: "incomplete") , for: .normal)
        }
    }
}
