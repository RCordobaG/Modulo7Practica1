//
//  AddNoteViewController.swift
//  Notes
//
//  Created by Rodrigo on 28/04/24.
//

import Foundation
import UIKit

class EditNoteViewController: UITableViewController {
    
    var newNote : Note?
    @IBOutlet weak var noteTitle: UITextField!
    @IBOutlet weak var noteContent: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //newNote = Note(title: noteTitle.text ?? "", content: noteContent.text, date: Date())
        let destination = segue.destination as! NotesViewController
        destination.note = newNote
    }
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        //Validate note info
        return true
    }
}
