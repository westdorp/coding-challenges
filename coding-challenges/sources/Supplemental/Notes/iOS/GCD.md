

# Grand Central Dispatch

<details>
<summary>What Is Grand Central Dispatch?</summary>

Grand Central Dispatch (GCD) is a powerful technology that enables iOS developers to write multithreaded code easily and efficiently. In essence, GCD is a queue-based system that manages the execution of tasks on multicore hardware. By breaking down tasks into smaller, more manageable units of work and executing them concurrently, GCD can take full advantage of the power of modern processors, making your app run faster and smoother.

GCD is a technology that operates at the system level, making it easier for your app to execute tasks on multicore hardware. By leveraging GCD, your app can schedule work for execution through an easy-to-use API, leaving it to GCD to decide when and how the scheduled work is executed.

At the core of GCD are dispatch queues, which are queues onto which work can be scheduled for execution. GCD provides several options for scheduling work onto a dispatch queue, including submitting a block or a closure that takes no arguments and returns void or an empty tuple. Here's an example:

```swift
DispatchQueue.main.async {
    print("Hello World")
}
```

In this example, we're submitting a closure to the main dispatch queue, which is associated with the main thread of the application. Work submitted to the main dispatch queue is guaranteed to be executed on the main thread, which is important for updating the user interface.

GCD also manages a pool or collection of threads, making it easier to perform work in the background without having to worry about creating and managing threads. GCD decides which thread is used to execute a block, which is an implementation detail that the developer doesn't need to worry about.

In addition to dispatch queues, GCD provides several other convenient APIs, including dispatch groups and semaphores, to manage complexity and avoid threading issues. GCD also offers Quality of Service classes to inform the system about the importance of the tasks your app is performing.

It's important to understand why it's beneficial for your app to take advantage of GCD. Modern computing devices have a complex architecture, and they are incredibly performant. However, as developers, we need to be careful how the resources of these devices are used. By leveraging GCD, your app can be a good citizen on the platform it runs on, by efficiently using resources and responding to changes in device capabilities.
</details>

<details>
<summary>Working With Dispatch Queues</summary>

A dispatch queue is a queue onto which work can be scheduled for execution. It enqueues and dequeues work in FIFO (first in, first out) order. This means that the work submitted to a dispatch queue is executed in the order in which it was submitted.

There are two types of dispatch queues: serial and concurrent. A serial queue executes one task at a time, while a concurrent queue executes multiple tasks at the same time. It's important to understand the difference between these two types of queues because they behave differently and can have a significant impact on the performance of your application.

You can create a dispatch queue using the DispatchQueue class. Here's an example of how to create a serial and a concurrent queue:

```swift
// Serial queue
let serialQueue = DispatchQueue(label: "com.example.serialQueue")

// Concurrent queue
let concurrentQueue = DispatchQueue(label: "com.example.concurrentQueue", attributes: .concurrent)
```

In the example above, we create a serial queue with the label "com.example.serialQueue" and a concurrent queue with the label "com.example.concurrentQueue".

Once you have a dispatch queue, you can schedule work onto it using different methods. The most common method is using a closure, also known as a block, that contains the work you want to execute. Here's an example of how to schedule a closure onto a dispatch queue:

```swift
serialQueue.async {
    print("This code will be executed on a serial queue")
}

concurrentQueue.async {
    print("This code will be executed on a concurrent queue")
}
```

In this example, we schedule two different closures on the `serialQueue` and `concurrentQueue`, respectively. The first closure will be executed on a serial queue, which means that it will execute one task at a time. The second closure will be executed on a concurrent queue, which means that it can execute multiple tasks at the same time.

It's important to note that when you submit a closure to a dispatch queue, it's executed asynchronously. This means that the code that follows the `async` method will continue to execute, even if the closure hasn't finished executing yet.
</details>

<details>
<summary>Working with Dispatch Queues: Serial and Concurrent Queues</summary>

#Serial Queues
A serial queue executes one task at a time. Tasks are executed in the order in which they are submitted to the queue. A serial queue is useful when you want to ensure that tasks are executed in a predictable and deterministic order. If you submit three tasks to a serial queue, task A, task B, and task C, the tasks are executed in the following order:

