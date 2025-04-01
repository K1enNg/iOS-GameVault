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
                
                TextField("Enter your email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom, 20)
                    .onChange (of: email){
                        email = email.lowercased()
                    }
            }.padding(.horizontal)
            
            Button (action: {
                if(!email.isEmpty) {
                    Auth.auth().sendPasswordReset(withEmail: email) { error in
                        if let error = error {
                            print("Error resetting password: \(error.localizedDescription)")
                            return
                        }
                        print("Password reset request sent to " +  email)
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
                                .foregroundStyle(.white)
                                .font(.title3)
                                .fontDesign(.monospaced)
                        }
                    }
            }
            
            Spacer()
        }
    }
}

#Preview {
    ResetPassword()
}
