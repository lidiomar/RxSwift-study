//
//  ViewController.swift
//  RxSwiftXP
//
//  Created by Lidiomar Machado on 16/12/21.
//

import UIKit
import RxSwift
import RxRelay

class ViewController: UIViewController {
    
    private let disposableBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testDistinctUntilChangeSampleTwo()
    }
    
    private func testDistinctUntilChangeSampleTwo() {
        Observable.of(1, 1, 2, 2, 3, 3).distinctUntilChanged({ a, b in
            return a == b
        }).subscribe(onNext: { print($0) })
            .disposed(by: disposableBag)
            
    }
    
    private func testDistinctUntilChange() {
        Observable.of(1, 1, 2, 2, 3, 3)
            .distinctUntilChanged()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposableBag)
    }
    
    private func testTakeUntil() {
        let otherObservable = PublishSubject<Int>()
        let subject = PublishSubject<Int>()
        
        subject.take(until: otherObservable)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposableBag)
        
        subject.onNext(1)
        subject.onNext(2)
        subject.onNext(3)
        otherObservable.onNext(99)
        subject.onNext(4)
    }
    
    private func testTakeWhile() {
        Observable.of(2, 2, 4, 4, 5)
            .enumerated()
            .take(while: { index, element in
                return element % 2 == 0 && index < 2
            })
            .map { $0.element }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposableBag)
    }
    
    private func testTake() {
        Observable.of("1", "2", "3", "4", "5")
            .take(2)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposableBag)
    }
    
    private func testSkipUntil() {
        let subject = PublishSubject<String>()
        let trigger = PublishSubject<String>()
        
        subject.skip(until: trigger)
            .subscribe(onNext: { print ($0) })
            .disposed(by: disposableBag)
        
        trigger.subscribe(onNext: { print($0) }).disposed(by: disposableBag)
        
        subject.onNext("X")
        subject.onNext("Y")
        trigger.onNext("trigger")
        subject.onNext("Z")
        
    }
    
    private func testSkipWhile() {
        Observable.of(2, 2, 2, 3, 5, 2, 6).skip(while: { $0 % 2 == 0 }).subscribe(onNext: { print($0) }).disposed(by: disposableBag)
    }
    
    private func testSkip() {
        Observable.of(1, 2, 3, 4, 5, 6, 7, 8).skip(3).subscribe(onNext: { print($0) }).disposed(by: disposableBag)
    }
    
    private func testFilter() {
        Observable.of(1, 2, 3, 4, 5, 6, 7, 8).filter { num in
            return num % 2 == 0
        }.subscribe(onNext: { print($0) }).disposed(by: disposableBag)
    }
    
    private func testElementAt() {
        let strikes = PublishSubject<String>()
        
        strikes.element(at: 0).subscribe(onNext: { elem in
            print(elem)
        }).disposed(by: disposableBag)
        
        strikes.onNext("#1")
        strikes.onNext("#2")
        strikes.onNext("#3")
        
    }
        
    private func testIgnoreElementsOperator() {
        let strikes = PublishSubject<String>()
        
        strikes.ignoreElements().subscribe(onCompleted: { print("You are out") }).disposed(by: disposableBag)
        
        strikes.onNext("X")
        strikes.onNext("X")
        strikes.onNext("X")
        strikes.onCompleted()
    }
    
    private func testObservable() {
        Observable.of(1, 2, 3).subscribe { event in
            print(event)
        }.disposed(by: disposableBag)
        
        Observable.just([1, 2, 3]).subscribe { event in
            print(event)
        }.disposed(by: disposableBag)
    }
    
    private func testBehaviorRelay() {
        let relay = BehaviorRelay(value: "first")
        
        let firstSubscription = relay.subscribe(onNext: { string in
            print("#1 subscription: \(string)")
        })
        
        relay.accept("Second")
        
        let secondSubscription = relay.subscribe(onNext: { string in
            print("#2 subscription: \(string)")
        })
        
        firstSubscription.disposed(by: disposableBag)
        secondSubscription.disposed(by: disposableBag)
        
        print(relay.value)
    }
    
    private func testReplaySubject() {
        let subject = ReplaySubject<String>.create(bufferSize: 3)
        subject.onNext("first")
        subject.onNext("Second")
        
        subject.subscribe(onNext: { string in
            print("#1 subscription: \(string)")
        }).disposed(by: disposableBag)
        
        subject.onNext("third")
        subject.onNext("fourth")
        
        subject.subscribe(onNext: { string in
            print("#2 subscription: \(string)")
        }).disposed(by: disposableBag)
    }
    
    private func testBehaviorSubject() {
        let subject = BehaviorSubject(value: "first")
        
        let firstSubscription = subject.subscribe(onNext: { string in
            print("#1 subscription: \(string)")
        })
        
        subject.onNext("Second")
        
        let secondSubscription = subject.subscribe(onNext: { string in
            print("#2 subscription: \(string)")
        })
        
        firstSubscription.disposed(by: disposableBag)
        secondSubscription.disposed(by: disposableBag)
        subject.disposed(by: disposableBag)
    }
    
    private func testPublishSubject() {
        let subject = PublishSubject<String>()
        
        let subscriptionOne = subject.subscribe(onNext: { string in
            print("One: \(string)")
        })
        
        let subscriptionTwo = subject.subscribe(onNext: { string in
            print("Two: \(string)")
        })
        
        let subscriptionThree = subject.subscribe { event in
            print(event)
        }
        
        subscriptionOne.disposed(by: disposableBag)
        subscriptionTwo.disposed(by: disposableBag)
        subscriptionThree.disposed(by: disposableBag)
        
        subject.onNext("Yes... yes...")
    }
}