```swift
queue.async {
    print("Task A")
}
queue.async {
    print("Task B")
}
queue.async {
    print("Task C")
}
```

Output:
```swift
Task A
Task B
Task C
```

In this example, task A is executed first, followed by task B, and finally task C. This is because the tasks are executed in the order in which they are submitted to the queue.

Serial queues are often used for tasks that are dependent on each other. For example, let's say you have an image processing application. You want to resize an image, then apply a filter, and finally save the result to disk. You would submit each task to a serial queue, ensuring that the tasks are executed in the correct order.

#Concurrent Queues

A concurrent queue, on the other hand, executes tasks concurrently. Tasks are executed in the order in which they are submitted to the queue, but because multiple tasks can be executed at the same time, the order in which they complete is not guaranteed.

Concurrent queues are useful when you have a set of independent tasks that can be executed in parallel. For example, let's say you have a list of images that need to be downloaded from a server. You can submit each download task to a concurrent queue, allowing multiple downloads to happen at the same time.

```swift
let queue = DispatchQueue(label: "com.myapp.concurrent", attributes: .concurrent)

for i in 1...10 {
    queue.async {
        print("Task \(i)")
    }
}
```
Output:
```swift
Task 2
Task 3
Task 1
Task 4
Task 5
Task 6
Task 7
Task 8
Task 9
Task 10
```
In this example, the tasks are executed concurrently, and because the order in which they complete is not guaranteed, the output is not in numerical order.
</details>

<details>
<summary>Main and Global Dispatch Queues</summary>

#Main Queue

The main queue is the default queue that is created for an application. It is the queue that is associated with the main thread of the application. Work submitted to the main queue is executed on the main thread. This is important because all user interface updates should be performed on the main thread.

Let's take a look at an example:

```swift
DispatchQueue.main.async {
    self.myLabel.text = "Hello World"
}
```

In this example, we ask the `DispatchQueue` class for a reference to the main queue. We then submit a closure to the main queue using the `async` method. Inside the closure, we update a label on the user interface. Because we're submitting the closure to the main queue, we're guaranteed that the label is updated on the main thread.

#Global Queues

In addition to the main queue, Grand Central Dispatch provides several global queues. A global queue is a queue that is shared across the system. There are four different quality of service (QoS) levels for global queues:

- `.userInteractive`: for tasks that require immediate attention, such as animating user interface elements.
- `.userInitiated`: for tasks that are initiated by the user, such as opening a file.
- `.utility`: for long-running tasks that the user is aware of, such as exporting a large file.
- `.background`: for tasks that are not visible to the user, such as downloading a file in the background.

Let's take a look at an example:

```swift
DispatchQueue.global(qos: .userInitiated).async {
    // Perform a long-running task
}
```

In this example, we ask the `DispatchQueue` class for a reference to a global queue with the `.userInitiated` quality of service. We then submit a closure to the global queue using the async method. Inside the closure, we perform a long-running task.

Global queues are useful when you need to perform work that doesn't require immediate attention or that is not tied to the user interface. By using global queues with the appropriate quality of service, you can ensure that the work is performed in a timely manner without negatively impacting the user experience.

#Choosing the Right Dispatch Queue

Choosing the right dispatch queue for the task at hand is important. The main dispatch queue should be used for tasks that update the user interface. The global dispatch queue should be used for tasks that can be executed in the background.

It's important to remember that the global dispatch queue is a concurrent queue. This means that tasks that are submitted to the global dispatch queue can be executed concurrently. If the tasks depend on each other, a serial queue should be used instead.
</details>

<details>
<summary>Synchronous and Asynchronous Execution</summary>

#Asynchronous Execution

When you dispatch work asynchronously, the block is submitted to the dispatch queue and the method returns immediately. The block is then executed on a background thread. This means that the block is executed concurrently with the rest of your application. The thread that is used to execute the block is managed by Grand Central Dispatch.

Here's an example of how to dispatch work asynchronously:

```swift
DispatchQueue.global(qos: .userInitiated).async {
    // Perform work here
}
```

This dispatches the block to a global queue with the user-initiated QoS (Quality of Service) class. The block is executed on a background thread and the method returns immediately.

#Synchronous Execution

