//
//  ImageAddViewController.swift
//  WooBoo_Project
//
//  Created by 이민우 on 2021/02/24.
//

import UIKit
import Photos

var imageViewStatus = [Int]()

// EditViewController에서 ViewController의 함수를 실행해서 데이터 전달하는 것
protocol AddImageDelegate { // Java의 Interface
    func didSelectedImage(_ controller : AddImageViewController, imageFileNames : [String], tempFileNames : [String], imageURL : [URL])
}

class AddImageViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    var delegate : AddImageDelegate? // 위에서 선언한 EditDelegate를 사용
    var selectNum = 0
    var imageFileNames = ["", "", "", "", ""]
    var tempFileNames = [String]()
    
    let imagePickerController = UIImagePickerController()
    var imageURL = [URL]()
    
    var clickImageNum = 0
    
    
    // Create left UIBarButtonItem.
    lazy var leftButton: UIBarButtonItem = { let button = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(back(_:)))
        button.tag = 1
        return button
        
    }()

    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var image5: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = leftButton
        
        imagePickerController.delegate = self

        setGestureRecognizer()
//        setDesign()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("받은 값 : ", selectNum)
        print("imageViewStatus : \(imageViewStatus)")
        print("imageViewStatus endIndex: \(imageViewStatus.startIndex), \(imageViewStatus[imageViewStatus.startIndex])")
