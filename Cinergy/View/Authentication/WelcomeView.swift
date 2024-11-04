//
//  WelcomeView.swift
//  Cinergy
//
//  Created by Jinu on 24/08/2024.
//

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State var width = UIScreen.main.bounds.width

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer(minLength: 0)
                    
                    Image("logo")
                        .resizable()
                        .scaledToFill()
                        .padding(.top)
                        .padding(.trailing)
                    
                        .frame(width: 76, height: 50)
                    
                    Spacer(minLength: 0)
                }
//                Spacer(minLength: 0)
                
                VStack(alignment: .leading,spacing: 15) {
                    Text("Join The Magic")
                        .padding(.top,25)
                        .font(.system(size: 30, weight: .regular, design: .default))
                    
                    
                    
                    Text("Be Cinergy ELITE!")
                    
                        .font(.system(size: 30, weight: .semibold, design: .default))
                    
                    HStack(alignment: .top) {
                        Image(systemName: "star.fill")
                            .foregroundStyle(Color(hex: "#A2C658"))
                        Text("Enjoy a free popcorn on sign up.")
                            .multilineTextAlignment(.leading)
                    }
                    
                    
                    HStack(alignment: .top)  {
                        Image(systemName: "star.fill")
                            .foregroundStyle(Color(hex: "#A2C658"))
                        Text("Enjoy a $5.00 Elite reward after 300 \npoints to spend however you want.")
                            .multilineTextAlignment(.leading)
                    }
                    
                    
                    HStack(alignment: .top)  {
                        Image(systemName: "star.fill")
                            .foregroundStyle(Color(hex: "#A2C658"))
                        Text("Enjoy a special birthday movie \nticket offer.")
                    }
                    
                    
                    HStack(alignment: .top)  {
                        Image(systemName: "star.fill")
                            .foregroundStyle(Color(hex: "#A2C658"))
                        Text("Enjoy exclusive content, sneak peaks,\nand special offers!.")
                            .multilineTextAlignment(.leading)
                    }
                }
                .frame(width: width * 0.9, alignment: .leading)
                
                Spacer(minLength: 0)
                
                //Buttons
                Button(action: {
                               print("Hello button tapped!")
                           }) {
                               
                                   Text("Sign in Now")
                                       .fontWeight(.semibold)
                                       .font(.title3)
                                       .foregroundColor(.black)
                                       .multilineTextAlignment(.leading)
                                       .padding()
                               
                               .frame(width: 320, height: 60) // Adjust width and height if needed
                               .background(Color(hex: "#A2C658")) // Background color
                               .cornerRadius(10) //
                           }
                           .padding()
                HStack {
//                    Rectangle()
//                        .foregroundColor(.gray)
//                        .opacity(0.3)
//                        .frame(width: (width * 0.35), height: 1)

                    Text("Don't have an account")
                        .font(.footnote)
                        .foregroundColor(.black)
                        
//                    Rectangle()
//                        .foregroundColor(.gray)
//                        .opacity(0.3)
//                        .frame(width: (width * 0.35), height: 1)
                }
                           .padding()
                Button(action: {
                               print("Hello button tapped!")
                           }) {
                               
                                   Text("Sign Up")
                                       .fontWeight(.semibold)
                                       .font(.title3)
                                       .foregroundColor(.black)
                                       .multilineTextAlignment(.leading)
                                       .padding()
                               
                               .frame(width: 320, height: 60) // Adjust width and height if needed
                               .background(Color(hex: "#A2C658")) // Background color
                               .cornerRadius(10) //
                           }
                    
                    

                Button(action: {
                               print("Login button tapped!")
                    self.viewModel.guestLogin()

                           }) {
                               
                                   Text("Continue as Guest")
                                       .fontWeight(.semibold)
                                       .font(.title3)
                                       .foregroundColor(.black)
                                       .multilineTextAlignment(.leading)
                                       .padding()
                               
                               .frame(width: 320, height: 60) // Adjust width and height if needed
                               .background(Color(hex: "#A2C658")) // Background color
                               .cornerRadius(10) //
                           }
                           .padding()
                    
//                    NavigationLink(destination: RegisterView().navigationBarHidden(true)) {
//                        RoundedRectangle(cornerRadius: 36)
//                            .foregroundColor(Color(red: 29 / 255, green: 161 / 255, blue: 242 / 255))
//                            .frame(width: 320, height: 60, alignment: .center)
//                            .overlay(Text("Create account")
//                                        .fontWeight(.bold)
//                                        .font(.title3)
//                                        .foregroundColor(.white)
//                                        .padding()
//                            )
//                    }
                    
                    
              
//                .padding()
                
                //Bottom Buttons
                
                VStack(alignment: .leading) {
                    VStack {
                        Text("By signing up, you agree to our ") + Text("Terms").foregroundColor(Color(red: 29 / 255, green: 161 / 255, blue: 242 / 255)) + Text(",") + Text(" Privacy Policy").foregroundColor(Color(red: 29 / 255, green: 161 / 255, blue: 242 / 255)) + Text(", and Cookie Use.")
                    }.padding(.bottom)
                    
                    HStack(spacing: 2) {
                        Text("Have an account already? ")
                        NavigationLink(destination: EmptyView()
                            .navigationBarHidden(true)) {
                            Text("Log in")
                                .foregroundColor(Color(red: 29 / 255, green: 161 / 255, blue: 242 / 255))
                        }
                        
                    }
                }
                
                
                
            }
            
        }
        
    }
}

#Preview {
    WelcomeView()
}
