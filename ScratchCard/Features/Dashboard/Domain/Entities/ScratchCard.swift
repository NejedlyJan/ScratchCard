//
//  ScratchCard.swift
//  ScratchCard
//
//  Created by Jan Nejedlý on 01.11.2025.
//

struct ScratchCard {
    enum ScratchCardState {
        case unscratched
        case scratched(code: String)
        case activated
    }

    let state: ScratchCardState
}
