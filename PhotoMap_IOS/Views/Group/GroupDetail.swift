//
//  GroupDetail.swift
//  PhotoMap_IOS
//
//  Created by 김근수 on 2020/01/10.
//  Copyright © 2020 김근수. All rights reserved.
//

import SwiftUI

struct GroupDetail: View {
    
    @State var groupData: UserGroup
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        KoreaMap()
            .navigationBarItems(leading:
                backButton, trailing:
                Button(action: {print(self.presentationMode)}) {
                    Image(systemName: "list.bullet")
                        .foregroundColor(.white)
                }
        )
            .navigationBarTitle("\(groupData.name)", displayMode: .inline)
    }
    
    var backButton : some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "arrow.left")
                    .foregroundColor(.white)
            }
        }
    }
}

struct GroupDetail_Previews: PreviewProvider {
    static var previews: some View {
        //        GroupDetail()
        SplashView()
    }
}
