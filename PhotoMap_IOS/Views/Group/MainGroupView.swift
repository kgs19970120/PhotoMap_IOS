//
//  MainGroupView.swift
//  PhotoMap_IOS
//
//  Created by 김근수 on 2020/01/09.
//  Copyright © 2020 김근수. All rights reserved.
//

import SwiftUI

struct MainGroupView: View {
    
    @EnvironmentObject var userSettings: UserSettings
    @Binding var isSideMenuActive: Bool
    @ObservedObject var groupData: UserGroupData
    
    var body: some View {
        return Group{
            if self.groupData.mapData.isEmpty{
                Text("그룹을 생성해주세요!")
            }
            else{
                ZStack {
                    List(groupData.mapData, id: \.mid) {group in
                        ZStack{
                            GroupRow(group: group)
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(Color.black, lineWidth: 3)
                            )
                            
                            NavigationLink(destination: GroupDetail(groupData: group, isSideMenuActive: self.$isSideMenuActive)
                            ){
                                EmptyView()
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                .onAppear{
                    UITableView.appearance().tableFooterView = UIView()
                    UITableView.appearance().separatorStyle = .none
                    self.groupData.loadMapData(userTocken: self.userSettings.userTocken!)
                }
            }
            
        }
    }
}

//struct MainGroupView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            MainGroupView()
//                .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
//                .previewDisplayName("iPhone SE")
//
//            MainGroupView()
//                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
//                .previewDisplayName("iPhone 8")
//
//            MainGroupView()
//                .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
//                .previewDisplayName("iPhone 11 Pro")
//        }
//    }
//}
