import Foundation

protocol SuspendableTask {
    func suspend()
}

struct SuspendableDataTask: SuspendableTask {
    let task: URLSessionTask

    func suspend() {
        task.suspend()
    }
}
