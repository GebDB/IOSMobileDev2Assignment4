//
//  NoteViewModel.swift
//  Assignment4
//
//  Created by user269971 on 3/24/25.
//



import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class NoteViewModel: ObservableObject {
    @Published var notes = [NoteModel]()
    private var db = Firestore.firestore()

    func fetchData() {
        self.notes.removeAll()
        
        guard let currentUser = UserModel.currentUser() else { return }
        
        db.collection("users").document(currentUser.id)
            .collection("notes")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        do {
                            self.notes.append(try document.data(as: NoteModel.self))
                        } catch {
                            print(error)
                        }
                    }
                }
            }
    }
    
    func saveData(note: NoteModel) {
        guard let currentUser = UserModel.currentUser() else { return }
        
        if let id = note.id {
            // Edit note
            if !note.title.isEmpty || !note.notesdata.isEmpty {
                let docRef = db.collection("users").document(currentUser.id)
                    .collection("notes").document(id)
                
                docRef.updateData([
                    "title": note.title,
                    "notesdata": note.notesdata
                ]) { err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("Document successfully updated")
                    }
                }
            }
        } else {
            if !note.title.isEmpty || !note.notesdata.isEmpty {
                var ref: DocumentReference? = nil
                ref = db.collection("users").document(currentUser.id)
                    .collection("notes")
                    .addDocument(data: [
                        "title": note.title,
                        "notesdata": note.notesdata
                    ]) { err in
                        if let err = err {
                            print("Error adding document: \(err)")
                        } else {
                            print("Document added with ID: \(ref!.documentID)")
                        }
                    }
            }
        }
    }
}
