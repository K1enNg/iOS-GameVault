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
    @State private var toastMessage: String? = nil
    
    var body: some View {
        VStack {
            Image("gameVaultLogo")
                .resizable()
                .scaledToFit()
                .padding()
            
                Text("New? Sign Up")
                    .font(.title)
                    .bold()
                    .fontDesign(.monospaced)
                    .padding(.bottom)
                    .foregroundColor(.gold)
            
            VStack (alignment: .leading, spacing: 20){
                
                
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.gray.opacity(0.4))
                    .frame(width: 370, height: 60)
                    .overlay{
                        TextField("Enter your username", text: $username)
                            .textFieldStyle(PlainTextFieldStyle())
                            .fontDesign(.monospaced)
                            .padding(.leading)
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
                            .onChange(of: password) {
                                password = password.trimmingCharacters(in: .whitespaces)
                            }
                    }
                
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.gray.opacity(0.4))
                    .frame(width: 370, height: 60)
                    .overlay{
                        TextField("Enter your email", text: $email)
                            .textFieldStyle(PlainTextFieldStyle())
                            .fontDesign(.monospaced)
                            .onChange (of: email){
                                email = email.lowercased().trimmingCharacters(in: .whitespaces)
                            }.padding(.leading)
                    }
            }
            
            Button (action: {
                if(!username.isEmpty && !password.isEmpty && !email.isEmpty) {
                    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                        if let error = error {
                            toastMessage = "Error signing up: \(error.localizedDescription)"
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                        toastMessage = nil
                            }
                            return
                        }
                        guard let uid = authResult?.user.uid else { return }
                        
                        firestoreService.addUser(uid, username, email)
                        toastMessage = "Signed Up successfully!"
                        nav2 = true
                    }
                }
                else {
                    toastMessage = "Please enter all fields!"
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                toastMessage = nil
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
                        .foregroundStyle(.gold)
                        .bold()
                        .fontDesign(.monospaced)
                }
                .fullScreenCover(isPresented: $nav) {
                    LogInView()
                }
            }
            
            Spacer()
        }.padding()
            .background(LinearGradient(gradient: Gradient(colors: [ Color.black.opacity(0.9), Color.yellow.opacity(0.9)]), startPoint: .top, endPoint: .bottom))
            .toast($toastMessage)
    }
}

#Preview {
    SignUp()
}

