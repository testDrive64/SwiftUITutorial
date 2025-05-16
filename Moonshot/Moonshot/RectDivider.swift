//
//  RectDivider.swift
//  Moonshot
//
//  Created by Norman on 07.03.25.
//

import SwiftUI

struct RectDivider: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundStyle(.lightBackground)
            .padding(.vertical)
    }
}

#Preview {
    RectDivider()
}
