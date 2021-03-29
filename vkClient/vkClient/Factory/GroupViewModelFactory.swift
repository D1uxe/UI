//
//  FriendViewModelFactory.swift
//  vkClient
//
//  Created by MacBook Pro on 28.03.2021.
//

import Foundation

final class GroupViewModelFactory {

    func constructViewModels(from groups: [Group]) -> [GroupViewModel] {
        
        return groups.compactMap{self.getViewModel(from: $0)}
    }

    private func getViewModel(from group: Group) -> GroupViewModel {

        let groupName = group.name
        let groupAvatar = group.avatarURL


        return GroupViewModel(groupName: groupName,
                              groupAvatarURL: groupAvatar)
    }
}