When you dispatch work synchronously, the method blocks until the block has been executed. This means that the block is executed on the current thread, which can be either the main thread or a background thread. The method doesn't return until the block has been executed.

Here's an example of how to dispatch work synchronously:

```swift
DispatchQueue.main.sync {
    // Perform work here
}
```

This dispatches the block to the main queue and blocks the current thread until the block has been executed. The block is executed on the main thread.

#Choosing Between Asynchronous and Synchronous Execution

So, when should you choose to dispatch work asynchronously or synchronously? As a rule of thumb, you should choose to dispatch work asynchronously when the work doesn't need to block the current thread. This allows your application to continue executing while the work is being performed in the background.

On the other hand, you should choose to dispatch work synchronously when the work needs to block the current thread. This is useful when you need to wait for the work to complete before continuing execution. For example, you might need to wait for a file to be downloaded before displaying it to the user.
</details>

<details>
<summary>Adding Flexibility with Dispatch Work Items</summary>

What is a Dispatch Work Item?

A dispatch work item is a block of code that is executed on a dispatch queue. It's a more flexible alternative to submitting blocks directly to a dispatch queue because it allows us to perform additional operations before or after the block executes. We can also use a dispatch work item to cancel a task or add dependency between tasks.

Let's look at an example. Suppose we have two tasks to execute: downloading an image from the internet and applying a filter to that image. We can represent each task as a dispatch work item and submit them to a concurrent queue:

```swift
let downloadWorkItem = DispatchWorkItem {
    // Download the image from the internet
}

let filterWorkItem = DispatchWorkItem {
    // Apply a filter to the image
}

let queue = DispatchQueue.global(qos: .userInitiated)
queue.async(execute: downloadWorkItem)
queue.async(execute: filterWorkItem)
```

In this example, we create two dispatch work items for downloading and filtering the image. We then submit them to a global queue with the `.userInitiated` quality of service (QoS) class, which indicates that the tasks are user-initiated and should be executed with a higher priority than the default QoS class.

Managing Dispatch Work Items

Once we create a dispatch work item, we can manage it in a few ways. For example, we can cancel a work item using the `cancel()` method:

```swift
let workItem = DispatchWorkItem {
    // Execute some task
}

// Submit the work item to a queue
let queue = DispatchQueue.global(qos: .background)
queue.async(execute: workItem)

// Cancel the work item after 5 seconds
let deadline = DispatchTime.now() + .seconds(5)
queue.asyncAfter(deadline: deadline) {
    workItem.cancel()
}
```
In this example, we create a dispatch work item and submit it to a background queue. We then schedule a block to execute after 5 seconds, which calls the cancel() method on the work item.

We can also use dispatch work items to add dependencies between tasks. For example, suppose we have three tasks: task A, task B, and task C. We want to execute task A first, followed by task B and C in parallel. We can use dispatch work items to achieve this:

```swift
let taskA = DispatchWorkItem {
    // Execute task A
}

let taskB = DispatchWorkItem {
    // Execute task B
}

let taskC = DispatchWorkItem {
    // Execute task C
}

let queue = DispatchQueue.global(qos: .default)
taskB.notify(queue: queue) {
    queue.async(execute: taskC)
}

queue.async(execute: taskA)
queue.async(execute: taskB)
```

In this example, we create three dispatch work items for tasks A, B, and C. We submit task A to the queue first, followed by task B. We then use the `notify(queue:execute:)` method on task B to specify that task C should execute after task B completes.

</details>

<details>
<summary>Memory Management</summary>

When working with Grand Central Dispatch (GCD), it's important to keep memory management in mind. GCD can help optimize the performance of your application, but if you're not careful, it can also lead to memory leaks and other issues.

One common problem is when you pass an object to a block that's scheduled for execution on a dispatch queue. If you're not careful, the block might hold onto the object longer than it should, resulting in a retain cycle and a memory leak.

To avoid this issue, you should always use weak references when passing objects to blocks. Here's an example:

```swift
class MyClass {
    func doWork() {
        DispatchQueue.global().async { [weak self] in
            // use `self` here
        }
    }
}
```

In this example, we use a weak reference to self inside the block. This ensures that if the object is deallocated before the block is executed, the block won't hold onto the object and cause a memory leak.

