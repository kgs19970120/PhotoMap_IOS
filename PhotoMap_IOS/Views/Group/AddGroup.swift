//
//  AddGroup.swift
//  PhotoMap_IOS
//
//  Created by 김근수 on 2020/01/16.
//  Copyright © 2020 김근수. All rights reserved.
//

import SwiftUI

struct AddGroup: View {
    let isOpen: Bool
    let menuClose: () -> Void
    var body: some View {
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
                SubAddGroup(menuClose: menuClose)
                    .frame(height: 100)
                    .background(Color.white)
                    .offset(y: self.isOpen ? 0 : -UIScreen.main.bounds.height)
                    .animation(.easeInOut(duration: 0.4))
                Spacer()
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
}

struct SubAddGroup: View {
    @EnvironmentObject var userSettings: UserSettings
//    @ObservedObject var groupData: UserGroupStore
    @ObservedObject var userGroupStore = UserGroupStore.shared
    @State var groupName: String = ""
    @State var showAlert: Bool = false
    let menuClose: () -> Void
    var body: some View {
        
        VStack {
            Text("그룹 추가하기")
                .font(.title)
                .fontWeight(.semibold)
//                .foregroundColor(.white)
            HStack{
                TextField("그룹 이름을 입력하세요", text: $groupName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    if self.groupName.isEmpty{
                        self.showAlert.toggle()
                    }else{
                        self.userGroupStore.addMap(name: self.groupName, userTocken: self.userSettings.userTocken!)
                        self.menuClose()
                        self.endEditing()
                    }
                }) {
                    Image(systemName: "plus.square")
                        .resizable()
                        .frame(width: 30, height: 30)
//                        .foregroundColor(.white)
                }
            }
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

//struct AddGroup_Previews: PreviewProvider {
//    static var previews: some View {
//        SubAddGroup()
//    }
//}
