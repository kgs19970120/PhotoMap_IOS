//
//  AddGroup.swift
//  PhotoMap_IOS
//
//  Created by 김근수 on 2020/01/16.
//  Copyright © 2020 김근수. All rights reserved.
//

import SwiftUI

struct AddGroup: View {
    @State var isLoading: Bool = false
    let isOpen: Bool
    let menuClose: () -> Void
    var body: some View {
        LoadingView(isShowing: $isLoading){
            ZStack{
                GeometryReader { _ in
                    EmptyView()
                }
                .background(Color.black.opacity(0.7))
                .opacity(self.isOpen ? 1.0 : 0.0)
                .onTapGesture {
                    self.menuClose()
                    self.endEditing()
                }
                
                VStack {
                    SubAddGroup(isLoading: self.$isLoading, menuClose: self.menuClose)
                        .frame(height: 100)
                        .background(Color(appColor))
                        .offset(y: self.isOpen ? 0 : -UIScreen.main.bounds.height)
                        .animation(.easeInOut(duration: 0.4))
                    Spacer()
                }
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        
    }
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
}

struct SubAddGroup: View {
    @EnvironmentObject var userSettings: UserSettings
    @ObservedObject var userGroupStore = UserGroupStore.shared
    @State var groupName: String = ""
    @State var showAlert: Bool = false
    @Binding var isLoading: Bool
    let menuClose: () -> Void
    var body: some View {
        
        VStack(spacing: 0) {
            Text("그룹 추가하기")
                .font(.title)
                .foregroundColor(.white)
            HStack{
                TextField("그룹 이름을 입력하세요", text: $groupName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    if self.groupName.isEmpty{
                        self.showAlert.toggle()
                    }else{
                        self.isLoading = true
                        self.userGroupStore.addMap(name: self.groupName){
                            self.isLoading = false
                            self.menuClose()
                            self.endEditing()
                        }
                    }
                }) {
                    Image(systemName: "plus.square")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                }
            }
        .padding()
        }
        .alert(isPresented: $showAlert){
            Alert(title: Text("그룹 이름이 없습니다"), message: Text("그룹 이름을 정한 후 추가해주세요!"), dismissButton: .default(Text("취소")))
        }
    }
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
}
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
