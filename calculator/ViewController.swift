//
//  ViewController.swift
//  traning1
//
//  Created by fsi on 2020/07/02.
//  Copyright © 2020 none. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var equalButton: UIButton!

    var integerPart = 0 //整数値
    var decimalPart = 0 //小数部
    var outValue = 0.0 //計算後の値
    var isDesiminal = false //小数フラグ
    var oPerator = 0 //0 なし 1 + 2 - 3 * 4 /

    private let button = ["7","8","9","minus","4","5","6","plus","1","2","3","multiply","0","dot","ac","devide"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        resultLabel.text = integerPart.description
//        collectionView.isScrollEnabled = false
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }

    //cellの生成
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:button[indexPath.row], for:indexPath)
        return cell
    }

    //サイズ変更
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = (collectionView.layer.bounds.width - 10.0*8) / 4
        let height = (collectionView.layer.bounds.height - 10.0*8) / 4

        return CGSize(width: width, height: height)
    }

    //上下左右の余白
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }

    //タップされた場合の処理
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if Int(button[indexPath.row]) != nil {
            //数字入力の場合

            if !isDesiminal {
                //整数部入力
                integerPart = Int(button[indexPath.row])! + integerPart * 10
                resultLabel.text = integerPart.description

            } else {
                //小数部入力
                decimalPart = Int(button[indexPath.row])! + decimalPart*10
                resultLabel.text = integerPart.description + "." + decimalPart.description
            }
        } else {
            //数字以外の場合

            if button[indexPath.row] == "ac" {
                if integerPart == 0 && decimalPart == 0 {
                    outValue = 0
                    oPerator = 0
                }
                isDesiminal = false
                decimalPart = 0
                integerPart = 0
                resultLabel.text = "0"
            }

            if button[indexPath.row] == "dot" {
                isDesiminal = true
            }

            //演算子群
            if button[indexPath.row] == "plus" {
                calc()
                oPerator = 1
            }
            if button[indexPath.row] == "minus" {
                calc()
                oPerator = 2
            }
            if button[indexPath.row] == "multiply" {
                calc()
                oPerator = 3
            }
            if button[indexPath.row] == "devide" {
                calc()
                oPerator = 4
            }
        }

//        if integerPart.description.count > 16 || outValue.description.count > 16 {
//            resultLabel.text = "error: limit over"
//            return
//        }
    }

    func calc(){

        let inValue :Double

        if(decimalPart != 0){
            let strValue = (integerPart.description + "." + decimalPart.description)
            inValue = Double(strValue)!
        }else{
            inValue = Double(integerPart)
        }

        if oPerator == 0 {
            outValue = inValue
            integerPart = 0
        }
        if oPerator == 1 {
            outValue += inValue
        }
        if oPerator == 2 {
            outValue -= inValue
        }
        if oPerator == 3 {
            outValue *= inValue
        }
        if oPerator == 4 {
            if integerPart != 0 {
                outValue /= inValue
            } else {
                resultLabel.text = "error: devide by 0"
                return
            }
        }
        isDesiminal = false
        decimalPart = 0
        integerPart = 0
        resultLabel.text = outValue.description
    }

    @IBAction func tapEqualButton(_ sender: Any) {
        calc()
        oPerator = 0
    }

}

