# RxSwift training

## The DisposeBag


When deinit() is called on the object that holds the DisposeBag, each disposable Observer is automatically unsubscribed from what it was observing. This allows ARC to take back memory as it normally would.

## What are subjects? 

There are four subject types in RxSwift, and two relay types that wrap subjects: 
- PublishSubject: Starts empty and only emits new elements to subscribers. 
- BehaviorSubject: Starts with an initial value and replays it or the latest element to new subscribers. 
- ReplaySubject: Initialized with a buffer size and will maintain a buffer of elements up to that size and replay it to new subscribers. 
- AsyncSubject: Emits only the last .next event in the sequence, and only when the subject receives a .completed event. This is a seldom used kind of subject, and you won't use it in this book. It's listed here for the sake of completeness. 
- PublishRelay and BehaviorRelay: These wrap their relative subjects, but only accept .next events. You cannot add a .completed or .error event onto relays at all, so they're great for non-terminating sequences. 
  Taking on each of these in turn, you’re going to learn a lot more about subjects and relays, and how to work with them next.

## Working with publish subjects

Publish subjects come in handy when you simply want subscribers to be notified of new events from the point at which they subscribed, until they either unsubscribe, or the subject has terminated with a .completed or .error event. 

## Working with behavior subjects 
Behavior subjects work similarly to publish subjects, except they will replay the latest .next event to new subscribers. 

## Working with replay subjects 
Replay subjects will temporarily cache, or buffer, the latest elements they emit, up to a specified size of your choosing. They will then replay that buffer to new subscribers. 

Explicitly calling dispose() on a replay subject like this isn’t something you generally need to do, because if you’ve added your subscriptions to a dispose bag (and avoided creating any strong reference cycles), then everything will be disposed of and deallocated when the owner (e.g., a view controller or view model) is deallocated. 

## Working with relays 

What sets relays apart from their wrapped subjects is that they are guaranteed to never terminate. 
