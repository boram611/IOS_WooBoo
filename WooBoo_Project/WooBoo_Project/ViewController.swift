//
//  ViewController.swift
//  WooBoo_Project
//
//  Created by ssemm on 2021/02/22.
//

import UIKit

class ViewController: UIViewController, Get_MyQuestions, Get_NewQuestions {
 
    
  

    @IBOutlet weak var lblHot: UIButton!
    @IBOutlet weak var hotPageControl: UIPageControl!
    @IBOutlet weak var lblNew: UIButton!
    @IBOutlet weak var newPageControl: UIPageControl!
    
    @IBOutlet weak var hotBack: UIView!
    @IBOutlet weak var newBack: UIView!
    
    var feedItem: NSMutableArray = NSMutableArray()
    var hotItem: NSMutableArray = NSMutableArray()
    
//    var numcount = 5
//
//    // 받아올 값을 담아둘 변수 설정
//    var receiveTitle = ""
//
//    // 이미지
//    var  numImage:Int = 0
    
    // 시간
    let interval = 3.0 // 3초
    let timeSelector: Selector = #selector(ViewController.updateTime)
    var timer = Timer()
    
    //new
    var titleName = ["", "", ""]
    var numNewTitle = 0
    var newSeqno: [String] = ["", "", ""]
    
    // hot
    var hotTitle = ["", "", ""]
    var numHotTitle = 0
    var hotSeqno: [String] = ["", "", ""]

    override func viewDidLoad() {
            super.viewDidLoad()

        // 보람 추가
        
        //핫
//        let hotModel = panHot()
//        hotModel.delegate = self
//        hotModel.downloadItems()
        
        hotBack.layer.cornerRadius = 25
        newBack.layer.cornerRadius = 25
        

        }
    
    
    override func viewWillAppear(_ animated: Bool) {
        let selectModel = LMW_SelectModel()
        selectModel.delegate7 = self
        selectModel.delegate8 = self
        selectModel.downloadItems(funcName: "select_MyQuestions", urlPath: "http://127.0.0.1:8080/ios_jsp/wooboo_Hot.jsp")
        selectModel.downloadItems(funcName: "select_NewQuestions", urlPath: "http://127.0.0.1:8080/ios_jsp/wooboo_query_ios.jsp")
        
        titleHot(number: numHotTitle)
        
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelector, userInfo: nil, repeats: true)
        
