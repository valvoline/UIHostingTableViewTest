//
//  CustomTableViewCell.swift
//  UIHostingTableViewTest
//
//  Created by Costantino Pistagna on 24/03/21.
//

import UIKit
import SwiftUI

class CustomTableViewCell: UITableViewCell {
    private let hostingVC = UIHostingController(rootView: GuestView())
    override func awakeFromNib() {
        contentView.addSubview(hostingVC.view)
        hostingVC.view.translatesAutoresizingMaskIntoConstraints = false
        hostingVC.view.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        hostingVC.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        hostingVC.view.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        hostingVC.view.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        self.contentView.setNeedsLayout()
        self.contentView.layoutIfNeeded()
    }
    
    func configure(title: String, sfIcon: String) {
        NotificationCenter.default.post(name: NSNotification.Name("titleChanged"),
                                        object: hostingVC.rootView,
                                        userInfo: ["title": title, "iconName": sfIcon])
    }
}

//MARK: - SwiftUI Stuff goes here

struct GuestView: View, Equatable {
    private var id = UUID()
    @State var title:String?
    @State var iconName:String?
    var body: some View {
        HStack {
            Image(systemName: iconName ?? "scribble.variable")
                .padding(EdgeInsets.init(top: 8, leading: 18, bottom: 8, trailing: 0))
            Text(title ?? "Some placeholder")
                .padding()
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name(rawValue: "titleChanged")),
                   perform: { aNotification in
                    guard let object = aNotification.object as? GuestView, object == self else { return }
                    if let userInfo = aNotification.userInfo as? [String: Any] {
                        if let newValue = userInfo["title"] as? String {
                            title = newValue
                        }
                        if let newValue = userInfo["iconName"] as? String {
                            iconName = newValue
                        }
                    }
                   })
    }
    
    //MARK: - Equatable protocol
    static func == (lhs: GuestView, rhs: GuestView) -> Bool {
        return lhs.id == rhs.id
    }
}