Another way to manage memory with GCD is to use autorelease pools. Autorelease pools allow you to defer the release of objects until the end of the current iteration of the run loop. This can be useful when you're creating a large number of objects in a loop and don't want to hold onto them indefinitely.

Here's an example:

```swift
for i in 0..<10000 {
    autoreleasepool {
        let object = MyObject()
        // use `object` here
    }
}
```

In this example, we use an autorelease pool to manage the memory for the objects created in the loop. The autorelease pool ensures that the objects are released at the end of each iteration of the loop, preventing a buildup of unused memory.

It's also important to remember that GCD can execute blocks on different threads, so you should always make sure your code is thread-safe. This includes using locks, atomic operations, and other techniques to prevent race conditions and other issues.

By keeping memory management in mind when working with GCD, you can take advantage of its power and optimize the performance of your application without introducing memory leaks or other issues.
</details>

<details>
<summary>Beyond the Basics With Dispatch Work Items</summary>

Initialization

Grand Central Dispatch provides an easy way to execute work items asynchronously and concurrently in a safe and efficient manner. A dispatch work item is a task that can be executed on a dispatch queue, and it can be used to perform various kinds of work, such as calling a network API, updating the UI, or performing a long-running computation.

To create a dispatch work item, we use the DispatchWorkItem class provided by the GCD API. This class encapsulates a unit of work that can be executed on a queue, and it can be initialized in various ways.

Initialization Options:

There are different ways to initialize a DispatchWorkItem. Here are some of the most commonly used options:

Using a closure:

```swift
let workItem = DispatchWorkItem {
  // work to be performed
}
```

This is the simplest way to create a work item. We pass a closure that contains the work to be performed. When the work item is executed, the closure is invoked on the target queue.

Using a closure and a quality of service (QoS) class:
```swift
let workItem = DispatchWorkItem(qos: .background) {
  // work to be performed
}
```

This initializes a work item with a QoS class. The QoS class is used to specify the priority of the work item. There are different QoS classes available, ranging from user interactive to background.

Using a closure and a dispatch queue:
```swift
let queue = DispatchQueue(label: "com.example.myqueue")
let workItem = DispatchWorkItem(queue: queue) {
  // work to be performed
}
```

This initializes a work item with a target queue. When the work item is executed, it will be dispatched to the target queue for execution.

Using a closure, a dispatch queue, and a QoS class:
```swift
let queue = DispatchQueue(label: "com.example.myqueue", qos: .background)
let workItem = DispatchWorkItem(queue: queue) {
  // work to be performed
}
```

This initializes a work item with a target queue and a QoS class. The work item will be dispatched to the target queue with the specified QoS class.

Flags:

There are also several flags that can be set when creating a dispatch work item. Here are some of the most commonly used flags:

`.inheritQoS`
This flag is used to inherit the QoS class of the current thread. When a work item is submitted to a queue and this flag is set, the work item inherits the QoS class of the thread that submitted it.

```swift
let workItem = DispatchWorkItem(flags: .inheritQoS) {
  // work to be performed
}
```

`.enforceQoS`
This flag is used to enforce the QoS class of the work item, even if it's submitted to a queue with a different QoS class.

```swift
let workItem = DispatchWorkItem(flags: .enforceQoS) {
  // work to be performed
}
```
By using these flags, we can ensure that the work item is executed with the desired QoS class, regardless of the queue it's submitted to.

Performing a Dispatch Work Item

In Grand Central Dispatch, a work item is a block of code that you want to execute on a dispatch queue. You can create a work item by wrapping a block of code inside a `DispatchWorkItem` object. The object provides a few additional features that allow you to control how the work item is executed.

One way to execute a work item is by invoking its `perform()` method. When you call `perform()` on a work item, it gets submitted to the dispatch queue, and the block of code that it contains gets executed. Here's what that looks like:

```swift
let workItem = DispatchWorkItem {
    // Your block of code goes here
}

workItem.perform()
```

While the `perform()` method looks appealing because it allows you to execute a work item with a single line of code, it's important to understand that the result isn't always what you want.

One problem with using `perform()` is that it blocks the current thread until the work item completes. This means that if you call `perform()` on the main thread, the UI freezes until the work item completes. This defeats the purpose of using Grand Central Dispatch, which is to execute work items in the background to keep the user interface responsive.

