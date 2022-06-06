//
//  LogInVM.swift
//  GameShop (iOS)
//
//  Created by Ashraful Islam Rupu on 6/4/22.
//

import SwiftUI

class LogInVM : ObservableObject {
    
    @Published var email : String = ""
    @Published var password : String = ""
    @Published var reTypePassword : String = ""
    
    @Published var showPassword : Bool = false
    @Published var craeteAccountMOde: Bool = false
    
    func logIn() {
        //for login
    }
    
    func createAccount(){
        //for account creation
    }
}
