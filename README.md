# LNITaskList
Implementation of "Promises" in Swift

Do you like what [q](https://github.com/kriskowal/q) does, and would like it for Swift? In other words, you want to run a set of asynchronous tasks sequentially, while avoiding the [Pyramid of Doom](https://en.wikipedia.org/wiki/Pyramid_of_doom_(programming))?

LNITaskList helps you do exactly that. Take the LNITaskList.swift from this project and add to your project. Then, you can write the steps as follows:

    let taskList = LNITaskList()
    taskList.onSuccess {
      // What should happen on success - if ALL steps succeed
            }.onFailure {
      // What should happen on failure - if ANY step fails. All subsequent steps are skipped.
            }.addStep {
                // Do whatever you like. Pass taskList as a parameter to the async operation
            }.addStep {
                // As many as you like. The only common factor is taskList, defined above
            }.start()

In all the asynchronous "steps", call
    taskList.markDone(true) // When the async step succeeds
or
    taskList.markDone(false) // When the async step fails

That's it! Take a look at the demo app for more information.