Another issue with using `perform()` is that it doesn't allow you to take advantage of the full power of Grand Central Dispatch. For example, it doesn't provide the ability to specify a quality of service class or a dispatch queue.

To avoid these issues, it's best to use the `async(execute:)` method on a dispatch queue to submit a work item. Here's what that looks like:

```swift
let workItem = DispatchWorkItem {
    // Your block of code goes here
}

let queue = DispatchQueue(label: "com.example.myqueue")
queue.async(execute: workItem)
```
By submitting a work item using a dispatch queue, you can specify the queue's quality of service class, which determines how the system schedules the work item for execution. Additionally, using a dispatch queue allows the system to choose the most appropriate thread to execute the work item, which can improve performance.

Waiting for Completion with Notify() and Wait()

When we submit a work item to a dispatch queue, it is usually asynchronous, meaning that the rest of our code can continue executing while the work item is being processed on a separate thread. However, sometimes we need to wait for the work item to finish before continuing with the rest of our code. We can accomplish this using the `notify()` and `wait()` methods provided by Grand Central Dispatch.

The `notify()` Method

The `notify()` method is called on a dispatch queue after all submitted work items have completed. We can use this method to execute additional work after the original work item has finished processing. Here is an example:

```swift
let queue = DispatchQueue(label: "com.mycompany.myqueue")
queue.async {
    // Perform work item
}
queue.notify(queue: DispatchQueue.main) {
    // Additional work to be executed after the work item completes
}
```

In this example, we create a new dispatch queue and submit a work item to it. We then call the `notify()` method on the same dispatch queue and pass in a closure to be executed after the work item has completed. In this case, we are executing the closure on the main dispatch queue, but we could use any other queue as well.

The `wait()` Method

The wait() method is called on a dispatch queue and blocks the current thread until all submitted work items have completed. This method should be used with caution, as it can cause our application to become unresponsive if the work items take a long time to complete. Here is an example:

```swift
let queue = DispatchQueue(label: "com.mycompany.myqueue")
queue.async {
    // Perform work item
}
queue.wait()
// Code here is not executed until work item completes
```

In this example, we create a new dispatch queue and submit a work item to it. We then call the `wait()` method on the same dispatch queue, which blocks the current thread until the work item has completed. Once the work item has completed, the code after the `wait()` method call is executed.

Be Careful with `wait()`

While the `wait()` method may seem appealing because it allows us to wait for a work item to complete before continuing with the rest of our code, we should be careful when using it. If we call `wait()` on the main thread, it can cause our application to become unresponsive and even crash if the work item takes a long time to complete. It is usually better to use the `notify()` method or other synchronization mechanisms, such as semaphores, to manage the execution of our work items.

In summary, the `notify()` and `wait()` methods provide powerful tools for managing the execution of our work items on Grand Central Dispatch. By using these methods, we can synchronize our code and ensure that our work items are executing in the order and at the times that we expect. However, we should be careful when using the wait() method and make sure to use it only in appropriate situations.
</details>

<details>
<summary>Managing Complexity With Dispatch Groups</summary>

Dispatch groups are an essential tool for managing complex tasks with Grand Central Dispatch. They allow you to group tasks and coordinate their completion. With dispatch groups, you can easily ensure that a group of tasks completes before proceeding to the next step. In this article, we'll explore how dispatch groups work and how to use them in your iOS projects.

What is a Dispatch Group?

A dispatch group is a simple mechanism that allows you to track the completion of a set of tasks. You can use dispatch groups to coordinate the completion of multiple tasks and wait for them to finish before proceeding to the next step. A dispatch group is a lightweight object that doesn't consume many system resources, so you can use as many as you need in your project.

Creating a Dispatch Group

You create a dispatch group by calling the `DispatchGroup` initializer, which returns a new dispatch group object. You can create a dispatch group anywhere in your code, but it's best to create it in the function where you need it. Here's an example:

```swift
let myGroup = DispatchGroup()
```

Adding Tasks to a Dispatch Group

To add a task to a dispatch group, you wrap the task inside a `dispatchGroup.enter()` and `dispatchGroup.leave()` block. The `dispatchGroup.enter()` call increments the number of active tasks in the group, while the `dispatchGroup.leave()` call decrements it. When the number of active tasks in the group reaches zero, the group is considered complete, and you can proceed to the next step.

