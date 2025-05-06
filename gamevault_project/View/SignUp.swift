//
//  SignUp.swift
//  gamevault_project
//
//  Created by Tran Ba Minh Huy on 2025-03-07.
//

import SwiftUI
import FirebaseAuth

struct SignUp: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    private let firestoreService = FirebaseServices()
    @State private var nav = false
    @State private var nav2 = false
    
    var body: some View {
        VStack {
            VStack (alignment: .leading, spacing: 20){
                Text("Sign Up")
                    .font(.largeTitle)
                    .bold()
                    .fontDesign(.monospaced)
                    .padding(.bottom)
                
                TextField("Enter your username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                SecureField("Enter your password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Enter your email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom, 20)
                    .onChange (of: email){
                       email = email.lowercased()
                    }
            }
            
            Button (action: {
                if(!username.isEmpty && !password.isEmpty && !email.isEmpty) {
                    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                        if let error = error {
                            print("Error signing up: \(error.localizedDescription)")
                            return
                        }
                        guard let uid = authResult?.user.uid else { return }
                        
                        firestoreService.addUser(uid, username, email)
                        nav2 = true
                    }
                }
            }){
                RoundedRectangle(cornerRadius: 25)
                    .foregroundStyle(.black)
                    .frame(width: 350, height: 45)
                    .padding()
                    .overlay {
                        HStack (alignment: .center){
                            Text("Sign Up")
                                .foregroundStyle(.white)
                                .font(.title2)
                                .fontDesign(.monospaced)
                        }
                    }
            }
            .fullScreenCover(isPresented: $nav2) {
                LogInView()
            }
            
            HStack {
                Text("Already have an account?")
                    .fontDesign(.monospaced)
                    .font(.subheadline)
                    .bold()
                
                Button (action : {
                    nav = true
                }) {
                    Text("Log In")
                        .font(.subheadline)
                        .bold()
                        .fontDesign(.monospaced)
                }
                .fullScreenCover(isPresented: $nav) {
                    LogInView()
                }
            }
        }.padding()
    }
}

#Preview {
    SignUp()
}

