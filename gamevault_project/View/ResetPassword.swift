//
//  ResetPassword.swift
//  gamevault_project
//
//  Created by Tran Ba Minh Huy on 2025-03-23.
//

import SwiftUI
import FirebaseAuth

struct ResetPassword: View {
    @State private var email: String = ""
    @State private var nav2 = false
    @State private var toastMessage: String? = nil
    var body: some View {
        VStack {
            Image("gameVaultLogo")
                .resizable()
                .scaledToFit()
            
            VStack (alignment: .leading){
                Text("Reset Password")
                    .font(.title)
                    .fontWeight(.bold)
                    .fontDesign(.monospaced)
                    .foregroundColor(.gold)
                
                
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.gray.opacity(0.4))
                    .frame(width: 370, height: 60)
                    .overlay{
                        TextField("Enter your email", text: $email)
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding()
                            .fontDesign(.monospaced)
                            .onChange (of: email){
                                email = email.lowercased().trimmingCharacters(in: .whitespaces)
                            }
                    }
            }.padding(.horizontal)
            
            Button (action: {
                if(!email.isEmpty) {
                    Auth.auth().sendPasswordReset(withEmail: email) { error in
                        if let error = error {
                            toastMessage = "Error resetting password: \(error.localizedDescription)"
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                        toastMessage = nil
                            }
                            return
                        }
                        toastMessage = "Password reset request sent to " +  email
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    toastMessage = nil
                            nav2 = true
                        }
                    }
                }
                else {
                    toastMessage = "Please enter your email!"
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
                            Text("Send Link")
                                .foregroundStyle(.gold)
                                .font(.title3)
                                .fontDesign(.monospaced)
                        }
                    }
            } .fullScreenCover(isPresented: $nav2) {
                LogInView()
            }
            
            Spacer()
        }
        .background(LinearGradient(gradient: Gradient(colors: [ Color.black.opacity(0.9), Color.yellow.opacity(0.9)]), startPoint: .top, endPoint: .bottom))
        .toast($toastMessage)
    }
}

#Preview {
    ResetPassword()
}
