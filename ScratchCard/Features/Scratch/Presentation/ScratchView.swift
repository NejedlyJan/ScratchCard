import SwiftUI

struct ScratchView: View {
    var viewModel: ScratchViewModel
    @State private var scratchTask: Task<Void, Never>?

    var body: some View {
        VStack(spacing: 20) {
            switch viewModel.state {
            case .idle:
                Button("Scratch card") {
                    scratchTask = Task {
                        await viewModel.scratch()
                    }
                }
                .buttonStyle(.borderedProminent)

            case .scratching:
                VStack(spacing: 16) {
                    ProgressView()
                    Text("Scratching")
                }

            case .success(let code):
                VStack(spacing: 16) {
                    Text("Scratched Successfully!")
                        .font(.headline)
                    Text("Code: \(code)")
                        .font(.body)
                        .padding()
                }
            }
        }
        .padding()
        .onDisappear {
            scratchTask?.cancel()
        }
    }
}
