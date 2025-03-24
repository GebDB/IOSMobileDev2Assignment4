//
//  ContentView.swift
//  Assignment4
//
//  Created by user269971 on 3/24/25.
//


import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
        Group {
            if viewModel.authenticationState == .authenticated {
                NotesListView()
            } else {
                LoginView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthViewModel())
    }
}
