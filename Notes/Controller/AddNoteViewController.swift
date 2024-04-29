//
//  AddNoteViewController.swift
//  Notes
//
//  Created by Rodrigo on 28/04/24.
//

import Foundation
import UIKit

class AddNoteViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var newNote : Note?
    
    @IBOutlet weak var noteTitle: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var noteBody: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if newNote == nil{
            noteTitle.text = ""
            noteBody.text = ""
            newNote = Note(context: context)
        }
        else{
            noteTitle.text = newNote?.title
            noteBody.text = newNote?.body
        }
        // Do any additional setup after loading the view.
    }
    

    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        
        let isModal = self.presentingViewController is UINavigationController
        print("isModal: ", isModal)
        if isModal{
            self.dismiss(animated: true)
        }
        else{
            navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //newNote = Note(title: noteTitle.text ?? "", content: noteContent.text, date: Date())
        let destination = segue.destination as! NotesViewController
        newNote?.title = noteTitle.text
        newNote?.body = noteBody.text
        
        destination.note = newNote
    }
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        //Validate note info
        if(noteTitle.text!.isEmpty || noteBody.text!.isEmpty){
            self.show(warning: "Title or body is empty")
            return false
        }
        else
        {
            print("Dr Jr")
            return true
        }
    }
}