        hotPageControl.numberOfPages = 3
        hotPageControl.currentPage = 0
        

    
        NewTitle(number: numNewTitle)

        
        newPageControl.numberOfPages = 3
        newPageControl.currentPage = 0
    }
    
    // 2021-03-05 민우
    override func viewDidDisappear(_ animated: Bool) {
        timer.invalidate()
        
        numNewTitle = 0
        newPageControl.currentPage = 0
        
        numHotTitle = 0
        hotPageControl.currentPage = 0
        
        if feedItem.count > 2 && hotItem.count > 2{
            lblHot.setTitle(hotTitle[hotPageControl.currentPage], for: UIControl.State.normal)
            lblNew.setTitle(titleName[newPageControl.currentPage], for: UIControl.State.normal)
        }
        
        

    }

    // 2021-03-05 민우
    func return_NewQuestions(NewQuestions: NSArray) {
        
        feedItem = NewQuestions as! NSMutableArray
        print("feedItem.count : \(feedItem.count)")
        if feedItem.count > 2{
            loadDataNew()
        }
        
    }
    

    // 2021-03-05 민우
    func return_MyQuestions(myQuestions: NSArray) {
        hotItem = myQuestions as! NSMutableArray
    
        print("hotItem.count : \(hotItem.count)")
        if hotItem.count > 2{
            loadDataHot()

        }
    }
    

    // 보람 추가
    func loadDataNew(){
    
//        titleName.remove(at: 0)
//        newSeqno.remove(at: 0)
        
        for i in 0..<feedItem.count{
            let item: categoryDBModel = feedItem[i] as! categoryDBModel
            titleName[i] = item.qTitle!
            newSeqno[i] = item.qSeqno!
        }

//        let item: categoryDBModel = feedItem[0] as! categoryDBModel
//        titleName[0] = item.qTitle!
//        newSeqno[0] = item.qSeqno!
//
//
//        let item2: categoryDBModel = feedItem[1] as! categoryDBModel
//        titleName[1] = item2.qTitle!
//        newSeqno[1] = item2.qSeqno!
//
//
//        let item3: categoryDBModel = feedItem[2] as! categoryDBModel
//        titleName[2] = item3.qTitle!
//        newSeqno[2] = item3.qSeqno!


        print(titleName)
        print(newSeqno)


    }
    
    func loadDataHot(){
    
//        hotTitle.remove(at: 0)
//        hotSeqno.remove(at: 0)
        
        for i in 0..<hotItem.count{
            let item: categoryDBModel = hotItem[i] as! categoryDBModel
            hotTitle[i] = item.qTitle!
            hotSeqno[i] = item.qSeqno!
        }
        
//        let item: categoryDBModel = hotItem[0] as! categoryDBModel
//        hotTitle[0] = item.qTitle!
//        hotSeqno[0] = item.qSeqno!
//
//        let item2: categoryDBModel = hotItem[1] as! categoryDBModel
//        hotTitle[1] = item2.qTitle!
//        hotSeqno[1] = item2.qSeqno!
//
//        let item3: categoryDBModel = hotItem[2] as! categoryDBModel
//        hotTitle[2] = item3.qTitle!
//        hotSeqno[2] = item3.qSeqno!
        
        print("loadDataHot : ", hotTitle)
        print("loadDataHot : ", hotSeqno)

    }
    
    
    func NewTitle(number : Int)  {
        
        lblNew.setTitle(titleName[number], for: UIControl.State.normal)
    }
    
    func titleHot(number : Int)  {
        
        lblHot.setTitle(hotTitle[number], for: UIControl.State.normal)
    }
    
    // Async Task 3초마다 글씨 변경
    @objc func updateTime(){
        
        if Int(interval) % 3 == 0 {
            
            numNewTitle += 1
            newPageControl.currentPage += 1
            
            numHotTitle += 1
            hotPageControl.currentPage += 1
            
            if numNewTitle >= titleName.count{
                numNewTitle = 0
                newPageControl.currentPage = 0
                
                numHotTitle = 0
                hotPageControl.currentPage = 0
                
            }
            
            if feedItem.count > 2{
                NewTitle(number: numNewTitle)
            }
            
            if hotItem.count > 2{
                titleHot(number: numHotTitle)
            }
            

        }
    }
    
    // hot글로 이동
    @IBAction func moveHot(_ sender: UIButton) {
        //ContentDetailViewController
   
    }
    
    @IBAction func moveNew(_ sender: UIButton) {
    }
    
    
    
            
    @IBAction func hotChange(_ sender: UIPageControl) {
        lblHot.setTitle(hotTitle[hotPageControl.currentPage], for: UIControl.State.normal)
        makeSingleTouch()
        
    }
    
    @IBAction func newChange(_ sender: UIPageControl) {
        lblNew.setTitle(titleName[newPageControl.currentPage], for: UIControl.State.normal)
        makeSingleTouch()
    }
    
   
    // 한 손가락 Gesture 구성
    func makeSingleTouch(){
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGesture(_ :)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGesture(_ :)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
    }

    @objc func respondToSwipeGesture(_ gesture: UIGestureRecognizer){
        if let swipeGesture = gesture as? UISwipeGestureRecognizer{

//            lblNew.setTitle(titleName[newPageControl.currentPage], for: UIControl.State.normal)
//            lblHot.setTitle(hotTitle[hotPageControl.currentPage], for: UIControl.State.normal)

            // 어떤 제스쳐가 들어왔는지 판단
            switch swipeGesture.direction{
            case UISwipeGestureRecognizer.Direction.left:
                newPageControl.currentPage -= 1
                lblNew.setTitle(titleName[newPageControl.currentPage], for: UIControl.State.normal)
                hotPageControl.currentPage -= 1
                lblNew.setTitle(titleName[newPageControl.currentPage], for: UIControl.State.normal)

            case UISwipeGestureRecognizer.Direction.right:
                newPageControl.currentPage += 1
                lblNew.setTitle(titleName[newPageControl.currentPage], for: UIControl.State.normal)
                hotPageControl.currentPage += 1
                lblNew.setTitle(titleName[newPageControl.currentPage], for: UIControl.State.normal)
            default:
                break
            }
        }
    }
    
    // 2021-03-05 민우
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepare")
        if segue.identifier == "MoveDetailFromHot"{
            let detailView = segue.destination as! ContentDetailViewController
            
            //let item: Students = studentsList[(indexPath! as NSIndexPath).row]
            let item: categoryDBModel = hotItem[hotPageControl.currentPage] as! categoryDBModel // 스튜던트 리스트에서 값을 가져온다
            
            print("hotPageControl.currentPage : \(hotPageControl.currentPage)")

            let qSeqno = item.qSeqno!
            let user_uSeqno = item.user_uSeqno!
            let qTitle = item.qTitle!
            let qSelection1 = item.qSelection1!
            let qSelection2 = item.qSelection2!
            let qSelection3 = item.qSelection3!
            let qSelection4 = item.qSelection4!
            let qSelection5 = item.qSelection5!
            let qCategory = item.qCategory!
            let qInsertDate = item.qInsertDate!
            let qDeleteDate = item.qDeleteDate!
            let qImageFileName1 = item.qImageFileName1!
            let qImageFileName2 = item.qImageFileName2!
            let qImageFileName3 = item.qImageFileName3!
            let qImageFileName4 = item.qImageFileName4!
            let qImageFileName5 = item.qImageFileName5!
            print("ViewController qSeqno : \(qSeqno)")
            
            // detailView에서 받는걸 해줘야 사용 가능
            detailView.receiveItems(qSeqno, user_uSeqno, qTitle, qSelection1, qSelection2, qSelection3, qSelection4, qSelection5, qCategory, qInsertDate, qDeleteDate, qImageFileName1, qImageFileName2, qImageFileName3, qImageFileName4, qImageFileName5)
        }
        
        if segue.identifier == "MoveDetailFromNew"{
            let detailView = segue.destination as! ContentDetailViewController
            
            //let item: Students = studentsList[(indexPath! as NSIndexPath).row]
            let item: categoryDBModel = feedItem[newPageControl.currentPage] as! categoryDBModel // 스튜던트 리스트에서 값을 가져온다
            
            print("newPageControl.currentPage : \(newPageControl.currentPage)")

            let qSeqno = item.qSeqno!
            let user_uSeqno = item.user_uSeqno!
            let qTitle = item.qTitle!
            let qSelection1 = item.qSelection1!
            let qSelection2 = item.qSelection2!
            let qSelection3 = item.qSelection3!
            let qSelection4 = item.qSelection4!
            let qSelection5 = item.qSelection5!
            let qCategory = item.qCategory!
            let qInsertDate = item.qInsertDate!
            let qDeleteDate = item.qDeleteDate!
            let qImageFileName1 = item.qImageFileName1!
            let qImageFileName2 = item.qImageFileName2!
            let qImageFileName3 = item.qImageFileName3!
            let qImageFileName4 = item.qImageFileName4!
            let qImageFileName5 = item.qImageFileName5!
            print("ViewController qSeqno : \(qSeqno)")
            
            // detailView에서 받는걸 해줘야 사용 가능
            detailView.receiveItems(qSeqno, user_uSeqno, qTitle, qSelection1, qSelection2, qSelection3, qSelection4, qSelection5, qCategory, qInsertDate, qDeleteDate, qImageFileName1, qImageFileName2, qImageFileName3, qImageFileName4, qImageFileName5)
        }
        
    
    
    }
    
}//====

