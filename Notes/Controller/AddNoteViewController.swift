//
//  AddNoteViewController.swift
//  Notes
//
//  Created by Rodrigo on 28/04/24.
//

import Foundation
import UIKit

class AddNoteViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var newNote : Note?
    var newNoteJSON : NoteJSON?
    
    var pickerData: [String] = [String]()
    
    @IBOutlet weak var noteTitle: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var noteBody: UITextView!
    @IBOutlet weak var noteDate: UIDatePicker!
    
    @IBOutlet weak var notePriority: UIPickerView!
    var isEditOp : Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerData = ["Baja","Media","Alta"]

        if newNoteJSON == nil{
            isEditOp = false
            noteTitle.text = ""
            noteBody.text = ""
            newNoteJSON = NoteJSON(id: UUID.init(), title: "", body: "", date: Date.init(), priority: "")
        }
        else{
            isEditOp = true
            noteTitle.text = newNoteJSON?.title
            noteBody.text = newNoteJSON?.body
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
        
        newNoteJSON?.title = noteTitle.text ?? ""
        newNoteJSON?.body = noteBody.text ?? ""
        newNoteJSON?.date = noteDate.date
        destination.noteJSON = newNoteJSON
        destination.isEdit = isEditOp
        
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
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
            return 1
        }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return pickerData.count
        }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           return pickerData[row]
       }
     
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
           newNoteJSON?.priority = pickerData[row]
       }
}
