//
//  NoteModel.swift
//  Assignment4
//
//  Created by user269971 on 3/24/25.
import Foundation
import FirebaseFirestore

struct NoteModel : Codable, Identifiable {
    @DocumentID var id: String?
    var title: String
    var notesdata: String
}


