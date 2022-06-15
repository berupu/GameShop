//
//  LogInPage.swift
//  Shared
//
//  Created by Ashraful Islam Rupu on 5/30/22.
//

import SwiftUI

struct LogInPage: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var loginVM: LogInVM = LogInVM()
    
    
    var body: some View {
        VStack {
            VStack {
                Text("Welcome to\nGameshop")
                    .font(.system(size: 27))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: getScreen().height / 3.5)
                    .padding()
                    .background(
                        ZStack {
                            LinearGradient(colors: [Color.green,Color.purple.opacity(0.8)], startPoint: .top, endPoint: .bottom)
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .offset(x: 140, y: -120)
                                .frame(maxWidth: .infinity,maxHeight: .infinity)
                            
                            Circle()
                                .strokeBorder(Color.white.opacity(0.3), lineWidth: 3)
                                .frame(width: 40, height: 40)
                                .blur(radius: 3)
                                .offset(x: -100, y: -80)
                            
                            Circle()
                                .strokeBorder(Color.white.opacity(0.3), lineWidth: 3)
                                .frame(width: 40, height: 40)
                                .blur(radius: 3)
                                .offset(x: 100, y: 80)
                                
                        }
                    )
                    
            }
            .frame(height: getScreen().height / 3.5)

            
            ScrollView(.vertical, showsIndicators: false) {

                VStack {
                    Text(loginVM.craeteAccountMOde ? "Create Account" : "LogIn")
                        .font(.system(size: 22).bold())
                        //.shadow(color: Color.gray, radius: 15, x: 0, y: 12)
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding()
                    
                    customTextField(title: "Email", icon: "envelope", placeholder: "Enter your email", value: $loginVM.email)
                    
                    customTextField(title: "Password", icon: "lock", placeholder: "Enter your password", value: $loginVM.password)
                    
                    if loginVM.craeteAccountMOde {
                        customTextField(title: "Re-enter password", icon: "lock", placeholder: "Re-enter your password", value: $loginVM.reTypePassword)
                    }
                    
                    //login button
                    Button {
                        loginVM.logIn()
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text(loginVM.craeteAccountMOde ? "Create Account" : "LogIn")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                            .background(.purple.opacity(0.5))
                            .cornerRadius(12)
                            .padding(.horizontal, 60)
                            .padding(.top)
                            
                    }
                
                    
                    Button {
                        withAnimation(.spring()) {
                            loginVM.craeteAccountMOde.toggle()
                        }
                    } label: {
                        Text(loginVM.craeteAccountMOde ? "Back to LogIn" : "Create Account")
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            //.frame(height: 60)
                            .padding(.horizontal, 60)
                            .padding(.vertical)
                            
                    }
                    
                    


                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color.white
                    .cornerRadius(15)
                    .ignoresSafeArea()
            )
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.purple)
        .fullScreenCover(isPresented: $loginVM.logInSuccess) {
            MainPage()
        }
        
    }
    
    

    @ViewBuilder
    func customTextField(title: String, icon:String, placeholder: String, value: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 5.0) {
            
            Label {
                Text(title)
            } icon: {
                Image(systemName: icon)
            }
            TextField(placeholder, text: value)
                .padding(.vertical,10)
            
            Divider()
                .background(Color.white.opacity(0.5))
                
            
        }
        
        .padding()
    }
}


struct LogInPage_Previews: PreviewProvider {
    static var previews: some View {
        LogInPage().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .previewDevice("iPhone 13")
    }
}

extension View {
    func getScreen() -> CGRect {
        UIScreen.main.bounds
    }
}

