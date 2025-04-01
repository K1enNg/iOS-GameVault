//
//  LogInView.swift
//  gamevault_project
//
//  Created by Tran Ba Minh Huy on 2025-03-07.
//

import SwiftUI

import FirebaseFirestore
import FirebaseAuth

struct LogInView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    private let firestoreService = FirebaseServices()
    @State private var nav = false
    @State private var nav2 = false
    @State private var nav3 = false
    @AppStorage("currentUsername") var currentUsername: String = ""
    
    var body: some View {
        VStack {
            VStack (spacing: 20) {
                Image("gameVaultLogo")
                    .resizable()
                    .scaledToFit()
                
                
                    Text("Already a memeber?")
                    .font(.title)
                        .bold()
                        .fontDesign(.monospaced)
                    Text("Log In")
                    .font(.title)
                        .bold()
                        .fontDesign(.monospaced)
                    
                
                
                
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(.gray.opacity(0.2))
                    .frame(width: 370, height: 70)
                    .overlay{
                        TextField("Enter your username", text: $username)
                            .textFieldStyle(PlainTextFieldStyle())
                            .fontDesign(.monospaced)
                            
                    }
                
                
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(.gray.opacity(0.2))
                    .frame(width: 370, height: 70)
                    .overlay{
                        SecureField("Enter your password", text: $password)
                            .textFieldStyle(PlainTextFieldStyle())
                            .fontDesign(.monospaced)
                    }
                
            }.padding()
            
            HStack{
                Spacer()
                Button (action : {
                    nav3 = true
                }) {
                    Text("Forgot Password")
                        .foregroundStyle(.blue)
                        .fontDesign(.monospaced)
                        .font(.subheadline)
                }
                .fullScreenCover(isPresented: $nav3) {
                    ResetPassword()
                }
            }
        
            Button (action: {
                Task {
                    if(!username.isEmpty && !password.isEmpty) {
                        
                        let user = await firestoreService.getUserByUsername(username)
                        if let email = user?.email {
                            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                                
                                if let error = error {
                                    print("Error logging in: \(error.localizedDescription)")
                                    return
                                }
                                print("User signed in successfully!")
                                currentUsername = username
                                nav2 = true
                            }
                        }
                    }
                    else{
                        print("Please fill or the fields!")
                    }
                }
            }){
                RoundedRectangle(cornerRadius: 25)
                    .foregroundStyle(.black)
                    .frame(width: 350, height: 45)
                    .padding()
                    .overlay {
                        VStack {
                            HStack (alignment: .center){
                                Text("Log In")
                                    .foregroundStyle(.white)
                                    .font(.title2)
                                    .fontDesign(.monospaced)
                            }
                        }
                    }
            }
            .fullScreenCover(isPresented: $nav2) {
                HomePage()
            }
            
            HStack {
                Text("Don't have an account?")
                    .fontDesign(.monospaced)
                    .font(.subheadline)
                    .bold()
                
                Button (action : {
                    nav = true
                }) {
                    Text("Sign Up")
                        .font(.subheadline)
                        .bold()
                        .fontDesign(.monospaced)
                }
                .fullScreenCover(isPresented: $nav) {
                    SignUp()
                }
            }
        }.padding()
    }
}


#Preview {
    LogInView()
}