//        print("imageViewStatus endIndex - 1 : \(imageViewStatus.endIndex - 1), \(imageViewStatus[imageViewStatus.endIndex - 1])")
        image1.image = UIImage(systemName: "photo")
        image2.image = UIImage(systemName: "photo")
        image3.image = UIImage(systemName: "photo")
        image4.image = UIImage(systemName: "photo")
        image5.image = UIImage(systemName: "photo")
        checkNullImage()
        setDesign()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
    }

    @IBAction func btnSave(_ sender: UIBarButtonItem) {
        if delegate != nil{
            delegate?.didSelectedImage(self, imageFileNames: imageFileNames, tempFileNames: tempFileNames, imageURL: imageURL)
        }
        navigationController?.popViewController(animated: true) // 가장 마지막에 뜬 화면을 사라지게 하기
    }
    @IBAction func btnClear(_ sender: UIBarButtonItem) {
        initImages()
    }
    
    // 뒤로가기
    @objc func back(_ sender : Any) {
        
        let alert = UIAlertController(title: "알림", message: "뒤로 이동 시 등록된 사진은 초기화됩니다.\n사진을 저장하실 거라면 저장 버튼을 눌러주세요.", preferredStyle: UIAlertController.Style.alert)
        let backAction = UIAlertAction(title: "뒤로 이동", style: UIAlertAction.Style.default, handler: { [self]ACTION in
            
            // Delete Image
            if tempFileNames.count != 0{
                if tempFileNames.count == 1{
                    print("지울값 1개")
                    ImageFileManager.shared.deleteImage(named: tempFileNames[0]) { onSuccess in
                        print("delete = \(onSuccess)")
                    }
                }else{
                    for i in 0..<tempFileNames.count{
                        print("지울값 어러개")
                        ImageFileManager.shared.deleteImage(named: tempFileNames[i]) { onSuccess in
                            print("delete = \(onSuccess)")
                        }
                    }
                }
                tempFileNames.removeAll()
                imageURL.removeAll()
                
                if delegate != nil{
                    print("값 전달하기!!!")
                    delegate?.didSelectedImage(self, imageFileNames: imageFileNames, tempFileNames: tempFileNames, imageURL: imageURL)
                }
            }
            
            self.navigationController?.popViewController(animated: true)
        })
        let cancelAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.default, handler: nil)
        
        alert.addAction(backAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
        
        print("뒤로가기")
        
        print("tempFileNames : \(tempFileNames)")
        
        
    }
    
    // 초기화함수
    func initImages(){
        imageURL.removeAll()
        
        print("초기화 확인 : \(imageFileNames)")
        
        image1.image = UIImage(systemName: "photo")
        image2.image = UIImage(systemName: "photo")
        image3.image = UIImage(systemName: "photo")
        image4.image = UIImage(systemName: "photo")
        image5.image = UIImage(systemName: "photo")
        
        print("다시 들어왔을 때 temp : \(tempFileNames)")
        
        // Delete Image
        if tempFileNames.count != 0{
            if tempFileNames.count == 1{
                print("지울값 1개")
                ImageFileManager.shared.deleteImage(named: tempFileNames[0]) { onSuccess in
                    print("delete = \(onSuccess)")
                }
            }else{
                for i in 0..<tempFileNames.count{
                    print("지울값 어러개")
                    ImageFileManager.shared.deleteImage(named: tempFileNames[i]) { onSuccess in
                        print("delete = \(onSuccess)")
                    }
                }
            }
            tempFileNames.removeAll()
            imageFileNames.removeAll()
            
            imageFileNames = ["", "", "", "", ""]
            
            print("배열 초기화 확인 1 : \(tempFileNames)")
            print("배열 초기화 확인 2 : \(imageFileNames)")
        }
    }
    
    // 이미지 배열 확인 함수
    func checkNullImage(){
        
        print("돌아온 배열값 : \(imageFileNames)")
  
        for i in 0..<imageFileNames.count{
            if imageFileNames[i] != ""{
                print(" i값 : \(i)")
                switch i{
                case 0:
                    print("test")
                    if let image: UIImage = ImageFileManager.shared.getSavedImage(named: imageFileNames[i]) {
                        image1.image = image
                    }
                case 1:
                    if let image: UIImage = ImageFileManager.shared.getSavedImage(named: imageFileNames[i]) {
                        image2.image = image
                    }
                case 2:
                    if let image: UIImage = ImageFileManager.shared.getSavedImage(named: imageFileNames[i]) {
                        image3.image = image
                    }
                case 3:
                    if let image: UIImage = ImageFileManager.shared.getSavedImage(named: imageFileNames[i]) {
                        image4.image = image
                    }
                default:
                    if let image: UIImage = ImageFileManager.shared.getSavedImage(named: imageFileNames[i]) {
                        image5.image = image
                    }
                }
            }
        }
    }
    
    // Set GestureRecognizer each buttons
    func setGestureRecognizer(){
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
        let tapGR2 = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped2))
        let tapGR3 = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped3))
        let tapGR4 = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped4))
        let tapGR5 = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped5))

        
        image1.addGestureRecognizer(tapGR)
        image2.addGestureRecognizer(tapGR2)
        image3.addGestureRecognizer(tapGR3)
        image4.addGestureRecognizer(tapGR4)
        image5.addGestureRecognizer(tapGR5)
  
    }
    
    @objc func imageTapped(sender: UITapGestureRecognizer) {
        print("1")
        showAlert(clickNum: 1)
    }
    
    @objc func imageTapped2(sender: UITapGestureRecognizer){
        print("2")
        showAlert(clickNum: 2)
    }
    
    @objc func imageTapped3(sender: UITapGestureRecognizer){
        print("3")
        showAlert(clickNum: 3)
    }
    
    @objc func imageTapped4(sender: UITapGestureRecognizer){
        print("4")
        showAlert(clickNum: 4)
    }
    
    @objc func imageTapped5(sender: UITapGestureRecognizer){
        print("5")
        showAlert(clickNum: 5)
    }

    func setDesign(){
        if imageViewStatus.count > 1{
            if imageViewStatus[imageViewStatus.index(before: imageViewStatus.endIndex)] != imageViewStatus[imageViewStatus.index(before: imageViewStatus.endIndex) - 1]{
                print("imageViewStatus : \(imageViewStatus[imageViewStatus.index(before: imageViewStatus.endIndex)]), \(imageViewStatus[imageViewStatus.index(before: imageViewStatus.endIndex) - 1])")
                initImages()
            }
        }
        
        image3.isHidden = true
        image4.isHidden = true
        image5.isHidden = true
    
        if selectNum == 3{
            image3.isHidden = false
        }
        
        if selectNum == 4{
            image3.isHidden = false
            image4.isHidden = false
        }
        
        if selectNum == 5{
            image3.isHidden = false
            image4.isHidden = false
            image5.isHidden = false
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
        
            // 파일명 뽑아내기
            print("이미지명 타입 : \(type(of: info.description))")
            print("이미지명 : \(info.description)")
            
            let fileDescription = info.description
            
            var index = 0
            if let rangeS = fileDescription.range(of: "tmp/") {
                index = fileDescription.distance(from: fileDescription.startIndex, to: rangeS.lowerBound)
                print("tmp/ 인덱스 : \(index)")
            }
   
            let firstIndex = fileDescription.index(fileDescription.startIndex, offsetBy: index + 4)
            let lastIndex = fileDescription.index(fileDescription.endIndex, offsetBy: -1)
            let beforeFileName = "\(fileDescription[firstIndex..<lastIndex])"
            
            print("realFileName : \(beforeFileName)")
            
            let realFileName = String(beforeFileName.split(separator: ".")[0] + ".jpeg")
            
            // 뒤로가기 할 경우 삭제하기 위함
            tempFileNames.append(realFileName)
            
            print("스플릿 : \(realFileName)")
            
            switch clickImageNum{
            case 1:
                image1.image = image
                imageFileNames[0] = realFileName
            case 2:
                image2.image = image
                imageFileNames[1] = realFileName
            case 3:
                image3.image = image
                imageFileNames[2] = realFileName
            case 4:
                image4.image = image
                imageFileNames[3] = realFileName
            default:
                image5.image = image
                imageFileNames[4] = realFileName
            }
            
            print("//////////////")
            print("이미지 배열값 : \(imageFileNames)")

            imageURL.append((info[UIImagePickerController.InfoKey.imageURL] as? URL)!)
            
            print("imageURL : \(String(describing: imageURL))")
        }
        // 켜놓은 앨범 화면 없애기
        dismiss(animated: true, completion: nil)
    }
    
    func openLibrary(){
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: false, completion: nil)
    }
    
    func openCamera(){

        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            imagePickerController.sourceType = .camera
            present(imagePickerController, animated: false, completion: nil)
        }
        else{
            print("Camera not available")
        }
    }
    
    func showAlert(clickNum : Int){
        let alert =  UIAlertController(title: "사진 추가", message: "사진 추가할 방법을 선택해주세요.", preferredStyle: .actionSheet)

        let library =  UIAlertAction(title: "사진앨범", style: .default) { [self] (action) in
            self.openLibrary()
            clickImageNum = clickNum
        }

        let camera =  UIAlertAction(title: "카메라", style: .default) { (action) in
        self.openCamera()

        }

        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)

        alert.addAction(library)
        alert.addAction(camera)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let fileUrl = info[UIImagePickerController.InfoKey.imageURL.rawValue] as? URL else { return }
        print(fileUrl.lastPathComponent)
    }

    
}
