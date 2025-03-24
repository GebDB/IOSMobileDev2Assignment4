//
//  NoteListView.swift
//  Assignment4
//
//  Created by user269971 on 3/24/25.
//

import SwiftUI

struct NotesListView: View {
    @ObservedObject var noteApp = NoteViewModel()
    @State var note = NoteModel(title: "", notesdata: "")
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach($noteApp.notes) { $note in
                        NavigationLink {
                            NoteDetail(note: $note)
                        } label: {
                            Text(note.title)
                        }
                    }
                    Section {
                        NavigationLink {
                            NoteDetail(note: $note)
                        } label: {
                            Text("New note")
                                .foregroundColor(Color.gray)
                                .font(.system(size: 15))
                        }
                    }
                }
                .onAppear {
                    noteApp.fetchData()
                }
                .refreshable {
                    noteApp.fetchData()
                }

                // Logout Button
                Button(action: {
                    viewModel.signOut()
                }) {
                    Text("Logout")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(8)
                }
                .padding()
            }
        }
    }
}

