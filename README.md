# 🏦 은행 창구 매니저

## 📖 목차
1. [소개](#-소개)
2. [Tree](#-tree)
3. [타임라인](#-타임라인)
4. [고민한 점](#-고민한-점)
5. [실행 화면](#-실행-화면)
6. [트러블 슈팅](#-트러블-슈팅)
7. [참고 링크](#-참고-링크)

## 🌱 소개

`Mangdi`와 `mene` 가 만든 은행 창구 매니저 앱입니다.
- 고객 대기열의 고객을 3명의 직원이 맡은 업무대로 처리합니다.
- **KeyWords**
  - `Data Type`
      - `Linked-list`, `Queue`
  - `Concurrency`
      - `GCD`, `sync`, `async`, `Thread`
  - `코드로 화면 그리기`

## 💻 개발환경 및 라이브러리
[![swift](https://img.shields.io/badge/swift-5.6-orange)]()
[![xcode](https://img.shields.io/badge/Xcode-13.4.1-blue)]()
[![sindresorhus's SwiftLint config](https://img.shields.io/badge/SwiftLint-0.49.1-green.svg)](https://github.com/realm/SwiftLint)

## 🧑🏻‍💻 팀원
|<img src="https://avatars.githubusercontent.com/u/49121469" width=160>|<img src = "https://avatars.githubusercontent.com/u/84453688?v=4" width=160>|
|:--:|:--:|
|[Mangdi](https://github.com/MangDi-L)|[Mene](https://github.com/JaeKimdev)|

## 🌲 Tree

```
── BankManagerUIApp
    ├── AppDelegate.swift
    ├── Base.lproj
    ├── Controller
    │   └── ViewController.swift
    ├── Info.plist
    ├── Model
    │   ├── Assets.xcassets
    │   │   ├── AccentColor.colorset
    │   │   │   └── Contents.json
    │   │   ├── AppIcon.appiconset
    │   │   │   └── Contents.json
    │   │   └── Contents.json
    │   ├── Bank.swift
    │   ├── Customer.swift
    │   ├── CustomerQueue.swift
    │   └── Node.swift
    ├── SceneDelegate.swift
    └── View
        └── Base.lproj
            ├── LaunchScreen.storyboard
            └── Main.storyboard
```
 
## ⏰ 타임라인

<details>
<summary>Step 1 타임라인</summary>
    
- **221031**
    - 코코아팟 설치 및 SwiftLint 라이브러리 적용 후 warning이 뜨지않도록 swiftLint rule 수정
    - Node & CustomerQueue 타입 구현하고 CustomerQueue Unit Test
    - Step1 PR 리뷰 요청
        - [PR보러가기](https://github.com/yagom-academy/ios-bank-manager/pull/218)

- **221101**
    - 리뷰 내용 반영하여 리팩토링
    - Node 타입의 front와 rear에 접근제어자 설정하고 테스트 코드 수정
    - CustomerQueue dequeue 메서드 조건문에 옵셔널 활용하도록 리팩토링

</details>
    
<details>
<summary>Step 2 타임라인</summary>   
    
- **221102**
    - Node & CustomerQueue 파일 ConsoleApp으로 복사
    - Customer타입 구현
    - BankManager의 selectMenu, addCustomer, processTask메서드 구현
    - 한번 실행한 후에 다시 1번을 선택했을 때 작동하지 않던 오류 수정
    - Bank와 BankManager의 역할분리 및 n명의 매니저가 대응하도록 수정
    - Step2 PR 리뷰 요청
        - [PR보러가기](https://github.com/yagom-academy/ios-bank-manager/pull/229)
    - 리뷰 내용 반영하여 리팩토링
    - Bank 타입의 addCustomer 메서드 forEach 사용하도록 리팩토링
    
</details>
 
<details>
<summary>Step 3 타임라인</summary>

- **221107**
    - Customer 타입에 고객 요구사항 `deposit`과 `loan` Enum으로 구현
    - Bank에서 BankManager 삭제하고 Semaphore를 이용하여 은행원 3명이 비동기로 업무를 처리하도록 구현
    - Bank에서 고객처리 시간을 측정하는 `processTime` 메서드 구현
    - Step3 PR 리뷰 요청
        - [PR보러가기](https://github.com/yagom-academy/ios-bank-manager/pull/243)
    - 리뷰 내용 반영하여 리팩토링

 </details>
 
 <details>
<summary>Step 4 타임라인</summary>

- **221109**
    - 이전 STEP에서 구현했던 ConsoleApp의 파일들을 UIApp으로 이동
    - 코드로 UI 구현
- **221110**
    - Bank타입에 10명의 customer를 추가해주는 `addTenCustomer` 메서드 구현
    - Bank의 고객 대기열을 비워주고 waitingNumber를 초기화 하는 `resetAll` 메서드 구현
    - CustomerQueue타입에서 대기열의 고객 배열을 반환하는 `takeAll` 메서드 구현
    - `displayWaitingCustomers` 메서드 구현
    - ScrollView에 추가할 customer 레이블을 생성하는 `makeCustomerLabel` 메서드 구현
    - `고객 추가` 버튼과 `초기화` 버튼에 `addTenCustomerButton`, `allClearButton` 메서드 생성하고 연결
    - 변경사항 UI 반영을 위해 Bank 타입의 메서드 ViewController로 이동
    - 고객 추가 버튼 클릭 시 waitingScrollView에 여러번 추가되던 오류 수정
- **221111**
    - 고객 추가 버튼 클릭 시 STEP3 에서 작성했던 Print문구가 다 출력 된 후 UI에 반영되던 문제 수정
    - UI상에 고객 처리 상태에 따라 대기중, 업무중 ScrollView로 이동하고 사라지도록 구현
  
 </details>
 
## 👀 고민한 점

### Step 1

- 맨처음 클론했을때 ios-bank-manager 폴더 안에 `BankManagerUIApp`과 `BankManagerConsoleApp` 폴더가 있었습니다. 이중에 어느 폴더로 Step1을 시작할지 고민했습니다.
    - 요구사항에 따로 Console을 이용해서 진행하라는 문구가 없었기 때문에 UIApp 프로젝트에 진행하였습니다.
- `SwiftLint` 설치 시, 어떤 패키지 매니저를 이용할지 고민했습니다.
    - `Swift Package Manage`로 라이브러리를 관리할까 생각했는데 호환성문제와 자잘한 버그들이 여전히 존재한다는 이야기를 들은 적이 있어서, 원조적이고 잘 작동하는 `CocoaPods`을 채택해서 사용했습니다.
- UItest 작성 시 `String Literal`을 제거하기 위해서 테스트 데이터를 상수로 선언하고 XCTAssertEqual로 비교할 때 사용해 주었습니다.

### Step 2

- Bank 타입에서 은행을 열었을 때 처리할 작업을 나타내는 메서드 네이밍을 `open`으로 하려고 하다가 `open`이 시스템 예약어라서 다른 이름을 사용하기 위해 `openUp`이라는 이름으로 설정해 주었습니다.
- UIApp에서 만들었던 파일을 ConsoleApp으로 가져오는 방법을 고민해 보았습니다.
- `BankManager` 타입의 `allocateCustomer `메서드에서 모든 고객을 처리한 후 처리시간이 노출될 때 소숫점 2자리까지만 노출되도록 `String(format: "%.2f")`을 적용해 주었습니다.

### Step 3

- 클로저의 캡쳐와 캡쳐리스트에 대해 고민하고 공부해보았습니다.
    - 클로저를 캡쳐하면 참조 / 값 타입에 상관없이 참조 타입으로 저장이 되고, 값 타입으로 사용하고 싶다면 캡쳐 리스트를 사용해서 저장해야 한다는 것을 새롭게 알게 되었습니다. 이 경우, 캡쳐 리스트에 캡쳐된 변수는 let으로 전달됩니다.

- 업무가 완전히 종료되기 전에 마감 메세지가 노출되는 문제를 해결하기 위해 고민해 보았습니다.

### Step 4

 - ViewController에서 Bank타입의 메서드가 UI관련 처리를 진행할수 없다보니 어떻게 해결해야할지 고민했습니다.
     - Bank에서 사용하는 메서드를 ViewController에서 정의해 주어서 UI관련 동시성 처리를 했습니다. 이로써 Bank관련된 메서드를 호출할 일이 없어졌기 때문에 파일을 삭제했습니다.

 - 긴 코드를 접어서 보는 방법이 좋을지 고민했습니다.
    
    🔥코드 접어서 보는 방법 `option + command + ⬅️`
    - 코드로 UI를 구현할때 view 하나 하나를 직접 코드로 작성해서 뷰 관련 코드가 길어지게 되었습니다. 
    ```swift
    let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    ...
    let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()
    ```
    접어두기 기능을 사용하면 구현한 UI요소들이 한눈에 들어오게됩니다.
    ![](https://i.imgur.com/zKTRBra.png)  

    안에 어떻게 구현되어있는지 보이지 않는 단점이 있지만 구현이 다 끝나 더이상 건드릴 필요가 없는 경우라면 이렇게 해주는것도 괜찮겠다는 생각이 들었습니다.

    접힌상태로 커밋하고 다른사람이 받아올 때에는 적용이 되지 않아, 자신에게만 유효한 기능같아요 😂

        
## 📱 실행 화면

|<img src = "https://i.imgur.com/QmFU5kM.gif)" width=640>|![](https://i.imgur.com/tPDmxV1.png)|![](https://i.imgur.com/Nis2Mpo.png)|
|:--:|:--:|:--:|
|대기열에 들어있는 고객을<br>순서대로 처리합니다|2번 선택시<br>프로그램 종료|예외 처리 |

## ❓ 트러블 슈팅

### Step 1

<details>
    <summary>`SwiftLint` 적용을 위해 코코아팟 설치 시 Ruby version문제로 설치되지 않았습니다.</summary>

![](https://camo.githubusercontent.com/3325a7de9480141339aa46fafb2e70068eb250812bc8aeb4a94b669f9251c0b9/68747470733a2f2f692e696d6775722e636f6d2f34666a4a4e61582e706e67)
    `xcode-select`도 이미 깔려있었고, `brew`를 이용해서도 권한 문제로 설치가 되지 않아 root 권한을 주고 Ruby 최신 버전을 설치해보려고 했지만 너무 위험하다는 메세지와 함께 설치가 되지 않았습니다. 모든 소프트웨어 업데이트와 `xcode-select` 재설치를 통해 해결하였습니다.
    
</details>

### Step 2

<details>
    <summary>UIApp에서 만들었던 파일을 ConsoleApp으로 가져오는 방법을 고민해 보았습니다.</summary>

<br>
UIApp에서 만든 Node, CustomerQueue파일을   
ConsoleApp으로 복사하기위해 파일을 끌어서 놨는데   
ConsoleApp의 Node, CustomerQueue파일의 내용을 변경할때 UIApp에서의   
Node, CustomerQueue내용이 같이 변경된다는 점을 발견했습니다.   
이를 해결하기 위해여 아래와 같이 진행했습니다.  
<img src="https://i.imgur.com/ZCu8pbB.png" width=400>  
finder에서 consoleApp폴더로 파일을 붙여넣기 한 상태로, finder에서는 붙여넣기한 파일들이 보이지만 아래 사진과 같이 Xcode에는 반영이 안된걸 알수있습니다.  
<img src="https://i.imgur.com/Livq2wW.png" width=400>  
(적용이 안된상태)  
<img src="https://i.imgur.com/7TRXOZx.png" width=600>  
finder에 추가한 파일들을 Xcode로 끌어다가 놓으면 이런 창이 뜨게 되는데, 
여기서 `Copy Items if needed`를 체크해주고 finish 버튼을 클릭하면  
<img src="https://i.imgur.com/fM0mOjf.png" width=400>  
파일이 잘 들어온걸 확인할 수 있었고 더이상 AppUI의 파일과 내용을 공유하지않았습니다.
    
</details>

### Step 3

<details>
    <summary>은행 업무를 처리하는 은행원을 어떻게 할당해 주어야 할지 고민해 보았습니다.</summary>
<br>
처음에는 BankManager 타입이 업무를 처리하는 은행원이라고 생각해서 3명의 BankManager를 생성하고 forEach문으로 은행 대기열에서 고객을 한명씩 배정해주는 방법으로 구현했습니다. 이러한 경우 대기열에 1,2,3번 고객이 모두 대출 고객인 경우 3명이 모두 할당이 된 상태에서 하나의 쓰레드만 사용 할 수 있었기 때문에 동시에 처리되지 않고 기다리게 되어 원하는 대로 구현이 되지 않았습니다. (예금은 2명, 대출은 1명이 처리)  

```swift
private mutating func allocateCustomer() {
    DispatchQueue.global().sync {
        while customerQueue.isEmpty == false {
            self.manager.forEach { manager in
                guard let customer = customerQueue.peek() else { return }
                manager.processTask(customer: customer)
                customerQueue.dequeue()
            }
        }
    }
}
```
    
이를 어떻게 처리해주어야 할까 고민하다가 세마포어에 대해 알게 되었고, 접근 가능한 스레스의 수를 설정해 줄 수 있어서 세마포어의 수가 은행원을 대체할 수 있지 않을까 라는 생각이 들었고 `depositSemaphore`와 `loanSemaphore`를 생성할 때 각각 2명 / 1명으로 설정해 주어서 처리해 주도록 변경하였습니다.

```swift
private mutating func allocateCustomer() {
    let group = DispatchGroup()
    let depositSemaphore = DispatchSemaphore(value: 2)
    let loanSemaphore = DispatchSemaphore(value: 1)
    
    while customerQueue.isEmpty == false {
        guard let customer = customerQueue.dequeue() else { return }
        if customer.requestingTask == .deposit {
            DispatchQueue.global().async(group: group) { [self] in
                depositSemaphore.wait()
                DispatchQueue.global().sync {
                    manager.processTask(customer)
                }
                depositSemaphore.signal()
            }
            
        } else {
            DispatchQueue.global().async(group: group) { [self] in
                loanSemaphore.wait()
                DispatchQueue.global().sync {
                    manager.processTask(customer)
                }
                loanSemaphore.signal()
            }
        }
    }
}
```
    
</details>

<details>
    <summary>업무가 완전히 종료되기 전에 마감 메세지가 노출되는 문제 방법을 고민해 보았습니다.</summary>
    
 - DispatchGroup를 사용하지 않고 작성 시, 업무배정이 완료되면 마감 메세지가 먼저 노출되는 문제가 있어, DispatchGroup의 wait 메서드를 이용하여 모든 작업이 완료된 후 노출되도록 하였습니다.

|![](https://i.imgur.com/W0DVGfN.png)|![](https://i.imgur.com/nRsrBa6.png)|
|:--:|:--:|
|수정 전|수정 후|

</details>

### Step 4

- STEP3 에서 구현해 두었던 print문이 다 찍히고 처리가 완료된 후에 UI `대기중` 스크롤 뷰에 추가되는 문제를 해결하기 위해 고민해 보았습니다.
    - main, global, sync, async 개념에 대해 다시 한번 확인하고 처리
    - 이전 스탭에서 완료메세지가 먼저 노출되는 문제 때문에 걸어두었던 group.wait를 확인하고 제거
- 대기중에 있던 고객 레이블을 빼서 업무중에 넣어주는 방법에 대해 고민해 보았습니다.
    - 고객 레이블 생성 시, tag를 달아주어 작업이 완료된 레이블인지 확인하고 제거
- 타이머 구현 후, 어느 시점에 resume, suspend를 호출해야 하는지 고민해 보았습니다.

## 🔗 참고 링크

[Swift Language Guide - Concurrency](https://docs.swift.org/swift-book/LanguageGuide/Concurrency.html)  
[Concurrency Programming Guide](https://developer.apple.com/library/archive/documentation/General/Conceptual/ConcurrencyProgrammingGuide/Introduction/Introduction.html)  
[WWDC2016 - Concurrent Programming With GCD in Swift 3](https://developer.apple.com/videos/play/wwdc2016/720/)  
[야곰 닷넷 - 동시성 프로그래밍](https://yagom.net/courses/%eb%8f%99%ec%8b%9c%ec%84%b1-%ed%94%84%eb%a1%9c%ea%b7%b8%eb%9e%98%eb%b0%8d-concurrency-programming/)  
[야곰 닷넷 - 오토 레이아웃 정복하기](https://yagom.net/courses/autolayout/)  

---

[🔝 맨 위로 이동하기](#-은행-창구-매니저)
