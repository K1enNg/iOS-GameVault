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
    @State private var toastMessage: String? = nil
    
    var body: some View {
        VStack {
            VStack (spacing: 20) {
                Image("gameVaultLogo")
                    .resizable()
                    .scaledToFit()
                
                    Text("Log In")
                    .font(.title)
                        .bold()
                        .fontDesign(.monospaced)
                        .foregroundColor(.gold)
                
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.gray.opacity(0.4))
                    .frame(width: 370, height: 60)
                    .overlay{
                        TextField("Enter your username", text: $username)
                            .textFieldStyle(PlainTextFieldStyle())
                            .fontDesign(.monospaced)
                            .padding(.leading)
                            .fontWeight(.bold)
                            .onChange(of: username) {
                                username = username.trimmingCharacters(in: .whitespaces)
                            }
                    }
                
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.gray.opacity(0.4))
                    .frame(width: 370, height: 60)
                    .overlay{
                        SecureField("Enter your password", text: $password)
                            .textFieldStyle(PlainTextFieldStyle())
                            .fontDesign(.monospaced)
                            .padding(.leading)
                            .fontWeight(.bold)
                            .onChange(of: password) {
                                password = password.trimmingCharacters(in: .whitespaces)
                            }
                    }
                
            }.padding()
            
            HStack{
                Spacer()
                Button (action : {
                    nav3 = true
                }) {
                    Text("Forgot Password")
                        .foregroundStyle(.gold)
                        .fontDesign(.monospaced)
                        .font(.subheadline)
                        .padding(.trailing)
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
                                    toastMessage = "Error logging in: \(error.localizedDescription)"
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                                toastMessage = nil
                                    }
                                    return
                                }
                                toastMessage = "User signed in successfully!"
                                currentUsername = username
                                nav2 = true
                            }
                        }
                    }
                    else{
                        toastMessage = "Please enter both username and password."
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            toastMessage = nil
                        }
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
                Home()
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
                        .foregroundStyle(.gold)
                        .fontDesign(.monospaced)
                }
                .fullScreenCover(isPresented: $nav) {
                    SignUp()
                }
            }
            
            Spacer()
            
        }.padding()
            .background(LinearGradient(gradient: Gradient(colors: [ Color.black.opacity(0.9), Color.yellow.opacity(0.9)]), startPoint: .top, endPoint: .bottom))
            .toast($toastMessage)
    }
        
}


#Preview {
    LogInView()
}