Here's an example of how to add a task to a dispatch group:

```swift
myGroup.enter()
DispatchQueue.global().async {
    // Perform some task here
    myGroup.leave()
}
```

In this example, we add a task to the dispatch group using the `enter()` method before starting the task. Inside the task, we perform some work and then call the `leave()` method to signal that the task has completed. Once all tasks in the group have completed, the dispatch group is considered complete.

Waiting for Completion

Once you've added all the tasks to the dispatch group, you need to wait for them to complete before proceeding to the next step. You can wait for completion in two ways: using the `notify()` method or the `wait()` method.

The `notify()` method allows you to specify a closure that's executed when all tasks in the group have completed. This method doesn't block the current thread and returns immediately, allowing your code to continue executing. Here's an example:

```swift
myGroup.notify(queue: .main) {
    // All tasks have completed, do something else
}
```

In this example, we call the `notify()` method on the dispatch group, passing in a closure to be executed when all tasks have completed. The closure is executed on the main queue, so any UI updates must be performed inside it.

The `wait()` method blocks the current thread until all tasks in the group have completed. This method is useful when you need to wait for completion before proceeding to the next step. Here's an example:

```swift
myGroup.wait()
// All tasks have completed, do something else
```

In this example, we call the `wait()` method on the dispatch group, which blocks the current thread until all tasks have completed. Once all tasks have completed, the method returns, and we can proceed to the next step.
</details>

<details>
<summary>Controlling Access With Dispatch Semaphores</summary>

In Grand Central Dispatch, semaphores can be used to manage access to shared resources. A semaphore is a synchronization object that can be used to coordinate access to a shared resource. Semaphores can be used to control the number of threads that can access a resource simultaneously.

A semaphore can be thought of as a gatekeeper. The gatekeeper keeps track of how many threads are allowed to pass through the gate at once. If there are already too many threads inside, the gatekeeper will block any additional threads from entering until some threads leave. Once some threads leave, the gatekeeper will allow additional threads to enter.

In Grand Central Dispatch, a semaphore is represented by the DispatchSemaphore class. To create a semaphore, you need to specify the initial value. The initial value specifies how many threads are allowed to access the shared resource simultaneously.

```swift
let semaphore = DispatchSemaphore(value: 1)
```

In this example, we're creating a semaphore with an initial value of 1. This means that only one thread can access the shared resource at any given time.

To use the semaphore, we need to call `wait()` before accessing the shared resource and `signal()` after accessing the shared resource. When `wait()` is called, the semaphore will decrement the value. If the value is already zero, `wait()` will block until another thread calls `signal()`. When `signal()` is called, the semaphore will increment the value. If there are any threads blocked on `wait()`, one of them will be unblocked and allowed to continue.

Here's an example of how we can use a semaphore to limit the number of concurrent downloads to 4:

```swift
let semaphore = DispatchSemaphore(value: 4)

func download(url: URL) {
    semaphore.wait()
    URLSession.shared.downloadTask(with: url) { (url, response, error) in
        // Handle the download
        semaphore.signal()
    }.resume()
}
```

In this example, we're creating a semaphore with an initial value of 4. This means that up to 4 downloads can happen simultaneously. When we want to start a download, we first call `semaphore.wait()` to decrement the value. This ensures that no more than 4 downloads are happening at once. Once the download is complete, we call `semaphore.signal()` to increment the value and allow another download to start.

It's important to note that using semaphores can introduce the possibility of deadlocks. A deadlock can occur when two or more threads are waiting for each other to release a semaphore. To avoid deadlocks, it's important to follow a few guidelines:

- Always call `signal()` after accessing the shared resource.
- Never call `wait()` twice in a row without calling `signal()` in between.
- Make sure that the initial value of the semaphore is greater than zero.

In summary, semaphores can be a powerful tool for managing access to shared resources in Grand Central Dispatch. By limiting the number of threads that can access a resource simultaneously, we can prevent race conditions and improve the performance and stability of our applications. However, it's important to use semaphores carefully and follow best practices to avoid deadlocks and other issues.
</details>
