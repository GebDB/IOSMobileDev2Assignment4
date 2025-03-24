//
//  LoginView.swift
//  Assignment4
//
//  Created by user269971 on 3/24/25.
//

import SwiftUI
import Combine
import FirebaseAnalytics

private enum FocusableField: Hashable {
  case email
  case password
}

struct LoginView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss

    @State private var isAuthenticated = false
    @FocusState private var focus: FocusableField?

    private func signInWithEmailPassword() {
        Task {
            if await viewModel.signInWithEmailPassword() {
                isAuthenticated = true
            }
        }
    }

    private func signUpWithEmailPassword() {
        Task {
            if await viewModel.signUpWithEmailPassword() {
                isAuthenticated = true
            }
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                TextField("Email", text: $viewModel.email)
                    .focused($focus, equals: .email)
                    .padding()

                SecureField("Password", text: $viewModel.password)
                    .focused($focus, equals: .password)
                    .padding()

                if viewModel.flow == .signUp {
                    SecureField("Confirm Password", text: $viewModel.confirmPassword)
                        .padding()
                }

                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                }
                
                Button(action: {
                    if viewModel.flow == .login {
                        signInWithEmailPassword()
                    } else {
                        signUpWithEmailPassword()
                    }
                })
                {
                    Text(viewModel.flow == .login ? "Login" : "Sign Up")
                        .padding()
                        .background(viewModel.authenticationState == .authenticating ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .disabled(!viewModel.isValid || viewModel.authenticationState == .authenticating)
                }

                Button(action: { viewModel.switchFlow() }) {
                    Text(viewModel.flow == .login ? "Sign up" : "Login")
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                        .padding(.top, 12)
                }

            }
            .padding()
            .navigationBarTitle(viewModel.flow == .login ? "Login" : "Sign Up")
            .navigationDestination(isPresented: $isAuthenticated) {
                ContentView()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthViewModel())
    }
}
