# LNITaskList
Implementation of "Promises" in Swift

Do you like what [[q]](https://github.com/kriskowal/q) does, and would like it for Swift?

Wait, it should be even easier in Swift. Well, how about the following?

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

In your "steps", call
    taskList.markDone(true) // For success
or
    taskList.markDone(false) // For failure

That's it! Take a look at the demo app for more information.
