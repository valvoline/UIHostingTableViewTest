//
//  CustomTableViewCell.swift
//  UIHostingTableViewTest
//
//  Created by Costantino Pistagna on 24/03/21.
//

import UIKit
import SwiftUI
import Combine

class CellViewModel: ObservableObject {
    @Published var title: String = "Some placeholder"
    @Published var iconName: String = "scribble.variable"
}

class CustomTableViewCell: UITableViewCell {
    private let viewModel = CellViewModel()
    private lazy var hostingVC = UIHostingController(rootView: GuestView(viewModel: viewModel))
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
        self.viewModel.title = title
        self.viewModel.iconName = sfIcon
    }
}

//MARK: - SwiftUI Stuff goes here

struct GuestView: View, Equatable {
    private var id = UUID()
    
    init(viewModel: CellViewModel) {
        self.viewModel = viewModel
    }
    
    @ObservedObject var viewModel: CellViewModel
    var body: some View {
        HStack {
            Image(systemName: viewModel.iconName)
                .padding(EdgeInsets.init(top: 8, leading: 18, bottom: 8, trailing: 0))
            Text(viewModel.title)
                .padding()
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
       
    }
    
    //MARK: - Equatable protocol
    static func == (lhs: GuestView, rhs: GuestView) -> Bool {
        return lhs.id == rhs.id
    }
}
