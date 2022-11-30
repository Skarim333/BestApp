//
//  ToolbarMenu.swift
//  BestAppTest
//
//  Created by Карим Садыков on 30.11.2022.
//

import UIKit

class ToolbarMenu: UIView {
    
    let picker: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        addSubview(picker)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    var body: some View {
//        Menu {
//            // a picker to switch between sorting orders with animation of state changes
//            Picker(selection: $feedStore.sortOrder.animation(), label: Text(""), content: {
//                ForEach(SortOrder.allCases, id: \.self) {
//                    Text("By " + $0.localizedTitle).tag($0.rawValue)
//                }
//            })
//        } label: {
//            Text("Sort Order")
//        }
//        .disabled(feedStore.posts.isEmpty)
//    }
}

